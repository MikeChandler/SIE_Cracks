%perform the inversion

%matrixcondition=rcond(A)
%clearvars matrixcondition

C=A\B;
clearvars A B

qn=C(1:N)+1i*(C((N+1):(2*N)));

clearvars C 