%Split Phase-Manchester Coding
clc;
clear all;
close all;
%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

n = [0 1 1 0 1 0 0 1];      %Input Signal
N=length(n);                %Number of Bits

%Binary to Manchester Conversion
nnn=[];
for m=1:N
   if n(m)==1
       nn=[1 -1];
   else
       nn=[-1 1];
   end
   nnn=[nnn nn];
   disp(nnn);
end 
nnn; %nnn = [-1     1     1    -1     1    -1    -1     1
           %  1    -1    -1     1    -1     1     1    -1]
%Manchester Coding Pulse Shaping
i=1;
l=0.5;                          %Initial value for first half cycle
t=0:0.01:length(n);             %Time Duration set up for a single binary bit
for j=1:length(t)
     if t(j)<=l
        y(j)=nnn(i);            %Assign First 50 values for 1st half cycle 
     else
         y(j)=nnn(i);           %Assign second 50 values for 1st half cycle
         i=i+1;                 %Binaty input data index increament
         l=l+0.5;               %Initial value for each half cycle Increment
     end
end
plot(t,y,'lineWidth', 2);       %Linewidth 2 for clear visualization
axis([0,N,-1.5,1.5]);           %Axis set-up
grid on;
title('Manchester Coding');