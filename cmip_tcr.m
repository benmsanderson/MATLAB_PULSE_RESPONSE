
   br=NaN(2,numel(mdls));
   for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'onepctCO2'),isfield(ens.(mdls{i}),'piControl'))
      if isfield(ens.(mdls{i}).onepctCO2,'tas')
	   br(:,i)=regress((ens.(mdls{i}).onepctCO2.tas{1}(71:140)-mean(ens.(mdls{i}).piControl.tas{1}(1:150))),[-69:0;ones(1,70)]');
end
end
end
   sens_act=NaN(1,numel(mdls));
   for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'onepctCO2'),isfield(ens.(mdls{i}),'abrupt4xCO2'))
      if isfield(ens.(mdls{i}).abrupt4xCO2,'tas')
	a=((ens.(mdls{i}).abrupt4xCO2.tas{1}-mean(ens.(mdls{i}).piControl.tas{1})));
	rs=((ens.(mdls{i}).abrupt4xCO2.rsut{1}-mean(ens.(mdls{i}).piControl.rsut{1})));
	rl=((ens.(mdls{i}).abrupt4xCO2.rlut{1}-mean(ens.(mdls{i}).piControl.rlut{1})));
	b=regress([a],[-rs-rl,ones(size(a))]);

	sens_act(i)=b(2)/2;
end
end
end
   sens_act(strmatch('MRI_CGCM3',mdls))=NaN;
   
 dt=NaN(1,numel(mdls));
 dt2=NaN(1,numel(mdls));

   for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'rcp85'),isfield(ens.(mdls{i}),'piControl'))
	       if isfield(ens.(mdls{i}).rcp85,'tas')
	 ps=find(and(ens.(mdls{i}).rcp85.year{1}>1940,ens.(mdls{i}).rcp85.year{1}<1960));

	   bs=find(and(ens.(mdls{i}).rcp85.year{1}>1985,ens.(mdls{i}).rcp85.year{1}<2006));
           ft=find(and(ens.(mdls{i}).rcp85.year{1}>2079,ens.(mdls{i}).rcp85.year{1}<2100));
         dt(i)=mean(ens.(mdls{i}).rcp85.tas{1}(ft))-mean(ens.(mdls{i}).rcp85.tas{1}(bs));
         dt2(i)=mean(ens.(mdls{i}).rcp85.tas{1}(bs))-mean(ens.(mdls{i}).rcp85.tas{1}(ps));

end
end
end


 dt4=NaN(1,numel(mdls));

   for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'rcp45'),isfield(ens.(mdls{i}),'piControl'))
      if isfield(ens.(mdls{i}).rcp45,'tas')
	   bs=find(and(ens.(mdls{i}).rcp45.year{1}>1985,ens.(mdls{i}).rcp45.year{1}<2006));
           ft=find(and(ens.(mdls{i}).rcp45.year{1}>2079,ens.(mdls{i}).rcp45.year{1}<2100));
         dt4(i)=mean(ens.(mdls{i}).rcp45.tas{1}(ft))-mean(ens.(mdls{i}).rcp45.tas{1}(bs));

end
end
end




n=0
br1=NaN(2,numel(mdls))
br2=NaN(2,numel(mdls))
tcr4_fx=NaN(numel(mdls),1);
tcr_fx=NaN(numel(mdls),1);
tcr10fx=NaN(numel(mdls),1);

for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2'))
      if and(isfield(ens.(mdls{i}).piControl,'tas'),isfield(ens.(mdls{i}).onepctCO2,'tas'))
