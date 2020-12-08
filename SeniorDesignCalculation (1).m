
clear 
clc
close all

%Scanner for asking User inputs values
prompt = 'What is the rolling resistance coefficent: ';
Crr = input(prompt);
prompt = 'What is the weight of the bike (lbs): ';
W_bike = input(prompt);
prompt = 'What is the weight of the rider (lbs): ';
W_rider = input(prompt);
prompt = 'What is the percent grading or the slope: ';
G = input(prompt);
prompt = 'What is the Drivetrain loss (percentage): ';
DT_loss = input(prompt);
prompt = 'What is the Frontal Area (ft^2): ';
A = input(prompt);
prompt = 'What is the final velocity of the bike+rider (mph): ';
V_mph = input(prompt);

g = 9.8067;     %(m/s^2)
Rho = 1.2754;   % Air Density(kg/m^3)
Cd = 0.9;       %(Drag Coefficient)

%Converting imperial to scientific 
A = A*0.092903;     
V_kmh = V_mph*0.44704;      
W_rider = W_rider*0.453592;
W_bike = W_bike*0.453592;
W = W_rider+W_bike;

F_gravity = g*W*sin(atan(G/100));              %Force from Gravity
F_rolling = g*W*Crr*cos(atan(G/100));          %Force from Rolling 
F_drag = 0.5*Cd*A*Rho*(V_kmh^2);               %Aerodynamic Drag 
F_total = F_gravity + F_rolling + F_drag;      %Force total
P_wheel = F_total*V_kmh;                       %Power of Wheel
P_motor = P_wheel/(1-(DT_loss/100))            %Power of Motor
Percent_gravity = (F_gravity/F_total)*100;
Percent_rolling = (F_rolling/F_total)*100;
Percent_drag = (F_drag/F_total)*100;
disp1 = [num2str(Percent_gravity),'% of force due to gravity and slope'];
disp2 = [num2str(Percent_rolling),'% of force due to rolling resistance and slope'];
disp3 = [num2str(Percent_drag),'% of force due to frontal area and speed'];
disp(disp1);
disp(disp2);
disp(disp3);

V_mph_var = 1:0.5:20;
V_kmh_var = V_mph_var*0.44704;

F_gravity = g*W*sin(atan(G/100));               %Force from Gravity
F_rolling = g*W*Crr*cos(atan(G/100));           %Force from Rolling 
F_drag = 0.5*Cd*A*Rho*(V_kmh_var.^2);                    %Aerodynamic Drag 
F_total = F_gravity + F_rolling + F_drag;   %Force total
P_wheel = F_total.*V_kmh_var;                            %Power of Wheel
P_motor = P_wheel./(1-(DT_loss/100));             %Power of Motor

figure(1)
plot(V_mph_var,P_motor,'-m');
hold on
title('Motor Power vs Velocity (w/ given parameters)');
xlabel('Velocity (mph)');
ylabel('Motor Power (Watts)')
hold off

W_var_lbs = 1:0.5:300;
W_var_kmh = W_var_lbs*0.453592;
F_gravity = g*W_var_kmh*sin(atan(G/100));              %Force from Gravity
F_rolling = g*W_var_kmh*Crr*cos(atan(G/100));          %Force from Rolling 
F_drag = 0.5*Cd*A*Rho*(V_kmh^2);               %Aerodynamic Drag 
F_total = F_gravity + F_rolling + F_drag;      %Force total
P_wheel = F_total*V_kmh;                       %Power of Wheel
P_motor = P_wheel/(1-(DT_loss/100)); 

figure(2)
plot(W_var_lbs,P_motor,'-m');
hold on
title('Motor Power vs Weight (w/ given parameters)');
xlabel('Weight (lbs)');
ylabel('Motor Power (Watts)')
hold off