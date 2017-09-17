%   File: InitializeWiMaxLDPC.m
% 
%    Description: Initializes the WiMax LDPC encoder/decoder
% 
%    The calling syntax is:
%       [H_rows, H_cols, P] = InitializeWiMaxLDPC( rate, size, ind )
% 
%    Where:
%       H_rows = a M-row matrix containing the indices of the non-zero rows of H excluding the dual-diagonal portion of H.
% 	    H_cols = a (N-M)+z-row matrix containing the indices of the non-zeros rows of H.
%       P      = a z times z matrix used in encoding
% 
%       rate = the code rate
% 	    size = the size of the code (number of code bits):
% 	         = 576:96:2304 
% 		ind  = Selects either code 'A' or 'B' for rates 2/3 and 3/4
%            = 0 for code rate type 'A'
%            = 1 for code rate type 'B'
%            = [empty array] for all other code rates
%
%    Copyright (C) 2007-2008, Rohit Iyer Seshadri and Matthew C. Valenti
% 
%    Last updated on June. 23, 2007.
% 
%    Function InitializeWiMaxLDPC is part of the Iterative Solutions 
%    Coded Modulation Library. The Iterative Solutions Coded Modulation 
%    Library is free software; you can redistribute it and/or modify it 
%    under the terms of the GNU Lesser General Public License as published 
%    by the Free Software Foundation; either version 2.1 of the License, 
%    or (at your option) any later version.
% 
%    This library is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%    Lesser General Public License for more details.
%   
%    You should have received a copy of the GNU Lesser General Public
%    License along with this library; if not, write to the Free Software
%    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

function [H]= InitializeWiMaxLDPC(rate, nldpc, ind)

epsilon=1e-3;
rt_flag=0;
if (abs(rate-1/2) <epsilon )
   rt_flag=1;  
   Hbm=[-1 94 73 -1 -1 -1 -1 -1 55 83 -1 -1 7 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;...
        -1 27 -1 -1 -1 22 79 9 -1 -1 -1 12 -1 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1;...  
        -1 -1 -1 24 22 81 -1 33 -1 -1 -1 0 -1 -1 0 0 -1 -1 -1 -1 -1 -1 -1 -1;...
         61 -1 47 -1 -1 -1 -1 -1 65 25 -1 -1 -1 -1 -1 0 0 -1 -1 -1 -1 -1 -1 -1;...
         -1 -1 39 -1 -1 -1 84 -1 -1 41 72 -1 -1 -1 -1 -1 0 0 -1 -1 -1 -1 -1 -1;...
         -1 -1 -1 -1 46 40 -1 82 -1 -1 -1 79 0 -1 -1 -1 -1 0 0 -1 -1 -1 -1 -1;...
         -1 -1 95 53 -1 -1 -1 -1 -1 14 18 -1 -1 -1 -1 -1 -1 -1 0 0 -1 -1 -1 -1;...
         -1 11 73 -1 -1 -1 2 -1 -1 47 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 -1 -1 -1;...
          12 -1 -1 -1 83 24 -1 43 -1 -1 -1 51 -1 -1 -1 -1 -1 -1 -1 -1 0 0 -1 -1;...
          -1 -1 -1 -1 -1 94 -1 59 -1 -1 70 72 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 -1;...
          -1 -1 7 65 -1 -1 -1 -1 39 49 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0;...
          43 -1 -1 -1 -1 66 -1 41 -1 -1 -1 26 7 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0];
  
end
if (abs(rate -2/3) <epsilon)
  rt_flag=1;  
  if (ind ==0)     
      Hbm =[ 3  0 -1 -1  2 0 -1 3 7 -1 1 1 -1 -1 -1 -1 1 0 -1 -1 -1 -1 -1 -1;...    
            -1 -1  1 -1 36 -1 -1 34 10 -1 -1 18 2 -1 3 0 -1 0 0 -1 -1 -1 -1 -1;...   
            -1 -1 12 2 -1 15 -1 40 -1 3 -1 15 -1 2 13 -1 -1 -1 0 0 -1 -1 -1 -1;...
            -1 -1 19 24 -1 3 0 -1 6 -1 17 -1 -1 -1 8 39 -1 -1 -1 0 0 -1 -1 -1;...
             20 -1 6 -1 -1 10 29 -1 -1 28 -1 14 -1 38 -1 -1 0 -1 -1 -1 0 0 -1 -1;...
            -1 -1 10 -1 28 20 -1 -1 8 -1 36 -1 9 -1 21 45 -1 -1 -1 -1 -1 0 0 -1;...
             35 25 -1 37 -1 21 -1 -1 5 -1 -1 0 -1 4 20 -1 -1 -1 -1 -1 -1 -1 0 0;...
             -1 6 6 -1 -1 -1 4 -1 14 30 -1 3 36 -1 14 -1 1 -1 -1 -1 -1 -1 -1 0];    
   elseif (ind ==1)
      Hbm =[2 -1 19 -1 47 -1 48 -1 36 -1 82 -1 47 -1 15 -1 95 0 -1 -1 -1 -1 -1 -1;...
            -1 69 -1 88 -1 33 -1 3 -1 16 -1 37 -1 40 -1 48 -1 0 0 -1 -1 -1 -1 -1;...   
             10 -1 86 -1 62 -1 28 -1 85 -1 16 -1 34 -1 73 -1 -1 -1 0 0 -1 -1 -1 -1;...
            -1 28 -1 32 -1 81 -1 27 -1 88 -1 5 -1 56 -1 37 -1 -1 -1 0 0 -1 -1 -1 ;...
             23 -1 29 -1 15 -1 30 -1 66 -1 24 -1 50 -1 62 -1 -1 -1 -1 -1 0 0 -1 -1;...
            -1 30 -1 65 -1 54 -1 14 -1 0 -1 30 -1 74 -1 0 -1 -1 -1 -1 -1 0 0 -1;...
            32 -1 0 -1 15 -1 56 -1 85 -1 5 -1 6 -1 52 -1 0 -1 -1 -1 -1 -1 0 0;...
            -1 0 -1 47 -1 13 -1 61 -1 84 -1 55 -1 78 -1 41 95 -1 -1 -1 -1 -1 -1 0];   
    end
