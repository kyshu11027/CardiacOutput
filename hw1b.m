clear; clc; close all;
hemoData = importdata('HemodynamicData.txt');

time = hemoData(:,2); %seconds
lvP = hemoData(:,3); %mmHg Left Ventricular Pressure
aortaP = hemoData(:,4); %mmHg Aortic Pressure
lvV = hemoData(:, 5); %mL Left Ventricular Volume
laP = hemoData(:, 6); %mmHg Left Atrial Pressure

timeSteps = time(1):0.0001:time(end); %making the more dense x values

%Calculating all of the spline approximations
splineLvP = spline(time, lvP, timeSteps);
splineAortaP = spline(time, aortaP, timeSteps);
splineLvV = spline(time, lvV, timeSteps);
splineLaP = spline(time, laP, timeSteps);

%making sure everything including the axes are black.
fig1 = figure(1);
leftColor = [0 0 0];
rightColor = [0 0 0];
set(fig1, 'defaultAxesColorOrder', [leftColor; rightColor]);

yyaxis left %making the pressure axis.
hold on;
title('Spline Fit to Hemodynamic Data');
ylabel('Pressure (mmHg)');
xlabel('Time (sec)');
plot(time, lvP, 'o k');
plot(timeSteps, splineLvP,'-k');
plot(time, aortaP, 'o', 'MarkerFaceColor', 'k');
plot(timeSteps, splineAortaP, ': k');
plot(time, laP, '^', 'MarkerFaceColor', 'k');
plot(timeSteps, splineLaP, '-- k');

yyaxis right %making the volume axis.
hold on;
plot(time, lvV, 's k');
plot(timeSteps, splineLvV, '-- k');
ylabel('Volume (mL)');

legend('Ventricular Pressure Data', 'Ventricular Pressure Spline', 'Aortic Pressure Data', 'Aortic Pressure Spline', 'Atrial Pressure Data', 'Atrial Pressure Spline', 'Ventricular Volume Data', 'Ventricular Volume Spline');
saveas(fig1, 'HW1Pt4.png');