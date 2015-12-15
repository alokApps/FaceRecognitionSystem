function [m, A, Eigenfaces] = Eigenfacetest(T)                 
m = mean(T,2); 
Train_Number = size(T,2);

A = [];  
for i = 1 : Train_Number
    temp = double(T(:,i)) - m; 
    A = [A temp];
end


L = A'*A; 
[V ,D] = eig(L); 

L_eig_vec = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1 )
        L_eig_vec = [L_eig_vec V(:,i)];
    end
end


Eigenfaces = A * L_eig_vec; 