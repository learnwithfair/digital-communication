clc;
close all;
clear all;
n=input('Enter for n-bit PCM system : '); %Encodebook Bit Length
n1=input('Enter Sampling Frequency : '); %Sampling Frequency
L = 2^n; %Number of Quantisation Levels

%Here we plot the Analog Signal and its Sampled form
Vmax = 20;
x = 0:pi/n1:4*pi; %Construction of Signal 
ActualSignl=Vmax*sin(x); %Actual input
subplot(3,1,1);
plot(ActualSignl);
title('Analog Signal');
subplot(3,1,2); %Sampled Version
stem(ActualSignl);
grid on; 
title('Sampled Sinal'); 
%Now perform the Quantization Process
Vmin=-Vmax; %Since the Signal is sine 
StepSize=(Vmax-Vmin)/L; % Diference between each quantisation level
QuantizationLevels=Vmin:StepSize:Vmax; % Quantisation Levels - For comparison
codebook=Vmin-(StepSize/2):StepSize:Vmax+(StepSize/2); % Quantisation Values - As Final Output of qunatiz
[ind,q]=quantiz(ActualSignl,QuantizationLevels,codebook); 
% Quantization process
NonZeroInd = find(ind ~= 0);
ind(NonZeroInd) = ind(NonZeroInd) - 1; 
 % MATLAB gives indexing from 1 to N.But we need indexing from 0, to convert it into binary codebook
 
%BelowVminInd = find(q == Vmin-(StepSize/2));
%q(BelowVminInd) = Vmin+(StepSize/2);
 %This is for correction, as signal values cannot go beyond Vmin
 %But quantiz may suggest it, since it return the Values lower than Actual
 %Signal Value
subplot(3,1,3);
stem(q);
grid on; % Display the Quantize values
title('Quantized Signal');
%Having Quantised the values, we perform the Encoding Process
figure
TransmittedSig = de2bi(ind,'left-msb'); % Encode the Quantisation Level
SerialCode = reshape(TransmittedSig',[1 size(TransmittedSig,1)*size(TransmittedSig,2)]);
subplot(2,1,1); 
grid on;
stairs(SerialCode); % Display the SerialCode Bit Stream
axis([0 100 -2 3]); 
title('Transmitted Signal');
%Now we perform the Demodulation Of PCM signal
RecievedCode=reshape(SerialCode,n,length(SerialCode)/n); 
%Again Convert the SerialCode into Frames of 1 Byte
index = bi2de(RecievedCode','left-msb'); 
%Binary to Decimal Conversion
q = (StepSize*index); %Convert into Voltage Values
q = q + (Vmin+(StepSize/2)); % Above step gives a DC shfted version of Actual siganl
%Thus it is necessary to bring it to zero level
subplot(2,1,2); 
grid on;
plot(q); % Plot Demodulated signal
title('Demodulated Signal');







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;
clear all;
close all;
n=input('Enter value for n bit PCM signal : ');
n1=input('Enter number of samples in a period : ');
L=2^n;

%Signal generation
x=0:1/100:4*pi;
y=8*sin(x);
subplot(221);
plot(x,y);
grid on;


%sampling operation
x=0:2*pi/n1:4*pi
s=8*sin(x);
subplot(311);
plot(s);
title("Analog Signal");
ylabel("Amplitude ");
xlabel("Time");
subplot(312);
stem(s);
grid on;
title("Sampled Signal");
ylabel("Amplitude");
xlabel("Time");

%Quantization process
vmax=8;
vmin=-vmax;
del=(vmax-vmin)/L;
part=vmin:del:vmax;
code=vmin-(del/2):del:vmax+(del/2);
[ind,q]=quantiz(s,part,code);
l1=length(ind);
l2=length(q);
for i=1:11
    if(ind(i)~=0)
        ind(i)=ind(i)-1;
    end
        i=i+1
end
for i=1:12
    if(q(i)==vmin-(del/2))
        q(i)=vmin+(del/2);
    end
end
subplot(3,1,3);
stem(q);
grid on;
title('Quantized Signal');
ylabel('Amplitude');
xlabel('Time');



%Encoding process
figure(2)
code=de2bi(ind,'left-msb');
k=1;
for i=1:11
    for j=1:n
        coded(k)=code(i,j);
        j=j+1;
        k=k+1;
    end
    i=i+1;
end
subplot(211);
grid on;
stairs(coded);
axis([0 100 -2 3]);
title('Encoded Signal');
ylabel('Amplitude');
xlabel('Time');

%demodulation of PCM signal

qunt=reshape(coded,n,length(coded)/n);
index=bi2de(qunt','left-msb');
q=del*index+vmin+(del/2);

subplot(212);
grid on;
plot(q);

title('Demodulated Signal');
ylabel('Amplitude');
xlabel('Time');

