function [ min_sum_llr ] = calculate_minsum( llr_temp_nodes,i )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


   min_sum_llr =min(setdiff(abs(llr_temp_nodes), i));
   
   sign_llr=sign(setdiff(llr_temp_nodes, i));
   
   signo_llr=1;
   for(i=1:length(sign_llr))
       signo_llr=signo_llr*sign_llr(i);
   end;
   
   signo_llr=sign(signo_llr);
       
min_sum_llr=min_sum_llr*signo_llr;

   

end

