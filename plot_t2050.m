figure(45)
clf
prnm={'C,T constraints','C,T,heat constraints','C,T,RWF constraints','C,T,Paleo constraints'}
cols=[0,1,0;0,0,1];
for kk=1:4
subplot(2,2,kk)

for k=1:1%numel(targ)
  plot(ceopt(:,286,k,kk)'-ceopt(:,256,k,kk)',topt(:,286,k,kk),'o','markerfacecolor',[0.9,0.9,0.9],'markeredgecolor',[0.7,0.7,0.7])
  hold on
end

    ax0 = gca;
    set(ax0,'box','off','color','none')
    bx0 = axes('Position',get(ax0,'Position'),'box','on','xtick',[],'ytick',[]);
    axes(ax0)
    linkaxes([ax0 bx0])


for k=1:1%numel(targ)

hold on
bbins=linspace(min(ceopt(:,286,k,kk)'-ceopt(:,256,k,kk)'),max(ceopt(:,286,k,kk)'-ceopt(:,256,k,kk)'),100);
for i=1:numel(bbins)
  cnds=find(abs(ceopt(:,286,k,kk)'-ceopt(:,256,k,kk)'-bbins(i))<50);
  brng(i,:)=prctile(topt(cnds,286,k,kk),[10,50,90]);    
end

for j=1:3
  brngs(:,j)=smooth(brng(:,j),80,'lowess');
end
%[p1,a]=areabar(tim,tmat,bnd,col,fillbar,fillbarls,alpa,hatch,ng,dots)
pl(k)=areabar(bbins,brngs,0,[0.5,0.5,0.5],1,'-',0.2,0,6,1)
end



xlabel('2020-2050 net carbon emitted (GtC)')
ylabel({'2050 warming above pre-industrial (K)'})

cemis_26=cumsum(emis_26);
cemis_85=cumsum(emis_85);

xlim([20,500])
ylim([1,2.5])
caxis([1.5,2])


grid on

ax1 = gca; % current axes

ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ylabel({'2050-2100 rate of net','carbon removal for stabilization (GtC/yr)'})
ylim([-1000,500]/50)
xlim([20,500])
set(gca,'xtick',timmp)
lbs=cellfun(@(x) ['\textsf{' num2str(x) '}'],num2cell(timscl),'UniformOutput',0);



lbs(11:14)={''};
lbs(16)={''};
lbs(end)={'$\infty\to$'};



set(gca,'xticklabel',lbs)
set(gca,'TickLabelInterpreter','latex')
xlabel({'Change in 2050 emissions from 2020 (% 2020 emissions)'})
set(gca,'ytick',[-20:10:10])
yt=get(gca,'yticklabel')
yts=cellfun(@(x) ['\textsf{' x '}'],yt,'UniformOutput',0);
set(gca,'yticklabel',yts)
title(['(' char(96+kk) ') ' prnm{kk} ]) 

end



   set(gcf, 'PaperPosition', [0 0 15 12]);
set(gcf, 'PaperSize', [15 12]); 
print(gcf,'-dpdf','-painters',['t2050.pdf']);
