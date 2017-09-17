
fp=fopen('top_level_ldpc.v','w');

    fprintf(fp, 'module LDPC_decoder_TOP(clk, rst, ', i);

    
for(i=1:size(H,2))

    fprintf(fp, 'L%d,\n', i);
    
end;

for(i=1:size(H,2))

    fprintf(fp, 'P%d,\n', i);
    
end;

    fprintf(fp, ')\n');
    
    
    fprintf(fp, 'input clk;\n');

    fprintf(fp, 'input rst;\n');


    
for(i=1:size(H,2))

    fprintf(fp, 'input signed [31:0] L%d;\n', i);

end;


for(i=1:size(H,2))

    fprintf(fp, 'output P%d;\n', i);

end;



    


for(i=1:size(H,1))
    for(j=1:size(H,2))
        if(H(i,j)==1)
    fprintf(fp, 'wire signed [31:0] R%d_%d;\n', i,j);
        end
    end
end;


for(i=1:size(H,1))
    for(j=1:size(H,2))
        if(H(i,j)==1)
    fprintf(fp, 'wire signed [31:0] Q%d_%d;\n', i,j);
        end
    end
end;

    

for(i=1:size(H,1))
    
    ind=sum(H(i,:))  ;  
    
        fprintf(fp, 'CNU_%d CNU%d(', ind, i);
        
    for(j=1:size(H,2))

        if(H(i,j)==1)
            fprintf(fp, 'R%d_%d, ',i, j);
        end;
    end;
    

        
    for(j=1:size(H,2))    
        if(H(i,j)==1)
            fprintf(fp, 'Q%d_%d, ',i, j);
        end;
    end;
    
        
        fprintf(fp, 'clk );\n');
        
end;

 fprintf(fp,'\n\n\n\');



for(j=1:size(H,2))
    
            ind=sum(H(:,j))  ;  
            
        fprintf(fp, 'VNU_%d VNU%d(', ind, j);
        
    for(i=1:size(H,1))

        if(H(i,j)==1)
            fprintf(fp, 'Q%d_%d, ', i,j);
        end;
    end;
    

    for(i=1:size(H,1))    
        if(H(i,j)==1)
            fprintf(fp, 'R%d_%d, ', i,j);
        end;
    end;
    
        
        fprintf(fp, 'L%d, P%d, clk );\n', j, j);
        
end;


fprintf(fp, 'endmodule');

fclose(fp);



        
    
        