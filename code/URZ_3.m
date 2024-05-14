%Unipolar Return To Zero (RZ) line coding
clc;
clear all;
close all;
%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

n = [0 1 1 0 1 0 0 1];      %Input Signal
N=length(n);                %Number of Bits

%Unipolar RZ Pulse Shaping
i=1;
a=0;                        %Initial value for first half cycle
b=0.5;                      %Initial value for second half cycle
t=0:0.01:length(n);         %Time Duration set up for a single binary bit
for j=1:length(t)
 if t(j)>=a && t(j)<=b      %Condition for the first half cycle
    y(j)=n(i);              %Assign first 50 values for 1st half cycle
 elseif t(j)>b && t(j)<=i   %Condition for second half cycle
    y(j)=0;                 %set all values 0 for 2nd half cycle
 else
     i=i+1;                 %Binaty input data index increament
     a=a+1;                 %Initial value for first half cycleIncrement
     b=b+1;                 %Initial value for second half cycle Increment
 end
end
plot(t,y,'lineWidth', 2);   %Linewidth 2 for clear visualization
axis([0,N,-1.5,1.5]);       %Axis set-up
grid on;
title('Unipolar return-to-zero (RZ) signaling');