
 
clear tomat* comat* gregmat* tcrmat*


btrnd=NaN(numel(mdls),1);
sdend=NaN(numel(mdls),1);
arcoeff=NaN(numel(mdls),2);
arvar=NaN(numel(mdls),1);
clear ax psn


for i=1:numel(mdls)
if and(and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2')),isfield(ens.(mdls{i}),'abrupt4xCO2'))
if isfield(ens.(mdls{i}).piControl,'rsut')
if and(isfield(ens.(mdls{i}).onepctCO2,'rlut'),isfield(ens.(mdls{i}).onepctCO2,'rsut'))
  if numel(ens.(mdls{i}).piControl.rlut{1})==numel(ens.(mdls{i}).piControl.rsut{1})
      mn=mean(ens.(mdls{i}).piControl.tas{1});

  [b,bint,r,~,stats] =regress(ens.(mdls{i}).piControl.tas{1}-mn,[(1:numel(ens.(mdls{i}).piControl.tas{1}))',ones(size(ens.(mdls{i}).piControl.tas{1}))])

  btrnd(i)=b(1);
  sdend(i)=std(r);
 mdl = arima(2,0,0); % 2 the lag order     
 armdl{i} = estimate(mdl,r); % y is your data
 arcoeff(i,1)=armdl{i}.AR{1};
 arcoeff(i,2)=armdl{i}.AR{2};
 arvar(i)=armdl{i}.Variance;

end
end
end
end
end





  
argen=armdl{1};
argen.AR{1}=nanmean(arcoeff(:,1));
argen.AR{2}=nanmean(arcoeff(:,2));
argen.Variance=nanmean(arvar);


for i=1:size(mdlpst,2)
 
      tomat85(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      tomat85eo(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2)*0,sum(fcg_85(:,3:end),2)*0));

      comat85(i,:)=single(prm_fast(pinflate(mdlpst(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      romat85(i,:)=single(r_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));


      tomat26(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
      tomat26eo(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2)*0,sum(fcg_26(:,3:end),2)*0));
      comat26(i,:)=single(prm_fast(pinflate(mdlpst(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));


      tomat26ne(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));
      tomat26eone(i,:)=single(t_cfdb(pinflate(mdlpst(:,i,end),p0,sd),emis_26_ne/2.12,285,0*fcg_26_ne(:,2),0*sum(fcg_26_ne(:,3:end),2)));
      comat26ne(i,:)=single(prm_fast(pinflate(mdlpst(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));
      
      tomat85cf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      tomat85eocf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2)*0,sum(fcg_85(:,3:end),2)*0));

      tomat26cf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
      tomat26eocf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2)*0,sum(fcg_26(:,3:end),2)*0));
      
      tomat26necf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));
      tomat26eonecf(i,:)=single(t_cfdb(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2)*0,sum(fcg_26_ne(:,3:end),2)*0));

      comat85cf(i,:)=single(prm_fast(pinflate(mdlpstcf(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      comat26cf(i,:)=single(prm_fast(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
            comat26necf(i,:)=single(prm_fast(pinflate(mdlpstcf(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));
      
      tomat85ml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      tomat26ml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));

      tomat85eoml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2)*0,sum(fcg_85(:,3:end),2)*0));
      tomat26eoml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2)*0,sum(fcg_26(:,3:end),2)*0));

      
      tomat26neml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));
      tomat26eoneml(i,:)=single(t_cfdb(pinflate(mdlpstml(:,i,end),p0,sd),emis_26_ne/2.12,285,0*fcg_26_ne(:,2),0*sum(fcg_26_ne(:,3:end),2)));
      
      comat85ml(i,:)=single(prm_fast(pinflate(mdlpstml(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      comat26ml(i,:)=single(prm_fast(pinflate(mdlpstml(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
      comat26neml(i,:)=single(prm_fast(pinflate(mdlpstml(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));

      
      tomat85nl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      tomat26nl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
      tomat26nenl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));

      tomat85eonl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2)*0,sum(fcg_85(:,3:end),2)*0));
      tomat26eonl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2)*0,sum(fcg_26(:,3:end),2)*0));
      tomat26eonenl(i,:)=single(t_cfdb(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2)*0,sum(fcg_26_ne(:,3:end),2)*0));

      
      comat85nl(i,:)=single(prm_fast(pinflate(mdlpstnl(:,i,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
      comat26nl(i,:)=single(prm_fast(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
      comat26nenl(i,:)=single(prm_fast(pinflate(mdlpstnl(:,i,end),p0,sd),emis_26_ne/2.12,285,fcg_26_ne(:,2),sum(fcg_26_ne(:,3:end),2)));

      [gregmat(i) stmat(i,:) srmat(i,:)]=calc_s_greg(mdlpst(:,i,end));
      [tcrmat(i),tcr4mat(i) tcr10mat(i),stcrmat(i,:)]=calc_tcr(mdlpst(:,i,end));
      [tcremat(i)]=calc_tcre(mdlpst(:,i,end));

      

      [gregmatcf(i) stmatcf(i,:) srmatcf(i,:)]=calc_s_greg(mdlpstcf(:,i,end));
      [tcrmatcf(i),tcr4matcf(i) tcr10matcf(i)]=calc_tcr(mdlpstcf(:,i,end));
      [tcrematcf(i)]=calc_tcre(mdlpstcf(:,i,end));


      [gregmatnl(i) stmatnl(i,:) srmatnl(i,:)]=calc_s_greg(mdlpstnl(:,i,end));
      [tcrmatnl(i),tcr4matnl(i) tcr10matnl(i)]=calc_tcr(mdlpstnl(:,i,end));
      [tcrematnl(i)]=calc_tcre(mdlpstnl(:,i,end));


      [gregmatml(i) stmatml(i,:) srmatml(i,:)]=calc_s_greg(mdlpstml(:,i,end));
      [tcrmatml(i),tcr4matml(i) tcr10matml(i)]=calc_tcr(mdlpstml(:,i,end));
      [tcrematml(i)]=calc_tcre(mdlpstml(:,i,end));

end

for i=1:size(mdlpst,2)
      drftr(i)=rand()*2-1;
	[gregmat_drift(i),driftamp(i) drift_tens(:,i) drift_rens(:,i) drift_a140(i)]=calc_s_greg_drift(mdlpst(:,i,end),drftr(i),500);
     	[tcrmat_drift(i) tcr4mat_drift(i) drift_tcrens(:,i)]=calc_tcr_drift(mdlpst(:,i,end),drftr(i),500);
  end
for i=1:size(mdlpst,2)
      drftr(i)=rand()*2-1;
	[gregmat_both(i),bothamp(i) both_tens(:,i) both_rens(:,i) both_a140(i)]=calc_s_greg_drift(mdlpst(:,i,end),drftr(i),500,argen);
     	[tcrmat_both(i) tcr4mat_both(i) both_tcrens(:,i)]=calc_tcr_drift(mdlpst(:,i,end),drftr(i),500,argen);
  end
    
for i=1:size(mdlpst,2)
	[gregmat_tnoise(i),tnoiseamp(i) tnoise_tens(:,i) tnoise_rens(:,i) tnoise_a140(i)]=calc_s_greg_drift(mdlpst(:,i,end),0,500,argen);
     	[tcrmat_tnoise(i) tcr4mat_tnoise(i) tstnoise_tens(:,i)]=calc_tcr_drift(mdlpst(:,i,end),0,500,argen);
  end
  
 
  
  dt_err=@(p,ts) sum((t_rsp(p,(5.35*log(4))*ones(150,1))-ts).^2);
  dr_err=@(p,rs) sum((-r_rsp(p,(5.35*log(4))*ones(150,1))-rs).^2);
  d_err=@(p,ts,rs) dt_err(p,ts)+dr_err(p,rs);
  for  i=1:size(mdlpst,2)
    errff=@(p) d_err(p, drift_tens(end-149:end,i),drift_rens(end-149:end,i));
    pfit(i,:)=fmincon(errff,p0,[],[],[],[],pmin,pmax);
    [tcrfit(i) tcr4fit(i)]=calc_tcr(pfit(i,:))
  end
  
  driftmat=[-2:.025:2];
      for n=1:numel(driftmat)
	[driftsens(n) duf t_drift(:,n) r_drift(:,n)]=calc_s_greg_drift(mean(mdlpst(:,4,end),2),driftmat(n),500);
	[drifttcr(n) drifttcr4(n) tcr_drift(:,n)]=calc_tcr_drift(mean(mdlpst(:,4,end),2),driftmat(n),500);
      end
  
  
   ce=[0:3000];
c26=cumsum(emis_26);
[duf ism]=max(c26);
clear ce_int*
for i=1:size(tomat26,1)
ce_int26_ne(i,:)=single(interp1(cumsum(emis_26_ne),tomat26ne(i,:),ce));
ce_int26_up(i,:)=single(interp1(c26(1:ism),tomat26(i,1:ism),ce));
ce_int26_dn(i,:)=single(interp1(c26(ism:end),tomat26(i,ism:end),ce));
ce_int85_ne(i,:)=single(interp1(cumsum(emis_85),tomat85(i,:),ce));
ce_int26_necf(i,:)=single(interp1(cumsum(emis_26_ne),tomat26necf(i,:),ce));
ce_int26_upcf(i,:)=single(interp1(c26(1:ism),tomat26cf(i,1:ism),ce));
ce_int26_dncf(i,:)=single(interp1(c26(ism:end),tomat26cf(i,ism:end),ce));
ce_int85_necf(i,:)=single(interp1(cumsum(emis_85),tomat85cf(i,:),ce));

ce_int26_nenl(i,:)=single(interp1(cumsum(emis_26_ne),tomat26nenl(i,:),ce));
ce_int26_upnl(i,:)=single(interp1(c26(1:ism),tomat26nl(i,1:ism),ce));
ce_int26_dnnl(i,:)=single(interp1(c26(ism:end),tomat26nl(i,ism:end),ce));
ce_int85_nenl(i,:)=single(interp1(cumsum(emis_85),tomat85nl(i,:),ce));

ce_int26_neml(i,:)=single(interp1(cumsum(emis_26_ne),tomat26neml(i,:),ce));
ce_int26_upml(i,:)=single(interp1(c26(1:ism),tomat26ml(i,1:ism),ce));
ce_int26_dnml(i,:)=single(interp1(c26(ism:end),tomat26ml(i,ism:end),ce));
ce_int85_neml(i,:)=single(interp1(cumsum(emis_85),tomat85ml(i,:),ce));


end
ce_obs=interp1(cumsum(emis_had),gm_had,ce);
btrnd=NaN(numel(mdls),1)

for i=1:numel(mdls)
  if and(and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2')),isfield(ens.(mdls{i}),'abrupt4xCO2'))
if isfield(ens.(mdls{i}).piControl,'rsut')
if and(isfield(ens.(mdls{i}).onepctCO2,'rlut'),isfield(ens.(mdls{i}).onepctCO2,'rsut'))
if numel(ens.(mdls{i}).piControl.rlut{1})==numel(ens.(mdls{i}).piControl.rsut{1})
    mn=mean(ens.(mdls{i}).piControl.tas{1});

    [b,bint,~,~,stats] =regress(ens.(mdls{i}).piControl.tas{1}-mn,[(1:numel(ens.(mdls{i}).piControl.tas{1}))',ones(size(ens.(mdls{i}).piControl.tas{1}))]);
  btrnd(i)=b(1);
end
end
end
end
end

for i=1:numel(futdat)

for j=1:size(mdlpstfut26{i},2)
tomat26_fut(i,j,:)=single(t_cfdb(pinflate(mdlpstfut26{i}(:,j,end),p0,sd),emis_26/2.12,285,fcg_26(:,2),sum(fcg_26(:,3:end),2)));
end

for j=1:size(mdlpstfut85{i},2)
  tomat85_fut(i,j,:)=single(t_cfdb(pinflate(mdlpstfut85{i}(:,j,end),p0,sd),emis_85/2.12,285,fcg_85(:,2),sum(fcg_85(:,3:end),2)));
end
end
