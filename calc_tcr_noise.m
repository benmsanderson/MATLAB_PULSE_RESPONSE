function [tcr,tcr_140,t]=calc_tcr_noise(p,d,ta)
  sfcg=5.35*log([1.01.^([1:150])])';;
    dfcg=0*ones(ta,1);
    fcg=[dfcg;sfcg];
    fcg=randn(size(fcg))*d+fcg;

%  p_t=p(8:16);
  to=t_rsp(p,fcg);
  t=to-mean(to((ta-99):ta));
  tcr=mean(t(ta+(61:80)));
  tcr_140=mean(t(ta+(131:150)));
				%  r=-r_rsp(p_t,fcg);

  
  
