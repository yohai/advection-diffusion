function [u, v, uh, vh, sW]=generate_v_field(x,y,n)
% generates a random divergenceless velocity field over a doubly-periodic 
% domain specified by x,y with n (default=10) terms. 
% the space x,y is shifted by have a lattice length to have staggered
% meshes for velocity and concentration.
% uh and vh are strings that describr function handles to generate u and v.
% (use str2func to convert to actual function handles)
% sW is the same as uh and vh (combined) but in Wolfram Syntax.

a=x(1,2)-x(1,1);
x=x-a/2;
y=y-a/2;
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
if strcmp(n,'cheat')
    %u=-cos(x).*sin(x+y);
    %v=sin(2*x+y);
    u=sin(y);v=cos(x);
    suWA='Sin[y]';
    svWA='Cos[x]';
else
    for i=1:n
        A=(rand-1)*2;
        m=round(8*(0.5-rand));
        n=round(8*(0.5-rand));
        b1=rand>0.5;
        b2=rand>0.5;
        suWA=[suWA sprintf('%f(%d)',A,n)];
        svWA=[svWA sprintf('%f(%d)',A,m)];
        suM=[suM sprintf('%f*(%d)*',A,m)];
        svM=[svM sprintf('%f*(%d)*',A,n)];
        if b1
            u1=cos(m*x);
            v1=sin(m*x);
            suWA=[suWA sprintf('Cos[%d x]',m)];
            svWA=[svWA sprintf('Sin[%d x]',m)];
            suM=[suM sprintf('cos(%d*X).*',m)];
            svM=[svM sprintf('sin(%d*X).*',m)];
        else
            u1=-sin(m*x);
            v1=cos(m*x);
            suWA=[suWA sprintf('(-1)Sin[%d x]',m)];
            svWA=[svWA sprintf('Cos[%d x]',m)];
            suM=[suM sprintf('(-1)*sin(%d*X).*',m)];
            svM=[svM sprintf('cos(%d*X).*',m)];
        end
        if b2
            u2=cos(n*y);
            v2=sin(n*y);
            suWA=[suWA sprintf('Cos[%d y]',n)];
            svWA=[svWA sprintf('Sin[%d y]',n)];
            suM=[suM sprintf('cos(%d*Y)',m)];
            svM=[svM sprintf('sin(%d*Y)',m)];
        else
            u2=-sin(n*y);
            v2=cos(n*y);
            suWA=[suWA sprintf('(-1)Sin[%d y]',n)];
            svWA=[svWA sprintf('Cos[%d y]',n)];
            suM=[suM sprintf('(-1)*sin(%d*Y)',m)];
            svM=[svM sprintf('cos(%d*Y)',m)];
        end
        u=u+n*u1.*u2;
        v=v+m*v1.*v2;
        suWA=[suWA '+'];
        svWA=[svWA '+'];
        suM=[suM '+'];
        svM=[svM '+'];
    end
    suWA=suWA(1:end-1);
    svWA=svWA(1:end-1);
    suM=suM(1:end-1);
    svM=svM(1:end-1);
end
sW=sprintf('u=%s; v= %s;',suWA,svWA);
uh=sprintf('@(X,Y) %s',suM);
vh=sprintf('@(X,Y) %s',svM);

%fff=fopen('~/tmp/ss.txt','w');
%fwrite(fff,sss);
%fclose(fff);
%clipboard('copy',sss)
