function [M,X,Y]=fidxy(name,RCx,RCy)
% name without .txt
% RCx row [r 0] 'or' col X [0 c] // c 
% RCy row [r 0] 'or' col Y [0 c] // c 

M=fidder(name);

lx=length(RCx);
ly=length(RCy);

if lx(1)==1||RCx(1)==0
    X=M(:,RCx);
    X=X';
elseif RCx(2)==0
    X=M(RCx,:);
else
    error('change def RCx');
end

if ly(1)==1||RCy(1)==0
    Y=M(:,RCy);
    Y=Y';
elseif RCy(2)==0
    Y=M(RCy,:);
else
    error('change def RCy');
end

M=[X;Y];
    