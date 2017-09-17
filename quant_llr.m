llrq= round(llr*2^10);

fid = fopen('llr_quant.txt', 'wt')
    for i=1:576
       n = (llrq(1,i));
        if(n > (2^10-1))
            n = 2^10 -1;
        elseif(n < -2^10)
            n = 2^-10;      
        end
    
       out = dec2bin(typecast(int32(n), 'uint32'));
       fprintf(fid, '%s\n', out);
    end
    fclose(fid);