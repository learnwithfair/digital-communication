%Unipolar Non Return to Zero Line Coding 
clc;
clear all;
close all;
    
%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

n = [0 1 1 0 1 0 0 1];      %Input Signal
N=length(n);                %Number of Bits

%Mapping Function
for m=1:N
 if n(m)==1
    nn(m)=1;
 else
    nn(m)=0;                % Assign 0 for Unipolar
 end
end
nn;

%Signal Shaping
i=1;
t=0:0.01:length(n);         %Time Duration set up for a single binary bit
for j=1:length(t)
 if t(j)<=i
    y(j)=nn(i);             %Assign value from the mapping function
 else
     y(j)=nn(i);
     i=i+1;                 %Binaty input data index increament
 end
end
plot(t,y, 'linewidth',2);  %Linewidth 2 for clear visualization
axis([0,N,-1.5,1.5]);      %Axis set-up
grid on;
title("Unipolar NZR Signaling");