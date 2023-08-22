clc;
close all;
clear all;

%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

x= [1 0 1 0 1 0 1 0 1];     % Input Signal
bp = 0.000001;              % Bit period bp=1/1000000
disp('Binary Information at transmitter');
disp(x);

%Representation of Transmitting binary information as digital signal
bit=[];
for n=1:1:length(x)
    if x(n)==1
        se=ones(1,100);                          % Set 1 for 100 times 
    else
         se=zeros(1,100);                        % Set 0 for 100 times 
    end
    bit=[bit se];
end

t1=bp/100:bp/100:100*length(x)*(bp/100);         % Time Duration set up for input signal
subplot(3,1,1)
plot(t1,bit,'linewidth',2);                      % Linewidth 2 for clear visualization
grid on;
axis([0 bp*length(x) -0.5 1.5]);                 % Axis set-up
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Transmitting Information as Digital Signal');

%Binary PSK Modulation
A=5;                              % Amplitude A
br=1/bp;
f=br*2;                           % Frequency f
t2=bp/99:bp/99:bp;                % Time for Modulated signal
ss=length(t2);
m=[];
for i=1:1:length(x)
    if x(i)==1
        y=A*cos(2*pi*f*t2);       % Sinusoidal signal for 1 bit
    else 
        y=A*cos(2*pi*f*t2+pi);    % A*cos(2*pi*f*t+pi) means -A*cos(2*pi*f*t)
    end
    m=[m y];
end

t3=bp/99:bp/99:bp*length(x);              % Time Duration set up for Modulated
subplot(3,1,2);
plot(t3,m);
grid on;
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Waveform for binary PSK Modulation Corresponding Binary Information');

%Binary PSK Demodulation
mn=[];
for n=ss:ss:length(m)
    t=bp/99:bp/99:bp;
    y=cos(2*pi*f*t);    
    mm=y.*m((n-(ss-1)):n);
    %t4=bp/99:bp/99:bp;
    z=trapz(t,mm);    
    zz=round((2*z/bp));   
    if(zz>0)
        a=1;
    else
        a=0;
    end
    mn=[mn a];
end

disp('Binary Information at Receiver');
disp(mn);

%Representation of Binary Data Into Digital Signal
bit=[];
for n=1:length(mn)
    if mn(n)==1
        se=ones(1,100);                          % Set 1 for 100 times 
    else         
        se=zeros(1,100);                         % Set 0 for 100 times 
    end
    bit=[bit se];
end
t4=bp/100:bp/100:100*length(mn)*(bp/100);        % Time Duration set up for Demodulation
subplot(3,1,3);
plot(t4,bit,'linewidth',2);                      % Linewidth 2 for clear visualization
grid on;
axis([0 bp*length(mn) -0.5 1.5]);                % Axis set-up
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Received Information as Digital Signal');



