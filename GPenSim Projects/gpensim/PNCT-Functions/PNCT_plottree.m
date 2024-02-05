function [] = PNCT_plottree(T)
% PLOTTREE albero di raggiungib./copertura
%   Sintassi: PLOTTREE(T)
%
%   Traccia il grafico completo di un albero di raggiungibilità/copertura dato
%   un albero T di una Rete di Petri ottenuto con il comando T=TREE(Pre,Post,M0).
%   Differisce dall'analoga PLOTTREE1 in quanto non utilizza i cappi.
%
%   NOTA: Per alberi con un elevato numero di nodi alla stessa profondità,
%         le marcature possono debordare dai nodi. In tal caso, è sufficiente 
%         premere sul tasto sinistro del mouse per ingrandire l'area della 
%         figura sulla quale sta il puntatore e leggere agevolmente la marcatura;
%         il tasto destro consente di tornare alla rappresentazione normale
%         (è attiva la funzione ZOOM). In alcuni casi, una buona soluzione può
%         essere quella di ingrandire la finestra della figura.
%
%   Basato sul codice della funzione TREEPLOT (Copyright (c) 1984-97
%   by The MathWorks, Inc. $Revision: 5.7 $  $Date: 1997/04/08 06:40:28 $ ).
%
%   ATTENZIONE: questa funzione richiama come subroutines le funzioni ADDBOX,
%               TREELAY, DEPTH, DEC2STR. Se queste vengono 
%               modificate oppure se non sono presenti nella stessa cartella in 
%               cui è PLOTTREE, il programma non funzionerà.
%               
%   Vedi anche TREELAY, TREE, DEPTH, ADDBOX, PLOTTREE1.
%
%   Autore: Diego Mura, 2003, Università degli Studi di Cagliari
%           indirizzo e-mail: diegolas@inwind.it

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Gentle touch of GPenSIM here   :-)

global PN
Ps = PN.No_of_places;

%%%%%% GPenSIM ends %%%%%%%%%%%%%%%% 

clf;

[m,n]=size(T);
nature=T(1:m-1,T(m,1)+2)'; %estrapola da T la colonna m+2 meno l'ultimo termine
p=T(1:m-1,T(m,1)+1)';      %estrapola da T il vettore dei puntatori ai genitori

d = PNCT_depth(p); %calcola la profondità dei vari nodi

[x,y,h] = PNCT_treelay(p,d); %calcola le coordinate dei nodi dell'albero

f = find(p~=0);  % indici dei nodi non radice
pp = p(f);       % indici dei genitori dei nodi non radice
X = [x(f); x(pp); repmat(NaN,size(f))];
Y = [y(f); y(pp); repmat(NaN,size(f))];
X = X(:);   % mette tutto in colonna
Y = Y(:);   %    "     "   "    " 


l = length(p);
plot (X, Y, 'r-');     %tracciamento degli archi

xlabel(['Height = ' int2str(h)]);
axis([0 1 0 1]);

% calcola il massimo numero di nodi in un livello dell'albero

numnodes=0; 
for k=1:max(d)
   dummy=find(d==k);
   v=length(dummy);
   numnodes=max(numnodes,v);
end

%aggiunge al grafico i rettangoli colorati

if numnodes==0   % evita la divisione per 0 che si verificherebbe
   numnodes=1;   % se l'albero contenesse solo il nodo radice (max(d)==0!!)
end

maxlargh=min(15*0.012*T(m,1),2/(2.8*numnodes));% 0.012 è la larghezza stimata di un carattere
largh=maxlargh*ones(1,length(p)); % larghezze dei rettangoli
maxalt=min(0.1,0.4/(h+1));
alt=maxalt*ones(1,length(p));          % altezze dei rettangoli
[Xb,Yb,color]=PNCT_addbox(x,y,largh,alt,nature);
patch(Xb,Yb,color);

% definizione del tipo e della dimensione dei caratteri delle etichette

if numnodes<=7
   s=9; 
   carattere='arial';
else
   s=7;
   carattere='verdana';
end

if numnodes<10
   parametro=1;
else
   parametro=0.5;
end


% inserisce le marcature nei rettangoli

for i=1:length(p) 
   marcatura = T(i,1:T(m,1));
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   % Gentle touch of GPenSIM here   :-)
   % to convert token markings into a string for display
   % OLD code:    % etichetta=dec2str(marcatura);
   etichetta = markings_string(marcatura);
   %%%% GPenSIM ends %%%%%%%%%%%%%%%%%%% 
   
   etichetta=strrep(etichetta,'Inf','w'); % sostituisce tutti gli 'Inf' con 'w'
   %text(x(i)-length(etichetta)*0.0075*parametro,y(i),etichetta,'fontsize',s,'fontname',carattere);
   text(x(i)-length(etichetta)*0.004*parametro, ...
       y(i), etichetta, 'fontsize',s, 'fontname',carattere);
