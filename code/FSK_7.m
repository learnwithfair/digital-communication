clc;
clear all;
close all;

%N=10;                      %Number of bits
%n=randi([0,1],1,N)         %Random Bit Generation

x= [1 0 1 0 1 0 1 0 1];     % Input Signal
bp = 0.000001;              % Bit period bp=1/1000000
disp('Binary information at transmitter');
disp(x);

% Representation of transmitting binary information as a digital signal
bit = [];
for n = 1:length(x)
    if x(n) == 1
        se = ones(1, 100);  %Set up 100 times 1
    else
        se = zeros(1, 100);  %Set up 100 times 0
    end
    bit = [bit se];
end
 
tl = bp/100:bp/100:100*length(x)*(bp/100);              % Time Duration set up for input signal

%tl = bp/100 : bp/100 : 100 * length(x) * (bp/100);

subplot(3, 1, 1);
grid on;
plot(tl, bit, 'linewidth', 2);                          % Linewidth 2 for clear visualization
axis([0 bp * length(x) -0.5 1.5]);                      % Axis set-up
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Transmitting information as a digital signal');

% Binary FSK Modulation
A = 5;                              % Amplitude
br = 1 / bp;
fl = br * 8;                        % Frequency for 1 bit
f2 = br * 2;                        % Frequency for 0 bit
t = bp / 99 : bp / 99 : bp;         % Time for Modulated signal
ss = length(t);
m = [];
for i = 1:length(x)
    if x(i) == 1
        y = A * cos(2 * pi * fl * t);   % Sinusoidal signal for 1 bit
    else
        y = A * cos(2 * pi * f2 * t);   % Sinusoidal signal for 0 bit
    end
    m = [m y];
end

t3 = bp / 99 : bp / 99 : bp * length(x); %Time Duration set up for binary FSK Modulation
subplot(3, 1, 2);
plot(t3, m);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Waveform for binary FSK modulation corresponding to binary information');

% Binary FSK Demodulation
mn = [];
bit=[];             %Demodulation Signal
for n = ss : ss : length(m) 
    yl = cos(2 * pi * fl * t);
    y2 = cos(2 * pi * f2 * t);
    mn = [mn yl .* m((n - (ss - 1)) : n)];
    mn = [mn y2 .* m((n - (ss - 1)) : n)];
    t4 = bp / 99 : bp / 99 : bp;
    z1 = trapz(t4, mn(1:ss));
    z2 = trapz(t4, mn(ss + 1 : end));
    zz1 = round(2 * z1 / bp);
    zz2 = round(2 * z2 / bp);
    if zz1 > A / 2       % Logic level (0 + A)/2 or (A + 0)/2 or 2.5 in this case
        bit = [bit 1];
    else
        bit = [bit 0];
    end    
    mn=[];
end

disp('Binary information at Receiver');
disp(bit);

% Representation of binary information as a digital signal
bit_received = [];
for n = 1:length(bit)
    if bit(n) == 1
        se = ones(1, 100);         %Set 0 for 100 times 
    else
        se = zeros(1, 100);        %Set 0 for 100 times 
    end
    bit_received = [bit_received se];
end

t4 = bp / 100 : bp / 100 : 100 * length(bit) * (bp / 100);     % Time Duration set up for Demodulation
subplot(3, 1, 3);
plot(t4, bit_received, 'Linewidth', 2);                        % Linewidth 2 for clear visualization
grid on;
axis([0 bp * length(bit) -0.5 1.5]);                           % Axis set-up
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Received information as a digital signal after binary FSK demodulation');