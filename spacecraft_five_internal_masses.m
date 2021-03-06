clear all
clc
close all

syms m1 m2 m3 m4 m5 M J Ih Jh x0 y0 t

Ih=[1;0;0]; Jh=[0;1;0]; Kh=[0;0;1];

x1  = str2sym("x1(t)");
y1  = str2sym("y1(t)");
x2  = str2sym("x2(t)");
y2  = str2sym("y2(t)");
x3  = str2sym("x3(t)");
y3  = str2sym("y3(t)");
x4  = str2sym("x4(t)");
y4  = str2sym("y4(t)");
x5  = str2sym("x5(t)");
y5  = str2sym("y5(t)");
th  = str2sym("th(t)");

ih  = Ih*cos(th)+Jh*sin(th);
jh  = -Ih*sin(th)+Jh*cos(th);

rm1G = (x1*ih+y1*jh+x0*Ih+y0*Jh); % position vector of m1 in G
rm2G = (x2*ih+y2*jh+x0*Ih+y0*Jh); % position vector of m2 in G
rm3G = (x3*ih+y3*jh+x0*Ih+y0*Jh); % position vector of m3 in G
rm4G = (x4*ih+y4*jh+x0*Ih+y0*Jh); % position vector of m4 in G
rm5G = (x5*ih+y5*jh+x0*Ih+y0*Jh); % position vector of m4 in G
rMG = (x0*Ih+y0*Jh);             % position vector of c.m of M in G

equ_cm = simplify(m1*(rm1G)+M*(rMG)+m2*(rm2G)+m3*(rm3G)+m4*(rm4G)+m5*(rm5G));

x0y0=solve(equ_cm==0,{x0,y0}); % assume system center of mass is at the origin of G

x0sol  = x0y0.x0; % x-coordinate of center of mass of M in G
y0sol  = x0y0.y0; % y-coordinate of the center of mass of M in G

rm1G   = subs(rm1G,{x0,y0},{x0sol,y0sol}); 
rm2G = subs(rm2G,{x0,y0},{x0sol,y0sol}); 
rm3G = subs(rm3G,{x0,y0},{x0sol,y0sol});
rm4G = subs(rm4G,{x0,y0},{x0sol,y0sol});
rm5G = subs(rm5G,{x0,y0},{x0sol,y0sol}); 
rMG   = subs(rMG,{x0,y0},{x0sol,y0sol});

Hm = simplify(m1*cross(rm1G,diff(rm1G,t))+m2*cross(rm2G,diff(rm2G,t))+m3*cross(rm3G,diff(rm3G,t))+m4*cross(rm4G,diff(rm4G,t))+m5*cross(rm5G,diff(rm5G,t)) ); %angular momentum of m about system c.m. in G
HM = simplify(J*diff(th,t)*Kh+M*cross(rMG,diff(rMG,t))); %angular momentum of M about system c.m. in G

syms x1 y1 x2 y2 x3 y3 x4 y4 x5 y5 th x1d y1d x2d y2d x3d y3d x4d y4d x5d y5d thetad
equ1=subs(simplify(Hm(3)+HM(3)),...
    {str2sym('x1(t)'),str2sym('y1(t)'),...
     str2sym('x2(t)'),str2sym('y2(t)'),str2sym('x3(t)'),str2sym('y3(t)'),...
     str2sym('x4(t)'),str2sym('y4(t)'),...
     str2sym('x5(t)'),str2sym('y5(t)'),str2sym('th(t)'),...
     str2sym('diff(x1(t), t)'),str2sym('diff(y1(t), t)'),...
     str2sym('diff(x2(t), t)'),str2sym('diff(y2(t), t)'),str2sym('diff(x3(t), t)'),str2sym('diff(y3(t), t)')...
     ,str2sym('diff(x4(t), t)'),str2sym('diff(y4(t), t)')...
     ,str2sym('diff(x5(t), t)'),str2sym('diff(y5(t), t)')...
     str2sym('diff(th(t), t)')},[x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,th,x1d,y1d,x2d,y2d,x3d,y3d,x4d,y4d,x5d,y5d,thetad]);

disp('Equation for thetadot:');
collect(simplify(solve(equ1,thetad)),[x1d,y1d,x2d,y2d,x3d,y3d,x4d,y4d,x5d,y5d])
simplify(solve(equ1,thetad))

