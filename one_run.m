function [t, ct,u,v,uh,vh,sWA]=one_run(x,y,eta,n_times)
n=length(x);
%%
%[x,y]=meshgrid(linspace(0,2*pi*(n-1)/n,n));
flat=@(V) V(:);
deflat=@(V) reshape(V,[n,n]);
a=x(1,2)-x(1,1);
c0=exp(-(x-mean(x(:))).^2-(y-mean(y(:))).^2);

[u, v, uh, vh, sWA]=generate_v_field(x,y);
cs=@circshift;
vgrad=@(Cm) (0.25/a)*(...
             (Cm+cs(Cm,[0,-1])).*(cs(u,[1,-1])+cs(u,[0,-1]))...
            -(Cm+cs(Cm,[0, 1])).*(cs(u,[0, 0])+cs(u,[1, 0])))...
           +(0.25/a)*(...
             (Cm+cs(Cm,[-1, 0])).*(cs(v,[0,0])+cs(v,[0,-1]))-...
             (Cm+cs(Cm,[ 1, 0])).*(cs(v,[1,-1])+cs(v,[1,0]))...
            );
lap=@(Cm) (cs(Cm,[-1,0])+cs(Cm,[0,-1])+cs(Cm,[1,0])+cs(Cm,[0,1])-4*Cm)/(a^2);
tder=@(t,Cv)flat(eta*lap(deflat(Cv))-vgrad(deflat(Cv)));
[t,ct]=ode45(tder,linspace(0,10,n_times),c0);
ct=reshape(ct,[n_times,n,n]);