
function TI = PNCT_tinvar(C)
% TINVAR : This function determines the T-invariants of a Petri Net.
%        *****************************************************************
%                           ## SYNTAX ##
%
%        TI=TINVAR(C):
%           Given a Petri Net with (m x n) incidence matrix 
%           C = Post - Pre, this function returns a non-negative  
%           integer matrix of size (k x n):
%
%                        Y= [ y_1 y_2  ... y_k ]           
%
%           where for all i:   
%
%                                C*y = 0
%
%           The (n x 1) vectors y_i are called T-invariants (or T-semiflows).
%           The support of y_i is the set of transitions : { t |  y_i(t) > 0}.
% 
%           The algorithm determines all and only T-semiflows that are:
%              - canonical: the g.c.d. of all non-null elements is 1;
%              - minimal: their support is not the superset of any other T-invariant.
%     
%         See also: pinvar,pdec,pinc,tdec,tinc. 
%
[m,n]=size(C');
M=[C' eye(m)]; 
for j=1:n                 
   y1=find(M(:,j)>0);    % column with numbers index >0 of matrix M
   y2=find(M(:,j)<0);    % column with numbers index <0 of matrix M
   for c1=1:length(y1)   %subindex for all number of y1
      for c2=1:length(y2)%subindex for all number of y2;
                         %the nested "for" means that for every element of y1 
                         %all elements of y2 are considered 
              
         A=M(y1(c1),j);  %shows each number of y1
         B=-M(y2(c2),j); %shows each number of y2
         mcm= lcm(A,B);  %combining each element of y1 with all elements of y2 returns mcm
         k1=mcm/A ;      %find the multiplying  factor for the linear combinations
                         %between one element of y1 and y2 elements'       
         k2=mcm/B;       %find the multiplying  factor for the linear combinations
                         %between one element of y2 and y1 elements'       
      
         A1=M(y1(c1),:); %row vector with n+m elements containing each element of y1 
         A2=M(y2(c2),:); %row vector with n+m elements containing each element of y2 

         M=[M;k1*A1+k2*A2];%the instruction adds as many rows for M as the found linear combinations 
             
         Ma=k1*A1+k2*A2; %shows the added rows step by step
      end
   end
   Y=[y1;y2];            %cancellation of the rows
   Y=sort(Y);
   for c=length(Y):-1:1
      M(Y(c),:)=[];
   end
end
T_INVminimali=[];
a=[];
if isempty(M)
   TI=[];
   fprintf('There aren''t T-Invariants on the net!\n');
else
   M;
   T_INVm=(M(:,n+1:n+m))';
   r=rank(T_INVm);
   A=size(T_INVm');
   if r == A(1)
      fprintf('T-Invariants are minimal,canonical,and they are an array of generators!\n');
      TI=T_INVm;
   elseif r<A(1)
      F=T_INVm';
      for i=A(1):-1:(A(1)-2)
         v=zeros(size(T_INVm'));
         for l=i-1:-1:1
            if F(i,:)>=F(l,:)
               v(i,:)=1;
            end
         end
         if v(i,:)==1
            F(i,:)=[];
         end
      end
      T_INVminimali=F';
      F1=F;
      A=size(F1);
      for i=A(1):-1:(A(1)-2)
         for l=i-1:-1:1
            a=gcd(F1(i,:),F1(l,:));
            if all(a)>1
               fprintf('T-Invariants are minimal,but not canonical!\n')
               TI=F1';
               return
            end
         end
      end
      fprintf('T-Invariants are minimal and canonical!\n')
      TI=F1';
   end
end



 




   

