function [ R ] = variable_node_processing(llr, check_node )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

R=cell(length(check_node),1);


for(i=1:length(check_node))
    temp_nodes=check_node{i};
    llr_temp_nodes= llr(temp_nodes);
    
    min_sum_llr=[];
    
 for(j=1:length(temp_nodes))
    min_sum_llr(j)=calculate_minsum(llr_temp_nodes,j);
 end;
 
 temp_nodes
 
min_sum_llr

    R{i}=[min_sum_llr ; temp_nodes];
    
end;


end