end

% mette le transizioni leggermente a sinistra rispetto al punto medio dell'arco

for ii=1:length(p)
   jj=T(m,1)+4; % puntatore alla colonna dei nodi raggiunti dalla transizione in esame
   tt=T(m,1)+3; % puntatore alla colonna delle transizioni in esame
   while (tt<n)&(T(ii,tt)~=0)
      if abs(x(ii)-x(T(ii,jj)))<0.03
         xt=(x(ii)+x(T(ii,jj)))/2-parametro*0.025;
      else
         xt=(x(ii)+x(T(ii,jj)))/2-parametro*0.04;
      end 
      yt=(y(ii)+y(T(ii,jj)))/2;
      tran=T(ii,tt);	
      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
      % Gentle touch of GPenSIM here   :-)
      % OLD: transizione = strcat('t',transizione);
      transizione = PN.global_transitions(tran).name;
      %%% GPenSIM ends %%%%%%%%%%%%%%%%%%%
      text(xt,yt,transizione);
      tt=tt+2;
      jj=jj+2;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gentle touch of GPenSIM here   :-)
% OLD: title('Coverability / Reachability Tree'); 
Place_names = '';
for i = 1: Ps
    Place_names = [Place_names,' ',PN.global_places(i).name, ','];
end;
Place_names = Place_names(1:end-1); % remove trailing ','
Place_names = ['Places: ', Place_names]; 
title(Place_names);
%%% GPenSIM ends %%%%%%%%%%%%%%%%%%%

%creazione della legenda

xlegenda=[.85 .745 .745 .745];
ylegenda=[.925 .965 .925 .885];
colorlegenda=[-3 -2 -1 0];
xdim=[0.28 0.05 0.05 0.05];
ydim=[0.13 0.03 0.03 0.03];
[Xleg,Yleg,colorleg]=PNCT_addbox(xlegenda,ylegenda,xdim,ydim,colorlegenda);
patch(Xleg,Yleg,colorleg);

text(0.79,0.965,'Normal State');
text(0.79,0.925,'Terminal State');
text(0.79,0.885,'Duplicate State');

%toglie i valori di scala dagli assi

set(gca,'XTicklabel',[''],'YTicklabel',[''],'XTick',[],'YTick',[]);

zoom on; % attiva la funzione ZOOM
return


% function D = PNCT_depth(parent)
function D = PNCT_depth(parent)
%DEPHT profondità dei nodi di un albero
%   Sintassi: D=DEPTH(PARENT)
%
%   Dato il vettore dei nodi genitori PARENT rende il vettore D delle
%   profondità dei nodi dell'albero, a partire della radice,
%   che ha profondità 0.
%   Il vettore PARENT ha come i-esimo elemento l'indice del nodo
%   genitore del nodo di indice "i".
%   I nodi sono intesi numerati progressivamente secondo la loro
%   posizione nell'albero, a partire dalla radice (posta in alto),
%   da sinistra a destra e dall'alto in basso.
%
%   Autore: Diego Mura, 2003, Università degli Studi di Cagliari
%           indirizzo e-mail: diegolas@inwind.it


n = length(parent);

% aggiunge un nodo radice fittizio #n+1, e identifica le foglie.

parent = rem (parent+n, n+1) + 1;  % cambia tutti gli 0 in 1
isaleaf = ones(1,n+1);
isaleaf(parent) = zeros(n,1);      % mette a zero i nodi genitori

D=zeros(1,n); %vettore delle profondità, inizializzato a 0

% scandisce  l'albero a partire dalle foglie tramite due puntatori ai nodi,
% aliga1 e aliga2 (aggiorna le profondità dei nodi).
																
for i=1:n
   if isaleaf(i)
      aliga1=parent(i);
      while aliga1~=n+1
         aliga2=i;
         while aliga2~=aliga1
            D(aliga2)=D(aliga2)+D(aliga1)+1;
            aliga2=parent(aliga2);
         end
         if D(aliga1)~=0
            break
         end
         aliga1=parent(aliga1);
      end
   end
end
return

