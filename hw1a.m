clear; clc; close all;
dye = importdata('DyeData_2021.txt');

%this is where my rectangular integral calculation begins
dye1 = dye(2:end-1, 2); %these are the first values of the dye omitting the last value.
timeDiff = dye(3:end,1)-dye(2:end-1,1); %this line is to ensure the time difference is calculated for any type of data set.
rectangular = dot(dye1,timeDiff); %the addition of the rectangles from the dye values times the time differences is the rectangular accumulation.

%this is where my trapezoidal integral calculation begins
dye2 = dye(3:end, 2); %this is the dye data beginning from the second hematocrit value.
trapezoidal = dot(dye2+dye1, timeDiff)/2;

%this is where my Simpson's method calculations begin
h = timeDiff(1);
Sdye = dye(2:end, 2);
%determining if I have to subtract 1 from the end or not. If even number of data points, then subtract 1. If odd, don't.
if (mod(length(Sdye),2) == 0)
    evenodd = 1;
    lastInterval = h*(dye(end-1) + dye(end))/2; %this is the trapezoidal last interval
else
    evenodd = 0;
    lastInterval = 0;
end
coeff1 = [Sdye(1), Sdye(end-evenodd)]; %all of the values that must be multiplied by 1
coeff4 = Sdye(2:2:end-evenodd-1)*4; % all of the values that must be multiplied by 4
coeff2 = Sdye(3:2:end-evenodd-2)*2; %all of the values here must be multipled by 2
Simpsons = h*(sum(coeff1) + sum(coeff2) + sum(coeff4))/3 + lastInterval;

%Cardiac Output calculations below
HCT = dye(1, 2)/100;
QplasmaR = dye(1,1)/rectangular;
Qr = QplasmaR*60/(1-HCT); %in L/min
QplasmaT = dye(1,1)/trapezoidal;
Qt = QplasmaT*60/(1-HCT); %in L/min
QplasmaS = dye(1,1)/Simpsons;
Qs = QplasmaS*60/(1-HCT); %in L/min

%plotting concentration vs. time
fig1 = figure(1);
plot(dye(2:end,1), dye(2:end,2), 'o')
ylim([0 15]);
xlim([0.0 45.0]);
xlabel('Time (sec)');
ylabel('Concentration of Dye (mg/L)');
title('Concentration of Dye (mg/L) Over Time (sec)');
saveas(fig1, 'HW1Pt2.png');

%outputting all of the calculated information
fprintf('Rectangular approximation: %.4f mg-sec/L\n', rectangular);
fprintf('Trapezoidal approximation: %.4f mg-sec/L\n', trapezoidal);
fprintf('Simpson''s rule approximation: %.4f mg-sec/L\n', Simpsons);
fprintf('Cardiac output using rectangular approximation: %.4f L/min\n', Qr);
fprintf('Cardiac output using trapezoidal approximation: %.4f L/min\n', Qt);
fprintf('Cardiac output using Simpson''s approximation: %.4f L/min\n\n', Qs);