n=n+1;
br1(:,i)=regress((ens.(mdls{i}).onepctCO2.tas{1}(1:10)),[1:10;ones(1,10)]');
br2(:,i)=regress((ens.(mdls{i}).piControl.tas{1}),[1:(numel(ens.(mdls{i}).piControl.tas{1}));ones(1,numel(ens.(mdls{i}).piControl.tas{1}))]');

toff(i)=min(max(floor((br1(2,i)-br2(2,i))./br2(1,i)),50),numel(ens.(mdls{i}).piControl.tas{1}));
offst=br2(2,i)+toff(i)*br2(1,i);


ts=ens.(mdls{i}).onepctCO2.tas{1}-offst;
tc_fx=regress(ts(71:140),[-69:0;ones(1,70)]');

ts_4x{i}=ts;
ts_pi{i}=ens.(mdls{i}).piControl.tas{1}(1:toff(i))-offst;
tcr_fx(i)=mean(ts(61:79));
tcr4_fx(i)=tc_fx(2);
tcr10fx(i)=mean(ts(1:10));
end
end
end

tcr4_fx(22)=NaN; %(not onepct)
tcr4_fx(21)=NaN; %(not onepct)
tcr4_fx(50)=NaN; %(not onepct)

 tmp=xlsread('grose.xlsx');

 tcr4_grose=tmp(:,2);
 tcr4_grose((end+1):numel(tcr4_fx))=NaN;
 tcr_grose=tmp(:,1);

 isbth=find(~isnan(tcr4_fx));

figure(2)
n=0
   for i=1:numel(mdls)
  if and(isfield(ens.(mdls{i}),'onepctCO2'),isfield(ens.(mdls{i}),'piControl'))
    if isfield(ens.(mdls{i}).onepctCO2,'tas')
      n=n+1;
      subplot(6,7,n)
      plot([-numel(ts_pi{i}):-1],ts_pi{i},'r');
	    hold on
      plot(ts_4x{i},'k');
      title([mdls{i} '(' num2str(i) ')'],'interpreter','none')
      xlim([-300,140])
end
end
   end
%opts=optimoptions('fmincon')
% opts.Algorithm='quasi-newton'

   figure(3)
   clf
   figure(4)
   clf
   n=0
   popt4x=NaN(numel(mdls),6);
   popt=NaN(numel(mdls),6);

tcr_fit=NaN(numel(mdls),1);
tcr4_fit=NaN(numel(mdls),1);

tcrfun=@(p,t) p(6)+log(1.01)*5.3*(p(1)*(p(3)*(exp(-t/p(3))-1)+t)+p(2)*(p(4)*(exp(-t/p(4))-1)+t));
t4xfun=@(p,t) p(5)+log(4)*5.3*(p(1)*(1-exp(-t/p(3))+p(2)*(1-exp(-t/p(4)))));

   br=NaN(2,numel(mdls));
   for i=1:numel(mdls)
	     if and(isfield(ens.(mdls{i}),'onepctCO2'),isfield(ens.(mdls{i}),'abrupt4xCO2'))
	       if isfield(ens.(mdls{i}).onepctCO2,'tas')
		 if numel(ens.(mdls{i}).abrupt4xCO2.tas{1})>=140
		   if isempty(find(i==[21,22,50]))
	      n=n+1;
	 
	      efun=@(p) sum((tcrfun(p,[0.5:1:139.5])-ens.(mdls{i}).onepctCO2.tas{1}(1:140)').^2)
	p0=[.25,.3,10,100,286,286]


	
	efun4x=@(p) sum((t4xfun(p,(1:140)-.5)-ens.(mdls{i}).abrupt4xCO2.tas{1}(1:140)').^2)
        popt(i,:)=fmincon(efun4x,p0,[],[],[],[],[0,0,0,70,-10,-10],[2,2,50,5000,300,300],[]);
	e_combi=@(p) efun4x(p)+efun(p)
        popt4x(i,:)=fmincon(e_combi,p0,[],[],[],[],[0,0,0,70,-10,-10],[2,2,50,5000,300,300],[]);

	figure(3)
	      subplot(6,7,n)

	      plot(ens.(mdls{i}).onepctCO2.tas{1}(1:140)-popt4x(i,6),'k')
	      hold on
	      plot(tcrfun(popt4x(i,:),(1:140)-.5)-popt4x(i,6),'r')
	      plot(tcrfun(popt(i,:),(1:140)-.5)-popt(i,6),'g')

	      tcr_fit(i)=tcrfun(popt4x(i,:),70)-tcrfun(popt4x(i,:),0)
	      tcr4_fit(i)=tcrfun(popt4x(i,:),140)-tcrfun(popt4x(i,:),0)
	      title([mdls{i} ' ' num2str(i)],'interpreter','none')

	      figure(4)
	     subplot(6,7,n)

	      plot(ens.(mdls{i}).abrupt4xCO2.tas{1}(1:140)-popt4x(i,5),'k')
	      hold on
	      plot(t4xfun(popt4x(i,:),(1:140)-.5)-popt4x(i,5),'r')
	      plot(t4xfun(popt(i,:),(1:140)-.5)-popt4x(i,5),'g')

	      title([mdls{i} ' ' num2str(i)],'interpreter','none')
	      end
	      end
      end
end
end

   tcr4_fit(21)=NaN
      tcr4_fit(22)=NaN
      tcr4_fit(50)=NaN



br=NaN(2,numel(mdls));
n=0
figure(5)
tcr_fix=NaN(numel(mdls),1);
clf
for i=1:numel(mdls)
if and(and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2')),isfield(ens.(mdls{i}),'abrupt4xCO2'))
if isfield(ens.(mdls{i}).piControl,'rsut')
if and(isfield(ens.(mdls{i}).onepctCO2,'rlut'),isfield(ens.(mdls{i}).onepctCO2,'rsut'))
if numel(ens.(mdls{i}).piControl.rlut{1})==numel(ens.(mdls{i}).piControl.rsut{1})
n=n+1;
subplot(8,8,n)
scatter(smooth(ens.(mdls{i}).piControl.rsut{1},1),smooth(ens.(mdls{i}).piControl.rlut{1},1),5,smooth(ens.(mdls{i}).piControl.tas{1},1)-mean(ens.(mdls{i}).piControl.tas{1}))
hold on
scatter(smooth(ens.(mdls{i}).onepctCO2.rsut{1}(1),1),smooth(ens.(mdls{i}).onepctCO2.rlut{1}(1),1),'rx')
caxis([-0.3,0.3])
b=regress(ens.(mdls{i}).piControl.tas{1},[ens.(mdls{i}).piControl.rsut{1},ens.(mdls{i}).piControl.rlut{1},ones(size(ens.(mdls{i}).piControl.rlut{1}))])
bsln(i)=[mean(ens.(mdls{i}).onepctCO2.rsut{1}(1:2)),mean(ens.(mdls{i}).onepctCO2.rlut{1}(1:2)),1]*b;
%plot(ens.(mdls{i}).abrupt4xCO2.rsut{1}-ens.(mdls{i}).abrupt4xCO2.rsut{1}(1),'r')
hold on
%plot(ens.(mdls{i}).abrupt4xCO2.rlut{1}-ens.(mdls{i}).abrupt4xCO2.rlut{1}(1),'k')
title(mdls{i})
b2=regress(ens.(mdls{i}).onepctCO2.tas{1}(121:140)-bsln(i),[-19:0;ones(1,20)]')

rs_1=mean(ens.(mdls{i}).piControl.rsut{1}(100))
rl_1=mean(ens.(mdls{i}).piControl.rlut{1}(100))
tm_1=mean(ens.(mdls{i}).piControl.tas{1}(100))


et=(ens.(mdls{i}).piControl.tas{1}-tm_1).^2+(ens.(mdls{i}).piControl.rsut{1}-rs_1).^2+(ens.(mdls{i}).piControl.rlut{1}-rl_1).^2

tcr_fix(i)=b2(2);
end
end
end
end
end




br=NaN(2,numel(mdls));
bsln_t=NaN(numel(mdls),100);
tcr2_crnd=NaN(numel(mdls),100);
for i=1:numel(mdls)
if and(and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2')),isfield(ens.(mdls{i}),'abrupt4xCO2'))
if isfield(ens.(mdls{i}).piControl,'rsut')
if and(isfield(ens.(mdls{i}).onepctCO2,'rlut'),isfield(ens.(mdls{i}).onepctCO2,'rsut'))
if numel(ens.(mdls{i}).piControl.rlut{1})==numel(ens.(mdls{i}).piControl.rsut{1})
n=n+1;
nt=numel(ens.(mdls{i}).piControl.tas{1});
for j=1:100
ts=ceil(rand*(nt-51));
bsln_t(i,j)=mean(ens.(mdls{i}).piControl.tas{1}(ts:ts+50));
tcr2_crnd(i,j)=mean(ens.(mdls{i}).onepctCO2.tas{1}(61:80))-bsln_t(i,j);
end
end
end
end
end
end



   figure(1)
clf

subplot(2,2,1)
text(tcr4_grose(isbth),dt(isbth),mdls(isbth),'color',[0.8,0.8,0.8],'interpreter','none')
hold on
scatter(tcr4_grose(isbth),dt(isbth),40,dt2(isbth))
text(3.,4,num2str(corr(tcr4_grose(isbth),dt(isbth)','rows','complete')))
xlabel('TCR (grose)')
ylabel('RCP8.5 warming 1850-2100')

subplot(2,2,2)
text(tcr4_fx(isbth),dt(isbth),mdls(isbth),'color',[0.8,0.8,0.8],'interpreter','none')
hold on
 scatter(tcr4_fx(isbth),dt(isbth),40,dt2(isbth))
text(3,4,num2str(corr(tcr4_fx(isbth),dt(isbth)','rows','complete')))

xlabel('TCR')
ylabel('RCP8.5 warming 2000-2100')

subplot(2,2,3)
text(sens_act(isbth),dt(isbth),mdls(isbth),'color',[0.8,0.8,0.8],'interpreter','none')
hold on
scatter(sens_act(isbth),dt(isbth),40,dt2(isbth))
text(2.5,4,num2str(corr(sens_act(isbth)',dt(isbth)'+dt2(isbth)','rows','complete')))

xlabel('Gregory Sensitivity')
ylabel('RCP8.5 warming 2000-2100')

subplot(2,2,4)

text(tcr_fix(isbth),dt(isbth),mdls(isbth),'color',[0.8,0.8,0.8],'interpreter','none')
hold on
scatter(tcr_fix(isbth),dt(isbth),40,dt2(isbth))
text(3,4,num2str(corr(tcr_fix(isbth),dt(isbth)','rows','complete')))

xlabel('TCR fit')
ylabel('RCP8.5 warming 1900-2100')
