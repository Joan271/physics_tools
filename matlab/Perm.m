% Perm.m
% Calculate nPr which is n!/(n-r)!
% Avoid overflow of evaluating n! when n>170 on a 64-bit computer system

function v = Perm(n,r)
if nargin<2
    disp('Usage:');
    disp('  Perm(n,r)');
    error('Insufficient arguments.');
end

R = r;
NR = n-r;
N = n;
n = (N:-1:1);
x = (NR:-1:1);
y = ones(1,R);
d = [x y];
v = 1;
for i =1:length(n)
    v = v*(n(i)/d(i));
end

end