clear all
clc
t=0:0.0000052:0.2;
v1=sqrt(2)*110*cos(2*pi*60*t);

syms i1 i2  r1 r2 L11 L22 Lm ; % declaring symbolic variables

% declaring variables
r1=6;  
r2=5;
Lm=0.2639;
L11=0.0135;
L22=L11;

% solving for i1 using ode23 (differential equation)
di1 = @(t,i1)((((sqrt(2)*110*cos(2*pi*60*t))/(L11+Lm)-(r1*i1)/(L11+Lm)))); % declaring FUNODE to solve differential equation using ODE
[t0,i1] = ode23(di1,[0,0.2],0);
v2=(sqrt(2)*110*cos(2*pi*60*t0))*(Lm/(L11+Lm)) - i1*(r1*((L11+Lm+1)/(L11+Lm)));
i2=0;                                                                      % i2=0 since it is an open circuit model

lambda = (L11+Lm)*i1;

% plotting results, v1, v2 , i1, i2 and lambda

subplot(5,1,1),plot(t,v1)
title('TRANSFORMER MODELING - OPEN CIRCUIT [ v1=sqrt(2)110cos(377t) ]')
xlabel('time (s)')
ylabel('v1 (V)')
grid on

subplot(5,1,2),plot(t0,i1)
xlabel('time (s)')
ylabel('i1 (A)')
grid on

subplot(5,1,3),plot(t0,v2,'r')
xlabel('time (s)')
ylabel('v2 (V)')
grid on

subplot(5,1,4),plot(t0,i2,'g')
xlabel('time (s)')
ylabel('i2 (A)')
grid on

subplot(5,1,5),plot(t0,lambda,'k')
xlabel('time (s)')
ylabel('lambda (V.s)')
grid on