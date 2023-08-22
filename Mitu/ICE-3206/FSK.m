clc;
close all;
clear all;
x=[1 1 0 1 0 1];
bp=0.000001;
disp('Binary Information at transmitter');
disp(x);

%Representation of Transmitting binary information as digital signal
bit=[];
for n=1:1:length(x)
    if x(n)==1
        se=ones(1,100);
    else
         x(n)==0
        se=zeros(1,100);
    end
    bit=[bit se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);

subplot(311)
plot(t1,bit,'linewidth',2.5);
grid on;

axis([0 bp*length(x) -0.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Transmitting Information as Digital Signal');

%Binary FSK Modulation
A=5;
%A2=5;
br=1/bp;
f1=br*8; 
f2=br*2; 
t2=bp/99:bp/99:bp;
ss=length(t2);
m=[];
for(i=1:1:length(x))
    if x(i)==1
        y=A*cos(2*pi*f1*t2);
    else 
        y=A*cos(2*pi*f2*t2);
    end
    m=[m y];
end

t3=bp/99:bp/99:bp*length(x);
subplot(312)
plot(t3,m);
grid on;
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Waveform for binary FSK Modulation Corresponding Binary Information');

%Binary FSK Demodulation
mn=[];
for n=ss:ss:length(m)
    t=bp/99:bp/99:bp;
    y1=cos(2*pi*f1*t);
    y2=cos(2*pi*f2*t);
    mm=y1.*m((n-(ss-1)):n);
    mmm=y2.*m((n-(ss-1)):n);
    t4=bp/99:bp/99:bp;
    z1=trapz(t4,mm);
    z2=trapz(t4,mmm);
    zz1=round((2*z1/bp));
     zz2=round((2*z1/bp));
    if(zz1>A/2)
        a=1;
    else(zz2>A/2)
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
        se=ones(1,100);
    else
         
        se=zeros(1,100);
    end
    bit=[bit se];
end
t4=bp/100:bp/100:100*length(mn)*(bp/100);

subplot(313);
plot(t4,bit,'linewidth',2.5);
grid on;

axis([0 bp*length(mn) -0.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Received Information as Digital Signal');



