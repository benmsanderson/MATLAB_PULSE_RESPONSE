function [tcre]=calc_tcre(p)



      comat0=prm_fast(p,ones(200,1)*30,285,zeros(200,1),zeros(200,1));

      cotarg=285*1.01.^(1:200);
      comat=comat0;
      emmat=ones(200,1)*30;
      for i=1:numel(cotarg)-1
	cotmp=prm_fast(p,emmat,285,zeros(200,1),zeros(200,1));
        dcnc=cotmp(i+1)-cotarg(i+1);
	emmat(i)=emmat(i)-dcnc/2.12;
      end
      

      
      

      cemis=cumsum(emmat);
      tomat=t_cfdb(p,emmat,285,zeros(200,1),zeros(200,1));

      t1000=min(find(cemis>(1000)));
      tcre=tomat(t1000);
