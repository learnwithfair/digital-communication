%Polar Non Return to Zero Line Coding 
clc;
clear all;
close all;
N=10;
%Number of bits
n=randi([0,1],1,N); %Random bit generation
%Mapping Function
for m=1:N
   if n(m)==1
 nn(m)=1;
  else
  nn(m)=-1;
  end
end
nn
%Signal Shaping
i=1;
t=0:0.01:length(n); %100 Times duration set up for a single binary bit
for j=1:length(t) %Indexing set-up for time duration
  if t(j)<=i %Binary input data index Check-up Condition
 y(j)=nn(i); %Assign value from the mapping function
  else
 y(j)=nn(i);
 i=i+1;
%Binary input data index increment
 end
end
plot(t,y, 'linewidth',2);
axis([0,N,-1.5,1.5]); %Axis set-up
grid on;
title('Polar NZR Signaling');