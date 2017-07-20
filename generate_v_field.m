function [u, v, uh, vh, sW]=generate_v_field(x,y,n)
% generates a random divergenceless velocity field over a doubly-periodic
% domain specified by x,y with n (default=10) terms.
% uh and vh are strings that describr function handles to generate u and v.
% (use str2func to convert to actual function handles)
% sW is the same as uh and vh (combined) but in Wolfram Syntax.

a=x(1,2)-x(1,1);
x=x-a/2;% the space x,y is shifted by have a lattice length to have staggered
y=y-a/2;% meshes for velocity and concentration.
if nargin==2
    n=5;
end
u=0*x;
v=0*x;
%#ok<*AGROW>
suWA=''; %s[uv]WA is the string for u or v in WolframAlpha syntax
svWA='';
suM='';  %s[uv]M is the string for u or v in Matlab syntax
svM='';

for i=1:n
    A=(rand-0.5)*2;
    m=round(8*(0.5-rand));
    n=round(8*(0.5-rand));
    p1=2*pi*rand;
    p2=2*pi*rand;
    u=u+A*m*cos(n*x+p1).*cos(m*y+p2);
    v=v+A*n*sin(n*x+p1).*sin(m*y+p2);
    suWA=[suWA sprintf('%f(%d)*Cos[%dx+%f]Cos[%dy+%f]+',A,m,n,p1,m,p2)];
    svWA=[svWA sprintf('%f(%d)*Sin[%dx+%f]Sin[%dy+%f]+',A,n,n,p1,m,p2)];
    suM=[suM sprintf('%f*(%d)*cos(%d*X+%f).*cos(%d*Y+%f)+',A,m,n,p1,m,p2)];
    svM=[svM sprintf('%f*(%d)*sin(%d*X+%f).*sin(%d*Y+%f)+',A,n,n,p1,m,p2)];
end
suWA=suWA(1:end-1);
svWA=svWA(1:end-1);
suM=suM(1:end-1);
svM=svM(1:end-1);

sW=sprintf('u=%s; v= %s;',suWA,svWA);
uh=sprintf('@(X,Y) %s',suM);
vh=sprintf('@(X,Y) %s',svM);

%fff=fopen('~/tmp/ss.txt','w');
%fwrite(fff,sss);
%fclose(fff);
%clipboard('copy',sss)
