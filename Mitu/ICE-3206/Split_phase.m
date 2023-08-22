%Split Phase-Manchester Coding
clc;
clear all;
close all;
N=10; %Number of bits
n=randi([0,1],1,N) %Random bit generation
%Binary to Manchester Conversion
nnn=[];
for m=1:N
 if n(m)==1
 nn=[1 -1];
 else
 nn=[-1 1];
 end
 nnn=[nnn nn];
end 
nnn
%Manchester Coding Pulse Shaping
i=1;
l=0.5;
t=0:0.01:length(n);
for j=1:length(t)
 if t(j)<=l %Condition for the first half cycle
 y(j)=nnn(i); %Assign first 50 values for 
 else 
 y(j)=nnn(i);
 i=i+1;
 l=l+0.5;
 end
end
plot(t,y,'lineWidth', 2); %Linewidth 2 for clear visualization
axis([0,N,-1.5,1.5]); %Axis set-up
grid on;
title('Manchester Coding');