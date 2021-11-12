function f= abel_three(F,D)

if ~iscolumn(F)
    F = F';
end

% dr = L/length(F);
% j = 0:length(F)-1;
% i = 0:length(F)-1;
% [J,I] = meshgrid(j,i);
% 
% I0 = triu(1/(2*pi)*log((((2*J+1).^2-4*I.^2).^0.5+2*J+1)./(((2*J-1).^2-4*I.^2).^.5+2*J-1)),1)+...
%     1/(2*pi)*log((((2*J+1).^2-4*I.^2).^0.5+2*J+1)./(2*J)).*eye(size(J));
% I0(1,1) = 0; I0(isnan(I0)) = 0;
% 
% I1 = triu(1/(2*pi)*(((2*J+1).^2-4*I.^2).^0.5-((2*J-1).^2-4*I.^2).^0.5)-2*J.*I0 ,1)+...
%     (1/(2*pi)*(((2*J+1).^2-4*I.^2).^0.5)-2*J.*I0).*eye(size(J));
% I1(isnan(I1)) = 0;
% 
% I0_p1 = circshift(I0,[0,-1]);
% I1_p1 = circshift(I1,[0,-1]);
% I0_m1 = circshift(I0,[0,1]);
% I1_m1 = circshift(I1,[0,1]);
% 
% below = tril(ones(size(I0)),-1)-tril(ones(size(I0)),-2);
% above = triu(ones(size(I0)),1);
% 
% D = (I0_p1-I1_p1).*below +...
%     (I0_p1-I1_p1+2*I1).*eye(size(J)) +...
%     (I0_p1-I1_p1+2*I1-I0_m1-I1_m1).*above;
% D(1,2) = (I0_p1(1,2)-I1_p1(1,2)+2*I1(1,2)-2*I1_m1(1,2));
% 
% D = 1/dr*real(D);
f = D*F;