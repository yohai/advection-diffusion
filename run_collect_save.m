%%
if ~exist('n','var')
  n=200;
end
if ~exist('n_times','var')
  n_times=300;
end
if ~exist('t_max','var')
  t_max=5;
end
if ~exist('n_iter','var')
  n_iter=1;
end
if ~exist('eta','var')
  eta=1;
end


fname=sprintf('data/%1.1e.h5',eta);
delete(fname)
[x,y]=meshgrid(linspace(0,2*pi*(n-1)/n,n));
h5create(fname,'/x',size(x))
h5create(fname,'/y',size(y))
h5create(fname,'/t',[1 n_times])
h5writeatt(fname,'/','eta',eta);
h5write(fname,'/x',x);
h5write(fname,'/y',y);
h5write(fname,'/t',linspace(0,t_max,n_times));
for i=1:n_iter
    fprintf('iter %d/%d:.....',i,n_iter);
    [~, ct,u,v,uh,vh,sWA]=one_run(x,y,eta,n_times);
    fprintf('finished ode, saving....');
    h5create(fname,sprintf('/%03d/c',i),size(ct),'Datatype','single')
    h5write(fname,sprintf('/%03d/c',i),ct);
    h5create(fname,sprintf('/%03d/u',i),size(u),'Datatype','single');
    h5create(fname,sprintf('/%03d/v',i),size(v),'Datatype','single');
    h5write(fname,sprintf('/%03d/u',i),u);
    h5write(fname,sprintf('/%03d/v',i),v);
    h5writeatt(fname,sprintf('/%03d',i),'vu_MMA',sWA);
    h5writeatt(fname,sprintf('/%03d',i),'v_Matlab',vh);
    h5writeatt(fname,sprintf('/%03d',i),'u_Matlab',uh);
    fprintf('done!\n')
end
