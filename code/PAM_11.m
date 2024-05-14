clc;
clear all;
close all;
fc=100;                              % Carrier Frequency
fm=fc/10;
fs=100*fc;                           % Sample Frequency
t=0:1/fs:4/fm;

% Message Signal
mt=cos(2*pi*fm*t);                   % Message signal Generating          
subplot(4,1,1);
plot(t,mt);
grid on;
title('Message Signal');
xlabel('Time Period');
ylabel('Amplitude');

% Carrier Signal
ct=0.5*square(2*pi*fc*t)+0.5;       % Carrier signal Generating
subplot(4,1,2);
plot(t,ct);
grid on;
title('Carrier Signal');
xlabel('Time Period');
ylabel('Amplitude');

% Modulated Signal of double side band
st=mt.*ct;                         % Modulated signal Generating
subplot(4,1,3);
grid on;
plot(t,st);
title('Modulated Signal of Double Side Band');
xlabel('Time Period');
ylabel('Amplitude');

%single sided PAM
tt=[ ];                            % PAM signal Generating
for i=1:length(st)
    if st(i)==0
        tt=[tt,st(i)];
    else
        tt=[tt,st(i)+2];
    end
end
subplot(4,1,4);
plot(t,tt);
title('PAM Signal of Single Side Band');
xlabel('Time Period');
grid on;
ylabel('Amplitude');

%demdulated
figure(2)
d=st.*ct;
filter=fir1(200,fm/fs,'low');
original_t_signal=conv(filter,d);
t1=0:1/(length(original_t_signal)-1):1;
subplot(4,1,1);
plot(t1,original_t_signal);
title('Demodulated Signal');
xlabel('Time Period');
ylabel('Amplitude');