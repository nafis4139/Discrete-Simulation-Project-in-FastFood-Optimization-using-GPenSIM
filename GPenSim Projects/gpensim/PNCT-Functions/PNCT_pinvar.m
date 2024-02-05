function PI = PNCT_pinvar(C)
% PINVAR : This function determines the P-invariants of a Petri Net.
%        **************************************************************
%                           ## SYNTAX ##
%
%        PI=PINVAR(C):
%           Given a Petri Net with (m x n) incidence matrix 
%           C = Post - Pre, this function returns a non-negative 
%           integer matrix of size (m x k):
%
%                      X = [ x_1 x_2  ... x_k ]           
%
%           where for all i:   
%
%                          x_i'*C = 0
%
%           The (m x 1) vectors x_i are called P-invariants (or P-semiflows).
%           The support of x_i is the set of places : { p |  x_i(p) > 0}.
%
%           The algorithm determines all and only P-semiflows that are:
%               - canonical: the g.c.d. of all non-null elements is 1;
%               - minimal: their support is not the superset of any other P-invariant.
%    
%         See also: pdec,pinc,tinvar,tdec,tinc.

[m,n]=size(C);
M=[C eye(m)]; 

for j=1:n                 
   y1=find(M(:,j)>0);     % column with numbers index >0 of matrix M
   y2=find(M(:,j)<0);     % column with numbers index <0 of matrix M
   for c1=1:length(y1)    %subindex for all number of y1
      for c2=1:length(y2) %subindex for all number of y2;
                          %the nested "for" means that for every element of y1 
                          %all elements of y2 are considered 
              
         A=M(y1(c1),j);   %shows each number of y1
         B=-M(y2(c2),j);  %shows each number of y2
         mcm= lcm(A,B);   %combining each element of y1 with all elements of y2 returns mcm
         k1=mcm/A ;       %find the multiplying  factor for the linear combinations
                          %between one element of y1 and y2 elements'       
         k2=mcm/B;        %find the multiplying  factor for the linear combinations
                          %between one element of y2 and y1 elements'       
      
         A1=M(y1(c1),:);  %row vector with n+m elements containing each element of y1 
         A2=M(y2(c2),:);  %row vector with n+m elements containing each element of y2 

         M=[M;k1*A1+k2*A2];%the instruction adds as many rows for M as the found linear combinations 
             
         Ma=k1*A1+k2*A2;   %shows the added rows step by step
      end
   end
   Y=[y1;y2];               %cancellation of the rows
   Y=sort(Y);
   for c=length(Y):-1:1
      M(Y(c),:)=[];
   end
end

P_INVminimali=[];
a=[];
if isempty(M)
   PI=[]; 
   disp(' '); disp('No P-Invariants on the net!'); disp(' '); 
else
   M;
   P_INVm=(M(:,n+1:n+m))';
   r=rank(P_INVm);
   A=size(P_INVm');
   if r == A(1) 
      % disp(' '); disp('P-Invariants: minimal, canonical,and array of generators!'); disp(' '); 
      PI=P_INVm;
      return
   elseif r<A(1)
      F=P_INVm';
      for i=A(1):-1:(A(1)-2)
         v=zeros(size(P_INVm'));
         for l=i-1:-1:1
            if F(i,:)>=F(l,:)
               v(i,:)=1;
            end
         end
         if v(i,:)==1
            F(i,:)=[];
         end
      end
      P_INVminimali=F';
      F1=F;
      A=size(F1);
      for i=A(1):-1:(A(1)-2)
         for l=i-1:-1:1
            a=gcd(F1(i,:),F1(l,:));
            if all(a)>1
               % disp(' '); disp('P-Invariants: minimal but not canonical!'); disp(' '); 
               PI=F1';
               return
            end
         end
      end
      % disp(' '); disp('P-Invariants: minimal and canonical!'); disp(' '); 
      PI=F1';
   end
end

