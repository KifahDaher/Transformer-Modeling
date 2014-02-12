clear all
clc
t=0:0.00052:0.2;
v1=sqrt(2)*110*cos(2*pi*60*t);
tic
syms i1 i2  r1 r2 L11 L22 lambda1 ; % declaring symbolic variables


% inputing values from the plot lambda versus (i1+i2') - lambdam not constant because of saturation effect 
lambda=[0;0.1;0.13747;0.19434;0.21635;0.2457;0.28056;0.30624;0.33743;0.37778;0.40897;0.46967;0.464;0.476;0.476;0.476;0.45;0.486];
x1=[0;0.3788;0.5144;0.7165;0.8267;1.0769;1.3778;1.6648;2.1057;2.774;3.4905;4.3649;5.2737;6.1106;7.0475;7.9547;8.4274;9.4806];
p=polyfit(x1,lambda,6);                                                              % reconstructing a polynomial fitting the curve
f=polyval(p,x1);
lambdam=vpa(p(1).*i1.^6+p(2).*i1.^5+p(3).*i1.^4+p(4).*i1^3+p(5).*i1^2+p(6).*i1+p(7));% lambdam in plynomial form of six degree 
digits(4)                                                                            % decimal precision                        
dlambdam=diff(lambdam);                                                              % differentiating lambdam


% declaring variables
r1=6;
r2=5;
L11=0.0135;
L22=L11;

% solving for i1 using ode15s (differential equation)
di1=@(t,i1) (((-r1*i1)/(L11+eval(dlambdam)))+((sqrt(2)*110*cos(2*pi*60*t))/(L11+eval(dlambdam))));
[t0,i1] = ode15s(di1,[0.0,0.2],0.0);

i2=0;                                                                               % i2=0 since short circuit
v2=(((-r1*i1)/(L11+eval(dlambdam)))+((sqrt(2)*110*cos(2*pi*60*t0))/(L11+eval(dlambdam))))*eval(dlambdam);

lambda1=L11*i1+eval(lambdam);

% plotting results, v1, v2 , i1, i2 and lambda

subplot(5,1,1),plot(t,v1)
title('TRANSFORMER MODELLING - OPEN CIRCUIT WITH SATURATION [ v1=sqrt(2)110cos(377t) ]')
xlabel('time (s)')
ylabel('v1 (V)')
grid on

subplot(5,1,2),plot(t0,i1)
xlabel('time (s)')
ylabel('i1 (A)')
axis([0 0.2 -15 15])
grid on

subplot(5,1,3),plot(t0,v2,'r')
xlabel('time (s)')
ylabel('v2 (V)')
grid on

subplot(5,1,4),plot(t0,i2,'g')
xlabel('time (s)')
ylabel('i2 (A)')
grid on

subplot(5,1,5),plot(t0,lambda1,'k')
xlabel('time (s)')
ylabel('lambda1 (V.s)')
grid on
time=toc
