function mat = create_abel_mat(dr, N)
% refer to the paper of dasch, 1991
j = 0:N-1;
i = 0:N-1;
[J,I] = meshgrid(j,i);
% establish the matrix of I0_ij
I0 = triu(1/(2*pi)*log((((2*J+1).^2-4*I.^2).^0.5+2*J+1)./(((2*J-1).^2-4*I.^2).^.5+2*J-1)),1);
I0 = I0 + 1/(2*pi)*log((((2*J+1).^2-4*I.^2).^0.5+2*J+1)./(2*J)).*eye(size(J));
I0(1,1) = 0; I0(isnan(I0)) = 0;
% equation of I1 seems to be different. Plus is negative now.
I1 = triu(  1/(2*pi)*(  ((2*J+1).^2-4*I.^2).^0.5   -    ((2*J-1).^2-4*I.^2).^0.5  )-2*J.*I0    ,1 )+...
    (1/(2*pi)*(((2*J+1).^2-4*I.^2).^0.5)-2*J.*I0).*eye(size(J));

I0_p1 = circshift(I0,[0,-1]);
I0_p1(:,end) = 0;
I1_p1 = circshift(I1,[0,-1]);
I1_p1(:,end) = 0;
I0_m1 = circshift(I0,[0,1]);
I0_m1(:,1) = 0;
I1_m1 = circshift(I1,[0,1]);
I1_m1(:,1) = 0;

below = tril(ones(size(I0)),-1)-tril(ones(size(I0)),-2);
above = triu(ones(size(I0)),1);

mat = (I0_p1-I1_p1).*below +...
    (I0_p1-I1_p1+2*I1).*eye(size(J)) +...
    (I0_p1-I1_p1+2*I1-I0_m1-I1_m1).*above;
% be careful here, i = 0, j = 0 is I = 1, J =1 here in fact.
mat(1,2) = (I0_p1(1,2)-I1_p1(1,2)+2*I1(1,2)-2*I1_m1(1,2));

mat = 1/dr*real(mat);
end