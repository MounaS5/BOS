function [n] = regFunc(n)
k = 0;
for i = 1:numel(n)
   k=k+n(i) ;  
end
k = k/numel(n);
n = n - k;
end

