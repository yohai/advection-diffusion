%function multiple_runs(eta,pth,n)
%%
n=250;
n_times=300;
t_max=5;

fname=sprintf('data/%f.h5',eta);
delete(fname)
[x,y]=meshgrid(linspace(0,2*pi*(n-1)/n,n));
h5create(fname,'/x',size(x))
h5create(fname,'/y',size(y))
h5create(fname,'/t',[1 n_times])
h5writeatt(fname,'/','eta',eta);
h5write(fname,'/x',x);
h5write(fname,'/y',y);
h5write(fname,'/t',linspace(0,t_max,n_times));
for i=1:2
    fprintf('Starting iteration #%d\n',i)
    [~, ct,u,v,uh,vh,sWA]=one_run(x,y,eta,n_times);
    h5create(fname,sprintf('/%03d/c',i),size(ct));
    h5write(fname,sprintf('/%03d/c',i),ct);
    h5create(fname,sprintf('/%03d/u',i),size(u));
    h5create(fname,sprintf('/%03d/v',i),size(v));
    h5write(fname,sprintf('/%03d/u',i),u);
    h5write(fname,sprintf('/%03d/v',i),v);
    h5writeatt(fname,sprintf('/%03d',i),'vu_MMA',sWA);
    h5writeatt(fname,sprintf('/%03d',i),'v_Matlab',vh);
    h5writeatt(fname,sprintf('/%03d',i),'u_Matlab',uh);
end
fprintf('Done!')
exit