end

if (abs(rate-3/4)<epsilon)
   
   rt_flag=1;  
   if (ind ==0)  
       Hbm=[6 38 3 93 -1 -1 -1 30 70 -1 86 -1 37 38 4 11 -1 46 48 0 -1 -1 -1 -1;...
            62 94 19 84 -1 92 78 -1 15 -1 -1 92 -1 45 24 32 30 -1 -1 0 0 -1 -1 -1;...
            71 -1 55 -1 12 66 45 79 -1 78 -1 -1 10 -1 22 55 70 82 -1 -1 0 0 -1 -1;...
            38 61 -1 66 9 73 47 64 -1 39 61 43 -1 -1 -1 -1 95 32 0 -1 -1 0 0 -1;...
            -1 -1 -1 -1 32 52 55 80 95 22 6 51 24 90 44 20 -1 -1 -1 -1 -1 -1 0 0;...   
            -1 63 31 88 20 -1 -1 -1 6 40 56 16 71 53 -1 -1 27 26 48 -1 -1 -1 -1 0];
   elseif (ind ==1)
          Hbm= [-1 81 -1 28 -1 -1 14 25 17 -1 -1 85 29 52 78 95 22 92 0 0 -1 -1 -1 -1;...
                42 -1 14 68 32 -1 -1 -1 -1 70 43 11 36 40 33 57 38 24 -1 0 0 -1 -1 -1;...
                -1 -1 20 -1 -1 63 39 -1 70 67 -1 38 4 72 47 29 60 5 80 -1 0 0 -1 -1;...
                64 2 -1 -1 63 -1 -1 3 51 -1 81 15 94 9 85 36 14 19 -1 -1 -1 0 0 -1;...
                -1 53 60 80 -1 26 75 -1 -1 -1 -1 86 77 1 3 72 60 25 -1 -1 -1 -1 0 0;...
                77 -1 -1 -1 15 28 -1 38 -1 72 30 68 85 84 26 64 11 89 0 -1 -1 -1 -1 0];
    end
end
if (abs(rate-5/6)<epsilon)
    rt_flag=1;
    Hbm= [1 25 55 -1 47 4 -1 91 84 8 86 52 82 33 5 0 36 20 4 77 80 0 -1 -1;...
          -1 6 -1 36 40 47 12 79 47 -1 41 21 12 71 14 72 0 44 49 0 0 0 0 -1;...
          51 81 83 4 67 -1 21 -1 31 24 91 61 81 9 86 78 60 88 67 15 -1 -1 0 0;...
          50 -1 50 15 -1 36 13 10 11 20 53 90 29 92 57 30 84 92 11 66 80 -1 -1 0];
end


if (rt_flag ==0)
        error('This rate is not supported');    
 end
if(length(find(nldpc==[576:96:2304]))~=1)
        error('This codeword length is not supported');    
end

z =nldpc/24;
z0 =96;
[m, n]= size(Hbm);
row_ind=zeros(1,n);
col_ind=zeros(1,m);
cnt1=1;
for i=1:m    
    row_ind(i) =length( find(Hbm(i, :)~=-1));
    cnt2=1;
    for j=1:n
        col_ind(j) =length( find(Hbm(:, j)~=-1));
        if (Hbm(i,j) ==-1)
            H(cnt1:cnt1+z-1, cnt2:cnt2+z-1)= zeros(z,z); 
        end
        if (Hbm(i, j) ==0)
            H(cnt1:cnt1+z-1, cnt2:cnt2+z-1)= eye(z);                  
        end
        if (Hbm(i, j) >0)
           if ((rate ==2/3)&(ind ==0))
               H(cnt1:cnt1+z-1, cnt2:cnt2+z-1)=circshift( eye(z),[0,mod(Hbm(i,j),z)]);
          else
               H(cnt1:cnt1+z-1, cnt2:cnt2+z-1)= circshift( eye(z),[0,floor(Hbm(i,j)*z/z0)]);
          end
        end            
        cnt2=cnt2+z; 
     end
     cnt1=cnt1+z;
end

P =eye(z);
if ((rate ==3/4) & (ind ==1))
    P=inv(circshift( eye(z),[0,floor(80*z/z0)]));
end
