
fp=fopen('top_level_ldpc_tb.v','w');

    fprintf(fp, 'module tb()\n');

    
for(i=1:size(H,2))

    fprintf(fp, 'reg signed [31:0] L%d;\n', i);
    
end;

for(i=0:(size(H,2)-1))

    fprintf(fp, 'wire P[%d];\n', i);
    
end;

% for(i=1:size(H,2))
% 
%     fprintf(fp, 'wire P%d;\n', i);
%     
% end;


   fprintf(fp, 'reg clk;');
   fprintf(fp, 'reg rst;');

    fprintf(fp, '\n');
    
    
    fprintf(fp, 'LDPC_decoder_TOP LDPC1(');
    
    for(i=1:size(H,2))

    fprintf(fp, 'L%d,', i);
    
end;

for(i=1:size(H,2))

    fprintf(fp, 'P%d,', i);
    
end;
    
fprintf(fp, 'clk,rst);\n');

fprintf(fp, 'initial begin\n');
fprintf(fp, '#0 clk =1''b0;\n');
fprintf(fp, '#0 rst = 1''b1;\n');
fprintf(fp, '#5 clk =1''b1;\n');
fprintf(fp, '#5 clk =1''b0;\n');
fprintf(fp, '#5 clk =1''b1;\n');
fprintf(fp, '#20 rst = 1''b0;\n');

fprintf(fp, 'forever #5 clk = ~clk;\n');
fprintf(fp, 'end\n');

fprintf(fp, 'initial\n');
fprintf(fp, 'begin\n');

for i= 1:length(llr)
    if ((llr(1,i) > 0))
        fprintf(fp,'L%d = 32''d%d;\n', i,llr(1,i));
    else
        fprintf(fp,'L%d = -32''d%d;\n', i,(-llr(1,i)));
    end
end

  fprintf(fp,'f = $fopen("output.txt");\n');
  fprintf(fp,'$fmonitor(f, "%d\n",P);\n');
  fprintf(fp,'#100\n');
  fprintf(fp,'$fclose(f);\n');
  fprintf(fp,'$finish;\n');

%fprintf(fp, '\n\n #100\n');
%fprintf(fp, '$finish;\n');
fprintf(fp, 'end\n');
fprintf(fp, 'endmodule\n');


        