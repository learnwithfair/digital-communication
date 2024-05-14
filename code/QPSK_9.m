%QPSK waveform generation
clc;
clear all; 
close all;

%x = randi([0,1],1,10);
x = [0 1 0 1 1 1 0 0 1 1]; 
%Bits to polar
for i=1:length(x)
    if x(i)==0
        p(i)=-1;
    else
        p(i)=1;
    end
end
%separation of even and odd sequence
even_seq= p(1:2:length(x));
odd_seq=p(2:2:length(x));

%NRZ polar line coder signal generation
i=1;
t=0:0.01:length(x); 
m=2:2:length(x);
for j=1:length(t)
    if t(j)<=m(i)
        even_ps(j)=even_seq(i);
    else
        even_ps(j)=even_seq(i);
        i=i+1;
    end
end
i=1;
m=2:2:length(x);
for j=1:length(t)
    if t(j)<=m(i)
        odd_ps(j)=odd_seq(i);
    else
        odd_ps(j)=odd_seq(i);
        i=i+1;
    end
end
figure(1)


subplot(2,1,1);
plot(t,even_ps);
axis([0 10 0 1.5]);
title('NRZ Polar line Even Coded Signal');
xlabel('Time')
ylabel('Amplitude')
grid on;

subplot(2,1,2);
plot(t,odd_ps);
axis([0 10 0 1.5]);
xlabel('Time')
ylabel('Amplitude')
title('NRZ Polar line Odd Coded Signal')
grid on;


%carrier signals generation
c1=cos(2*pi*1*t);
c2=sin(2*pi*1*t);

figure(2)
subplot(211);
plot(t,c1);
xlabel('Time')
ylabel('Amplitude')
title('Cosine Carrier Signal')

subplot(212)
plot(t,c2);
xlabel('Time')
ylabel('Amplitude')
title('Sine Carrier Signal')

%QPSK waveform generation
r1=even_ps.*c1;
r2=odd_ps.*c2;
qpsk_sig=r1-r2;

figure(3)
subplot(3,1,1)
plot(t,r1);
xlabel('Time')
ylabel('Amplitude')
title('Even Signal')

subplot(3,1,2)
plot(t,r2);
xlabel('Time')
ylabel('Amplitude')
title('Odd Signal')

subplot(3,1,3);
plot(t,qpsk_sig);
xlabel('Time')
ylabel('Amplitude')
title('QPSK Modulated Signal')

figure(4)

stem(x,'linewidth',2) 
title('Information after Receiveing ');
axis([0 11 0 1.5]), grid on;






