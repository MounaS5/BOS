function [n] = rCenter(y)
       
    signum_b = sign(y(197:290)); %175:290 150:300
    a = find(~signum_b); 
    j = find(signum_b==-1);
     
    if ~isempty(a)
        n = 196+a; 
    elseif ~isempty(j)
        n = max(j)+196; % min or max   
    end
    
end
% In case you have to test an individual row
% k = sign(t(2:end-30));
% h = find(sign(t(1:end-30))==-1)
% a = find(~sign(t)); 
% n = max(h); 
% signum_b = sign(t(1:end-30));



% Possible Solution
% j=ux_1(138,:)
% % In case you have to test an individual row
% cut_ux_1=(ux_1(1,101:200))
% k = sign(cut_ux_1);
% h = find(sign(k==-1))
% a = find(~sign(t)); 
% n = max(h); 
% signum_b = sign(t(1:end-30));