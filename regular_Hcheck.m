function [count_r,count_c, sumx, sumy] = regular_Hcheck(H)

    [a,b] = size(H)
    
    %find the sum of one row
    sum_init =sum(H(1,:))
    count_r =0
    count_c =0
    
    %for each row
    for x= 1:a
       sumx(x) =  sum(H(x,:))
           if (sumx(x) ~= sum_init)
               count_r = count_r+1;
           end
    end
    
    sum_inity =sum(H(:,1))
    for y= 1:b
       sumy(y) =  sum(H(:,y))
           if (sumy(y) ~= sum_inity)
               count_c = count_c+1;
           end
    end
        
    
end