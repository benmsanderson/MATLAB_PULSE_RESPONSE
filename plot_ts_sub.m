
  figure(1)
  clf
  subplot(4,2,1)
  % plot(tim21,tomat85','color',[0.7,0.4,0.4])
  p85=areabar(tim21,tomat85',10,[0.7,0.4,0.4]);
      p26=areabar(tim3000,tomat26',10,[0.4,0.4,0.7]);
      p26ne=areabar(tim3000,tomat26ne',10,[0.4,0.7,0.4]);
    plot(tim_had,gm_had,'k','linewidth',2);
   xlim([1970,2300]);
   ylim([0,5]);
   xlabel('Year');
   ylabel({'Global mean temperature','above 1850 (K)'});
   title('(a)');
   ax1=gca;
grid on
  subplot(4,2,3)
  % plot(tim21,tomat85','color',[0.7,0.4,0.4])
  p85cf=areabar(tim21,tomat85cf',10,[0.7,0.4,0.4]);
      p26cf=areabar(tim3000,tomat26cf',10,[0.4,0.4,0.7]);
      p26necf=areabar(tim3000,tomat26necf',10,[0.4,0.7,0.4]);
    plot(tim_had,gm_had,'k','linewidth',2);
   xlim([1970,2300]);
   ylim([0,5]);
   xlabel('Year');
   ylabel({'Global mean temperature','above 1850 (K)'});
   title('(c)');
   ax2=gca;
   grid on
   

  subplot(4,2,5)
  % plot(tim21,tomat85','color',[0.7,0.4,0.4])
  p85nl=areabar(tim21,tomat85nl',10,[0.7,0.4,0.4]);
      p26nl=areabar(tim3000,tomat26nl',10,[0.4,0.4,0.7]);
      p26nenl=areabar(tim3000,tomat26nenl',10,[0.4,0.7,0.4]);
    plot(tim_had,gm_had,'k','linewidth',2);
   xlim([1970,2300]);
   ylim([0,5]);
   xlabel('Year');
   ylabel({'Global mean temperature','above 1850 (K)'});
   title('(e)');
   ax2=gca;
grid on

  subplot(4,2,7)
  % plot(tim21,tomat85','color',[0.7,0.4,0.4])
  p85ml=areabar(tim21,tomat85ml',10,[0.7,0.4,0.4]);
      p26ml=areabar(tim3000,tomat26ml',10,[0.4,0.4,0.7]);
      p26neml=areabar(tim3000,tomat26neml',10,[0.4,0.7,0.4]);
    plot(tim_had,gm_had,'k','linewidth',2);
   xlim([1970,2300]);
   ylim([0,5]);
   xlabel('Year');
   ylabel({'Global mean temperature','above 1850 (K)'});
   title('(g)');
   ax2=gca;
   grid on

   subplot(4,2,2)
     p85=areabar(ce,ce_int85_ne',10,[0.7,0.4,0.4]);
   hold on
   p26=areabar(ce,ce_int26_up',10,[0.4,0.4,0.7]);
   areabar(ce,ce_int26_dn',10,[0.4,0.4,0.7]);
   p26ne=areabar(ce,ce_int26_ne',10,[0.4,0.7,0.4],1);

  po=plot(ce,ce_obs','k','linewidth',2);
   ax2=gca;
   axp=get(gca,'position')

   ylim([0,4]);
   xlabel({'Cumulative emissions (GtC)'})   ;
   ylabel({'Global Mean Temperature','above 1850 (K)'});
   title('(b)');
   grid on

   subplot(4,2,4)
     p85=areabar(ce,ce_int85_necf',10,[0.7,0.4,0.4]);
   hold on
   p26=areabar(ce,ce_int26_upcf',10,[0.4,0.4,0.7]);
   areabar(ce,ce_int26_dncf',10,[0.4,0.4,0.7]);
   p26ne=areabar(ce,ce_int26_necf',10,[0.4,0.7,0.4],1);

  po=plot(ce,ce_obs','k','linewidth',2);
   ax2=gca;
   axp=get(gca,'position')

   ylim([0,4]);
   xlabel({'Cumulative emissions (GtC)'})   ;
   ylabel({'Global Mean Temperature','above 1850 (K)'});
   title('(d)');
   grid on

   subplot(4,2,6)
     p85=areabar(ce,ce_int85_nenl',10,[0.7,0.4,0.4]);
   hold on
   p26=areabar(ce,ce_int26_upnl',10,[0.4,0.4,0.7]);
   areabar(ce,ce_int26_dnnl',10,[0.4,0.4,0.7]);
   p26ne=areabar(ce,ce_int26_nenl',10,[0.4,0.7,0.4],1);

  po=plot(ce,ce_obs','k','linewidth',2);
   ax2=gca;
   axp=get(gca,'position')

   ylim([0,4]);
   xlabel({'Cumulative emissions (GtC)'})   ;
   ylabel({'Global Mean Temperature','above 1850 (K)'});
   title('(f)');
   grid on

   subplot(4,2,8)
     p85=areabar(ce,ce_int85_neml',10,[0.7,0.4,0.4]);
   hold on
   p26=areabar(ce,ce_int26_upml',10,[0.4,0.4,0.7]);
   areabar(ce,ce_int26_dnml',10,[0.4,0.4,0.7]);
   p26ne=areabar(ce,ce_int26_neml',10,[0.4,0.7,0.4],1);

  po=plot(ce,ce_obs','k','linewidth',2);
   ax2=gca;
   axp=get(gca,'position')

   ylim([0,4]);
   xlabel({'Cumulative emissions (GtC)'})   ;
   ylabel({'Global Mean Temperature','above 1850 (K)'});
   title('(f)');
   grid on


   
stop

   p85cf=areabar(ce,ce_int85_necf',10,[0.7,0.4,0.4],0,':');
%   p85nl=areabar(ce,ce_int85_nenl',10,[0.7,0.4,0.4],0,'--');

xlim([0,1000])

   p26ne=areabar(ce,ce_int26_ne',10,[0.4,0.7,0.4],1);
   p26necf=areabar(ce,ce_int26_necf',10,[0.4,0.7,0.4],0,':');
   p26nenl=areabar(ce,ce_int26_nenl',10,[0.4,0.7,0.4],0,'--');
   p26neml=areabar(ce,ce_int26_neml',10,[0.4,0.7,0.4],0,'-.');

   p26=areabar(ce,ce_int26_up',10,[0.4,0.4,0.7]);
   p26cf=areabar(ce,ce_int26_upcf',10,[0.4,0.4,0.7],0,':');
   p26nl=areabar(ce,ce_int26_upnl',10,[0.4,0.4,0.7],0,'--');
      p26ml=areabar(ce,ce_int26_upml',10,[0.4,0.4,0.7],0,'-.');

   areabar(ce,ce_int26_dn',10,[0.4,0.4,0.7]);
      areabar(ce,ce_int26_dncf',10,[0.4,0.4,0.7],0,':');
         areabar(ce,ce_int26_dnnl',10,[0.4,0.4,0.7],0,'--',0.2,1);
         areabar(ce,ce_int26_dnml',10,[0.4,0.4,0.7],0,'-.');

   %   areabar(ce,ce_int26_dncf',5,[0.4,0.4,0.7],0)
   po=plot(ce,ce_obs','k','linewidth',2);
   ax2=gca;
   axp=get(gca,'position')
   %l=legend([p85,p85cf,p85nl,p26,p26cf,p26nl,p26ne,p26necf,p26nenl],'RCP8.5 (uninf)','RCP8.5 (paleo)','RCP8.5 (mixed)',...
   %      'RCP2.6 (uninf)','RCP2.6 (paleo)','RCP2.6 (mixed)',...
   %    'RCP2.6-noneg (uninf)','RCP2.6-noneg (paleo)',['RCP2.6-noneg ' ...
   %                '(mixed)'],'location','southoutside');
%l=legend([p85,p26ne,p26,p26cf,p26ml,p26nl],'RCP8.5 (uninf)', 'RCP2.6-noneg (uninf)', 'RCP2.6 (uninf)','RCP2.6 (paleo)','RCP2.6 (RWF)','RCP2.6 (No heat constraint)');

   ylim([0,4]);
   xlabel({'Cumulative emissions (GtC)'})   ;
   ylabel({'Global Mean Temperature','above 1850 (K)'});
   title('(d)');
   set(ax1,'position',[0.08,0.1,0.4,0.45])
   set(ax2,'position',[0.58,0.1,0.4,0.45])
 %  set(l,'position',[0.77,0.35,0.2,0.15])
 %  plot_spdf   
   
 %  set(p_tcr,'position',[0.58,0.66,0.4,0.3])
  % set(p_sns,'position',[0.08,0.66,0.4,0.3])

   
   subplot(2,2,[1,2])

   plot([1,2],[3,3],'--','color',[0.7,0.4,0.4],'linewidth',2)
   hold on
   plot([2.5,3.5],[3,3],'-','color',[0.7,0.4,0.4],'linewidth',2)
   plot([4,5],[3,3],'-.','color',[0.7,0.4,0.4],'linewidth',2)
   plot([5.5,6.5],[3,3],':','color',[0.7,0.4,0.4],'linewidth',2)
   text(0.5,4,'Prior','FontWeight','bold','HorizontalAlignment','right')
   text(0.5,0,'Constraint','FontWeight','bold','HorizontalAlignment','right','VerticalAlignment','top')


   text(7,3,'RCP8.5','fontweight','bold')
   text(1,4,'Flat')
   text(1,0,{'C,T'},'VerticalAlignment','top')
   text(2.5,4,'Flat')
   text(2.5,0,{'C,T','heat'},'VerticalAlignment','top')
   text(5.5,4,'Paleo')
   text(5.5,0,'C,T','VerticalAlignment','top')
   text(4,4,'Flat')
   text(4,0,{'C,T','heat','RWF'},'VerticalAlignment','top')


   
   plot([1,2],[2,2],'--','color',[0.4,0.7,0.4],'linewidth',2)
   hold on
   plot([2.5,3.5],[2,2],'-','color',[0.4,0.7,0.4],'linewidth',2)
   plot([4,5],[2,2],'-.','color',[0.4,0.7,0.4],'linewidth',2)
   plot([5.5,6.5],[2,2],':','color',[0.4,0.7,0.4],'linewidth',2)
   text(7,2,'RCP2.6(noneg)','fontweight','bold')

   plot([1,2],[1,1],'--','color',[0.4,0.4,0.7],'linewidth',2)
   hold on
   plot([2.5,3.5],[1,1],'-','color',[0.4,0.4,0.7],'linewidth',2)
   plot([4,5],[1,1],'-.','color',[0.4,0.4,0.7],'linewidth',2)
   plot([5.5,6.5],[1,1],':','color',[0.4,0.4,0.7],'linewidth',2)
   text(7,1,'RCP2.6','fontweight','bold')

   axis([-3,10,-3,5])
   set(gca,'XTick',[])
   set(gca,'YTick',[]) 
   
   
   
   set(gcf, 'PaperPosition', [0 0 11 5]);
set(gcf, 'PaperSize', [11 5]); 
print(gcf,'-dpdf','-painters',['ce.pdf']);


  
  
