function [G,T] = PNCT_graph(Pre,Post,M0)
% GRAPH : This function builds Reachability/Coverability Graph of a Petri Net system.
%         ***************************************************************************
%                                     ## SYNTAX ##
%
%        GRAPH(Pre,Post,M0): 
%          This function gives a matrix visualization of a Petri Net's
%          Reachability/Coverability Graph being introduced the Pre & Post
%          matrices and the initial marking M0.                     
%          This is a step-by-step mode for didactical purpose.
%
%        G=GRAPH(Pre,Post,M0):
%          This function returns a matrix G of integers that represents
%          Reachability/Coverability Graph being introduced the Pre & Post 
%          matrices and the initial marking M0.
%
%        [G,T]=GRAPH(Pre,Post,M0): 
%          This function returns two integer matrices: 
%             G for Reachability/Coverability Graph;  
%             T for Reachability/Coverability Tree.                         
%
%        See also TREE

Mx=M0';% trasforma la marcatura iniziale da vettore colonna a vettore riga

%---------------------------Save the Graph in G and the Tree in T------------------------------
%Both the Tree and the Graph are shown
%fprintf('\n***Algorithm for Graph(G) and Tree(T)***\n\n')
[m,n]=size(Post);

T=[Mx 0 0 0];
N=[Mx 0 0 ];
rN=1;
rN1=1;
r=1;
g=1;
while r<=g
 if T(r,m+2)==0 
    k=1;
    for j=1:n 
       if T(r,1:m)>=Pre(:,j)' 
          g=g+1;
          T(r,m+1+2*k+1)=j; 
          T(r,m+1+2*k+2)=g; 
          M=T(r,1:m)-Pre(:,j)'+Post(:,j)';
          a=r;
          while a~=0  
             if M >=T(a,1:m), 
                for i=1:m;
                   if M(i)>T(a,i)
                      M(i)=inf;
                   end
                end
                a=1;
             end
             a=T(a,m+1);
          end
          T(g,1:m)=M; 
          T(g,m+1)=r;  
          N(rN,m+1)=rN1;
          N(rN,m+2)=rN;
          for w=1:rN    
             if N(w,1:m)==T(g,1:m)
                T(g,m+2)=w;
                T(g,m+3)=N(w,m+1);
                break
             end
          end
          k=k+1;
          if T(g,m+2)==0 
             M1=[M 0 0];
             N=[N;M1];
             rN=rN+1;
             rN1=g;
             N(rN,m+1)=rN1;
             N(rN,m+2)=rN;
          end
       end
    end
    if k==1,
       T(r,m+2)=-1;
       T(r,m+3)=-1;
    else
       T(r,m+2)=-2;
       T(r,m+3)=-2;
    end
 end
 r=r+1;
end
T1=T;
aux=1:g;
%***************indexing T******
aux1=1:g;
T1=[T1,aux1'];
%*******************************
v=1;     
for r=1:g 
 if T1(r,m+2)<0 
    aux(r)=v;   
    v=v+1;
 else aux(r)=T1(r,m+2);
    aux(r)=T1(r,m+2);
 end    
end 
[g,d]=size(T1); 
for r=1:g       
 for b=m+5:2:d
    q=T1(r,b);
    if q~=0
       T1(r,b)=aux(q);
    end
 end
end
s=0;
G=[];
for r=1:g
 if T1(r,m+2)<0
    s=s+1;
    G(s,:)=T1(r,:);        
 end
end
%***************Fathers correction!!!************
[i1,i2]=size(G); 
G(:,end)=[];
%******************END***************************
[i1,i2]=size(G); 
K=zeros(1,i2);
G=[G;K];
T=[T;K];
T(:,m+2)=[];
G(:,m+2)=[];
[i3,i2]=size(G);
[i4,cT]=size(T);
T(i4,1)=m;
T(i4,2)=n;
T(i4,3)=0;
