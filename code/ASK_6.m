clc;
clear all;
close all;
%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

x= [1 0 1 0 1 0 1 0 1];     % Input Signal
bp=0.000001;                % Bit period bp=1/1000000
disp('Binary Information at transmitter');
disp(x);

%Representation of Transmitting binary information as digital signal
bit=[];
for n=1:1:length(x)
    if x(n)==1
        se=ones(1,100);     %Set up 100 times 0
    else
        se=zeros(1,100);    %Set up 100 times 1
    end
    bit=[bit se];
end

t1=bp/100:bp/100:100*length(x)*(bp/100);      % Time Duration set up for input signal
subplot (3,1,1); 
plot (t1, bit, 'linewidth', 2);               % Linewidth 2 for clear visualization
grid on;
axis([0 bp*length(x) -0.5 1.5]);              % Axis set-up
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Transmitting Information as Digital Signal');

%Binary ASK Modulation
A1=10;                          % Amplitude for 1 bit
A2=5;                           % Amplitude for 0 bit
br=1/bp;
f=br*10;                        % Frequency f = 10000000
t=bp/99:bp/99:bp;               % Time t
ss=length(t);
m=[];
for i=1:length(x)
    if x(i)==1
        y=A1*cos(2*pi*f*t);     %Sinusoidal signal for 1 bit
    else
        y=A2*cos(2*pi*f*t);     %Sinusoidal signal for 0 bit
    end
    m=[m y];
end
t3=bp/99:bp/99:bp*length(x);    %Time Duration set up for binary ASK Modulation
subplot (3,1,2);
plot (t3,m);
grid on;
xlabel('Time (sec) ');
ylabel('Amplitude (volt)');
title('Waveform for binary ASK Modulation corresponding binary information');

%Binary ASK Demodulation
mn=[];
for n=ss:ss:length(m)
    y=cos(2*pi*f*t);
    mm=y.*m((n-(ss-1)):n);     
    z=trapz(t, mm);    % computes the approximate integral of t4 via the trapezoidal method
                       % with respect to the scalar spacing specified by X
    zz=round((2*z/bp));
    if (zz>7.5)
        a=1;
    else
        a=0;
    end
    mn=[mn a];
end
disp('Binary Information at Receiver');
disp (mn);

%Represntation of Binary data into Digital signal
bit=[];
for n=1:length (mn)
    if mn(n)==1
        se=ones(1,100);         %Set up 100 times 1
    else
        se=zeros(1,100);        %Set up 100 times 0
    end
    bit=[bit se];
end

t4=bp/100:bp/100:100*length(mn)*(bp/100);    % Time Duration set up for binary ASK Demodulation
subplot(3,1,3);
plot(t4, bit, 'linewidth', 2);               % Linewidth 2 for clear visualization
grid on;
axis([0 bp*length(mn) -0.5 1.5]);            %Axis set-up
xlabel('Time (sec) ');
ylabel('Amplitude (volt)');
title('Received information as Digital Signal');