% function [x,y,h] = PNCT_treelay(parent,depth) 
function [x,y,h] = PNCT_treelay(parent,depth)
%TREELAY calcola le coordinate in cui rappresentare i nodi di un albero
%   Sintassi: [x,y,h]=treelay(PARENT,DEPTH).
%
%   Dato il vettore dei nodi genitori PARENT e quello della profondità 
%   dei nodi dell'albero DEPTH, rende i vettori x e y delle
%   coordinate in cui disegnare i nodi stessi per ottenere una
%   rappresentazione grafica leggibile.
%   Rende inoltre l'altezza dell'albero h.
%   Differisce dall'analoga funzione TREELAYOUT in quanto la
%   rappresentazione è fatta per livelli, ovverossia vengono qui posti
%   alla stessa altezza i nodi con la stessa profondità.
%
%   Vedi anche TREELAYOUT, DEPTH.
%
%   Autore: Diego Mura, 2003, Università degli Studi di Cagliari
%           indirizzo e-mail: diegolas@inwind.it


for lvl=0:max(depth)       % lvl=livello di profondità in esame
   dummy=find(depth==lvl); % vettore dei nodi al livello in esame
   numnodes=length(dummy); % numero di nodi al livello in esame
   k=0;
   for i=1:numnodes
      x(dummy(i))=(2*k+1)/(2*numnodes); % equispazia i nodi di un livello
      k=k+1;
   end
end

h=max(depth);
y=(h+0.5-depth)/(h+1);
return


% function [Xb,Yb,color] = PNCT_addbox(x,y,w,h,nature)
function [Xb,Yb,color] = PNCT_addbox(x,y,w,h,nature)
%ADDBOX calcola le coordinate di una serie di rettangoli colorati
%   Sintassi: [Xb,Yb,COLOR]=ADDBOX(X,Y,W,H,NATURE)
%
%   Dati i vettori X e Y delle coordinate alle quali centrare i rettangoli,
%   rende le matrici Xb e Yb delle coordinate dei vertici.
%   Le dimensioni dei rettangoli sono definite dal vettore delle
%   larghezze W e da quello delle altezze H.
%   Il vettore di interi NATURE determina il vettore COLOR dei colori con 
%   cui riempire i rettangoli, secondo lo schema:
%
%         NATURE(i)==-1.....giallo
%         NATURE(i)==-2.....verde
%         NATURE(i)==-3.....bianco
%         altrimenti........celeste
%
%   NOTA(1): Nel caso particolare in cui si abbiano solo tre rettangoli
%            da posizionare, il vettore COLOR verrebbe considerato dalla
%            funzione PATCH come una tripletta RGB, rendendo inutilizzabile
%            questa funzione. Si è adottata la soluzione di aggiungere un 
%            ulteriore rettangolo di dimensione nulla e colore bianco
%            alle coordinate (0,0).
%
%   NOTA(2): Questa funzione è stata creata per essere utilizzata con la
%            funzione PATCH.
%            La scelta dei colori è stata fatta in base ai significati
%            attribuiti loro nella funzione PLOTTREE.
%
%   NOTA(3): Quando ADDBOX viene eseguito, per la figura viene impostata
%            la mappa di colori predefinita "colorcube". Per conoscere le
%            mappe predefinite, vedere l'help di GRAPH3D.
%
%   Vedi anche PATCH, PLOTTREE.
%
%   Autore: Diego Mura, 2003, Università degli Studi di Cagliari
%           indirizzo e-mail: diegolas@inwind.it

Xb=zeros(4,length(x));    % matrici delle coordinate dei vertici dei rettangoli
Yb=zeros(4,length(x));    %

% calcolo dei vertici dei rettangoli

for j=1:length(x)
   Xb(1,j)=x(j)-(w(j)/2);
   Xb(2,j)=x(j)-(w(j)/2);
   Xb(3,j)=x(j)+(w(j)/2);
   Xb(4,j)=x(j)+(w(j)/2);
   Yb(1,j)=y(j)-(h(j)/2);
   Yb(2,j)=y(j)+(h(j)/2);
   Yb(3,j)=y(j)+(h(j)/2);
   Yb(4,j)=y(j)-(h(j)/2);
end

colormap(colorcube);      % definizione della mappa di colori,
brighten(0.5);            % schiarimento e 
caxis([1 10]);            % definizione del suo intervallo di valori

% assegnamento dei colori ai nodi

color=zeros(1,length(x)); %vettore dei colori dei nodi
for k=1:length(x)         %
   switch nature(k)       %
   case (-1)              %
      color(k)=7.0;       % nodo di blocco: giallo
   case (-2)              %
      color(k)=9.9; %2.6;       % nodo normale: verde
   case(-3)               %
      color(k)=9.9;       % sfondo della legenda
   otherwise              %
      color(k)=2.2;       % nodo duplicato: celeste
   end                    %
end                       %

% gestione del caso di tre soli rettangoli da rappresentare

if length(x)==3
   xagg=[0 0 0 0]';
   yagg=[0 0 0 0]';
   Xb=cat(2,xagg,Xb);
   Yb=cat(2,yagg,Yb);
   color=[9.9 color];
end
return