function [t_ens r_ens m_lite t_arr r_arr]=calc_cmip_sens(ens,pll,sd_tas,sd_rad)
[p0 pname plong pmin pmax]=defparams();
addpath('gwmcmc/')

if pll
  parforArg = Inf;
else
  parforArg = 0;
end

pt0=p0;%(8:16);
ptmax=pmax;%(8:16);
ptmin=pmin;%(8:16);
mdls=fieldnames(ens);

t_arr=NaN(numel(mdls),150)';
r_arr=NaN(numel(mdls),150)';

parfor (i=1:numel(mdls), parforArg)
    %    for i=51:51
disp([mdls{i} ' - ' num2str(i) ' of '  num2str(numel(mdls))]);
if and(issfield(ens.(mdls{i}),'abrupt4xCO2'),issfield(ens.(mdls{i}),'piControl'))
   if issfield(ens.(mdls{i}).piControl,'rlut')
t_4x=ens.(mdls{i}).abrupt4xCO2.tas{1}- ...
     mean(ens.(mdls{i}).piControl.tas{1}(end-49:end));

r_4x=ens.(mdls{i}).abrupt4xCO2.rlut{1}- ...
     mean(ens.(mdls{i}).piControl.rlut{1}(end-49:end))+...
     ens.(mdls{i}).abrupt4xCO2.rsut{1}- ...
     mean(ens.(mdls{i}).piControl.rsut{1}(end-49:end));

r_4x=smooth(r_4x,5);

f_4xco2=5.35*log(4)*ones(numel(t_4x),1);
tmp_t4x=NaN(150,1);
tmp_r4x=NaN(150,1);

tmp_t4x(1:min(numel(t_4x),150))=t_4x(1:min(numel(t_4x),150));
tmp_r4x(1:min(numel(r_4x),150))=r_4x(1:min(numel(r_4x),150));


t_arr(:,i)=tmp_t4x;
r_arr(:,i)=tmp_r4x;


nl=200;
lhn=lhsdesign(nl,numel(pt0));
p_lhs=(ptmin+repmat(ptmax-ptmin,nl,1).*lhn)';

err_t = @(p,fcg,ts) sum(((t_rsp(p,f_4xco2)-ts)/(sqrt(2)*sd_tas)).^2);
err_r = @(p,fcg,ts) sum(((r_rsp(p,f_4xco2)-ts)/(sqrt(2)*sd_rad)).^2);

lpr = @(p) sum((p<ptmin')+(p>ptmax'))==0;

llhd=@(p) -(err_t(p,f_4xco2,t_4x));
llhd_r=@(p) -(err_r(p,f_4xco2,r_4x));

lgam=@(p) gampdf(p(4),5,500);

  [m_lite{i},logP]=gwmcmc(p_lhs,{lpr llhd llhd_r},1000000,'ProgressBar',logical(0),'BurnIn',0.5);

  for j=1:nl
      if ~isnan(m_lite{i}(1))
      tmp=m_lite{i}(:,j,end);
  t_ens{i}(:,j)=t_rsp(tmp,5.35*log(4)*ones(10000,1),[0:10000]);
  r_ens{i}(:,j)=r_rsp(tmp,5.35*log(4)*ones(10000,1),[0:10000]);
  end
  end
   else
       disp('No RLUT')
    m_lite{i}=NaN;
    t_ens{i}=NaN;
   end
else
disp('No 4x+PI')
   m_lite{i}=NaN;
    t_ens{i}=NaN;
   end
end

