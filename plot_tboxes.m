

br=NaN(2,numel(mdls));
bsln_t=NaN(numel(mdls),100);
tcr2_crnd=NaN(numel(mdls),100);
clear userndt
bsln_trnd=NaN(numel(mdls),1);
n=0
for i=1:numel(mdls)
if and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'onepctCO2'))
    if numel(ens.(mdls{i}).onepctCO2.tas{1})>=150
n=n+1;
nt=numel(ens.(mdls{i}).piControl.tas{1});
for j=1:100
ts=ceil(rand*(nt-51));
bsln_t(i,j)=mean(ens.(mdls{i}).piControl.tas{1}(ts:ts+50));
bsln_rl(i,j)=mean(ens.(mdls{i}).piControl.rlut{1}(ts:ts+50));
bsln_rs(i,j)=mean(ens.(mdls{i}).piControl.rsut{1}(ts:ts+50));

tcr2_crnd(i,j)=mean(ens.(mdls{i}).onepctCO2.tas{1}(61:80))-bsln_t(i,j);
tcr2_brnd(i,j)=mean(ens.(mdls{i}).onepctCO2.tas{1}(1:20))-bsln_t(i,j);

t140_arnd(i,j)=mean(ens.(mdls{i}).onepctCO2.tas{1}(131:150))-bsln_t(i,j);

 [b,bint,~,~,stats] =regress(ens.(mdls{i}).onepctCO2.tas{1}(1:70)-mn,[(1:70)',ones(70,1)]);
 extrap_bs(i)=b(2)+mn;
 t140_eb(i)=mean(ens.(mdls{i}).onepctCO2.tas{1}(131:150))-extrap_bs(i);
	userndt(n)=i;
	[b,bint,r,~,stats] =regress(ens.(mdls{i}).piControl.tas{1},[(1:numel(ens.(mdls{i}).piControl.tas{1}))',ones(size(ens.(mdls{i}).piControl.tas{1}))]);
	bsln_trnd(i)=b(1);
	end
end
end
end

clear usernda
sens_arnd=NaN(numel(mdls),100);
n=0
for i=1:numel(mdls)
if and(isfield(ens.(mdls{i}),'piControl'),isfield(ens.(mdls{i}),'abrupt4xCO2'))
if isfield(ens.(mdls{i}).piControl,'rsut')
if and(isfield(ens.(mdls{i}).abrupt4xCO2,'rlut'),isfield(ens.(mdls{i}).abrupt4xCO2,'rsut'))
  if numel(ens.(mdls{i}).piControl.rlut{1})==numel(ens.(mdls{i}).piControl.rsut{1})
    if and(numel(ens.(mdls{i}).abrupt4xCO2.tas{1})>=150,numel(ens.(mdls{i}).piControl.tas{1})>=150)
n=n+1;
nt=numel(ens.(mdls{i}).piControl.tas{1});
for j=1:100
ts=ceil(rand*(nt-51));
bsln_t(i,j)=mean(ens.(mdls{i}).piControl.tas{1}(ts:ts+50));
bsln_rl(i,j)=mean(ens.(mdls{i}).piControl.rlut{1}(ts:ts+50));
bsln_rs(i,j)=mean(ens.(mdls{i}).piControl.rsut{1}(ts:ts+50));

	a=((ens.(mdls{i}).abrupt4xCO2.tas{1}-bsln_t(i,j)));
	rs=((ens.(mdls{i}).abrupt4xCO2.rsut{1}-bsln_rl(i,j)));
	rl=((ens.(mdls{i}).abrupt4xCO2.rlut{1}-bsln_rs(i,j)));
	b=regress([a],[-rs-rl,ones(size(a))]);

	sens_arnd(i,j)=b(2)/2;
	a140_arnd(i,j)=mean(a(131:150));
	usernda(n)=i;
	end
end
end
end
end
end
end

usernd=intersect(usernda,userndt);




figure('Color', 'w');
clf
c = colormap(lines(4));


A = [sens_arnd(usernd,:)',tcr2_crnd(usernd,:)',t140_arnd(usernd,:)',a140_arnd(usernd,:)'];
A=NaN(100,numel(usernd)*5);
for i=1:numel(usernd)
  A(:,1:5:end)=sens_arnd(usernd,:)';
  A(:,2:5:end)=tcr2_crnd(usernd,:)';
  A(:,3:5:end)=t140_arnd(usernd,:)';
  A(:,4:5:end)=a140_arnd(usernd,:)';
  lbl{5*i-4}='';
    lbl{5*i-3}='';
  lbl{5*i-2}=mdls{usernd(i)};
  lbl{5*i-1}='';
  lbl{5*i}='';
end

C = repmat([c; ones(1,3)],numel(usernd),1); 

% regular plot
boxplot(A, 'colors', C, 'plotstyle', 'compact', ...
    'labels', lbl,'symbol','','medianstyle','line'); % label only two categories
hold on;
for ii = 1:4
    plot(NaN,1,'color', c(ii,:), 'LineWidth', 4);
end

for i=1:numel(usernd)
plot([i*5,i*5],[0,10],'k:')
end
ylabel('(K)');
legend({'EffCS','TCR','T140','A140'},'location','northwest');

title('Sensitivity of metrics to baseline period used')



   set(gcf, 'PaperPosition', [0 0 7 5]);
set(gcf, 'PaperSize', [7 5]); 
print(gcf,'-dpdf','-painters',['tbox.pdf']);
