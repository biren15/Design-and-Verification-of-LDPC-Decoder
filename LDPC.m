sum_parity=[];

check_node=cell(size(H,1),1);
for(i=1:size(H,1))
    for(j=1:size(H,2))
    if(H(i,j)==1)
        check_node{i}=[check_node{i} j];
    else
        ;
    end;
    end;
end;


Q=[];
   
for(i=1:size(H,1))
    Q=[Q llr'];
end;

for(interation=1:1000)

[ processed_llr ] = check_node_processing(Q, check_node);

Processed_llr_in_varibale_form=cell(size(H,2),1);

for(i=1:length(processed_llr))
    temp=processed_llr{i};
    for(j=1:size(temp,2))
    Processed_llr_in_varibale_form{round(temp(2,j))}=[Processed_llr_in_varibale_form{round(temp(2,j))} [temp(1,j);i]];
    end;
end;
    
        
for(i=1:length(Processed_llr_in_varibale_form))
    temp=Processed_llr_in_varibale_form{i};
    
    for(j=1:size(temp,2))
        Q(i,temp(2,j))=sum(setdiff(temp(1,:), temp(1,j)));
    end;
end;

for(i=1:size(Q,1))
    for(j=1:size(Q,2))
        Q(i,j)=Q(i,j)+llr(i);
    end;
end;

P=[];
for(i=1:length(Processed_llr_in_varibale_form))
    temp=Processed_llr_in_varibale_form{i};
    P(i)=sum(temp(1,:));    
end;

P=P+llr;

for(jj=1:length(P))
    if(P(jj)>=0)
        estimated_output(jj)=0;
    else
        estimated_output(jj)=1;
    end;
end;

parity_mat=H*estimated_output';

sum_parity=[sum_parity sum(parity_mat) ];

if(sum(parity_mat)==0)
    break;
    break;
end;

        
end;

