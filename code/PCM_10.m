 clc
close all
clear all
a=4;
fm=2;
fs=100*fm;
t=0:1/fs:1;%for sampling
x=a*sin(2*pi*fm*t);%let us take one simple sin signla for Pulse code modulation
figure(1)
subplot(3,1,1);
plot(t,x);
xlabel('time');
ylabel('amplitude');
title('Original message signal');
subplot(3,1,2);
stem(t,x);
xlabel('time');
ylabel('amplitude');
title('Sampled message signal');
enc=[];

for(i=1:length(x))
 if (x(i)>0 && x(i)<=1)
 e=[1 0 0];
 xq(i)=0.5;
 elseif (x(i)>1 && x(i)<=2)
 e=[1 0 1];
 xq(i)=1.5;
 elseif (x(i)>2 && x(i)<=3)
 e=[1 1 0];
 xq(i)=2.5;
 elseif (x(i)>3 && x(i)<=4)
 e=[1 1 1];
 xq(i)=3.5;
 elseif (x(i)>-4 && x(i)<=-3)
 e=[0 0 0];
 xq(i)=-3.5;
 elseif (x(i)>-3 && x(i)<=-2)
 e=[0 0 1];
 xq(i)=-2.5;
 elseif (x(i)>-2 && x(i)<=-1)
 e=[0 1 0];
 xq(i)=-1.5;
 else (x(i)>-1 && x(i)<=0)
 e=[0 1 1];
 xq(i)=-0.5;
 end
 enc=[enc e];
 end
 subplot(3,1,3);
 plot(t,xq,'b');
 title('Quantised signla');

% decoding(Receiver section)


 X_Q=[];
 for i=1:3:length(enc)-2
 if(enc(i)==0 && enc(i+1)==0 && enc(i+2)==0)
 x_q=-3.5;
 elseif(enc(i)==0 && enc(i+1)==0 && enc(i+2)==1)
 x_q=-2.5;
 elseif(enc(i)==0 && enc(i+1)==1 && enc(i+2)==0)
 x_q=-1.5;
 elseif(enc(i)==0 && enc(i+1)==1 && enc(i+2)==1)
 x_q=-0.5;
 elseif(enc(i)==1 && enc(i+1)==0 && enc(i+2)==0)
 x_q=0.5;
 elseif(enc(i)==1 && enc(i+1)==0 && enc(i+2)==1)
 x_q=1.5;
 elseif(enc(i)==1 && enc(i+1)==1 && enc(i+2)==0)
 x_q=2.5;
 elseif(enc(i)==1 && enc(i+1)==1 && enc(i+2)==1)
 x_q=3.5;
 end
 X_Q=[X_Q x_q];
 end
 figure(2)
 subplot(2,1,1);
 plot(t,X_Q);
 title('Decoded signal');
 [num,den]=butter(6,4*fm/fs);
 recon=filter(num,den,X_Q);
 subplot(2,1,2);
 plot(t,recon);
 title('Reconstructed signal in the receiver');
