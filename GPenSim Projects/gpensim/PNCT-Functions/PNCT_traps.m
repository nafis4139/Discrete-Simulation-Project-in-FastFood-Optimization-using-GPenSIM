function T = PNCT_traps(Pre,Post)
% TRAPS : determines the traps of a place/transition net
%  ****************************************************************************
%                           ## SYNTAX ##
%
%        T=TRAPS(Pre,Post):
%        Given a Petri Nets with (m x n) pre and post incidence  
%        matrix Pre and Pre, returns a  matrix of 0's and 1's
%        of size (m x k)
%
%            X = [ x_1 x_2  ... x_k ]           
%
%        where for all i the support of x_i:   
%
%           S_i = { p | x_i(p) = 1 } is a trap,  
%
%        i.e., the set of output transitions S_i*  is contained 
%        in the set of input transitions *S_i.
%
%    See Also SIPHONS, PINV, TINV, PINC, PDEC
%
if size(Post)~=size(Pre)
   fprintf('\n Pre and Post must have the same size\n')
   return
end
[m,n]=size(Pre);
M=[sign(Post) sign(Pre)  eye(m)];
for j=1:n
   y1=find(M(:,j+n)-M(:,j)>0);     %row indexes i with Post(i,j)>0 and Pre(i,j)=0
   y2=find(M(:,j)>0);              %row indexes i with Pre(i,j)>0
   for c1=1:length(y1)    %subindex for all number of y1
      for c2=1:length(y2) %subindex for all number of y2;
                          %the nested "for" means that for every element of y1 
                          %all elements of y2 are considered 
                          R = sign(M(y1(c1),:)+M(y2(c2),:));  % R = boolean AND of rows

                          [mr,mc]=size(M);
                          F=0;
                          for i=1:mr,
                             if (R == M(i,:)),
                                F =1;            % set F=1 if R is already a row of M
                                break
                             end
                          end
                          if (F ==0)             % if R is not already in M, add row R
                             M = [M ; R];  % add 
                          end
                       end
   end
   y1=sort(y1);
   for c=length(y1):-1:1
      if min(M(y1(c),1:n) - M(y1(c),n+1:2*n)) < 0,  
         M(y1(c),:) = [];
      end
   end
end

if isempty(M)
   fprintf('Traps: There are no traps on the net\n');
   T = M;
else
   T = M(:,2*n+1:2*n+m);
end;
