function U = CNNorman_2(mu,N)

% Crank-Nicolson Norman boundary:U(1,n)=U(3,n); U(J+1,n)=U(J-1,n)
% n=1,2,...,J U(1,n)and U(J+1,n) have only theoretical meaning 
% finite-difference scheme.
% mu: The product dt/(dx)^2.
% N: Number of time-steps

J = 11;
U=zeros(N,J+2);
x=0:0.1:1;
b=initial(x);
b=[b(2),b,b(J-1)];
U(1,:)=b;
A = zeros(J+2);
B = zeros(J+2);
A(1,1)=1;
A(1,3)=-1;
A(J+2,J)=1;
A(J+2,J+2)=-1;

for i = 2:(J+1)
  A(i,i) = 1+mu;
  if (i > 2 && i < J+1)
    A(i,i+1)=-mu./2;
    A(i,i-1)=-mu./2;
  elseif (i==1) 
    A(i,i+1)=-mu./2;
  elseif (i==J+1) 
    A(i,i-1)=-mu./2;
  end
end

for i = 2:J
  B(i,i) = 1-mu;
  if (i > 2 && i < J+1)
    B(i,i+1)=mu./2;
    B(i,i-1)=mu./2;
  elseif (i==1) 
    B(i,i+1)=mu./2;
  elseif (i==J+1) 
    B(i,i-1)=mu./2;
  end
end

for i=1:(N-1)
  U(i+1,:)=A\(B*U(i,:)');
end

function y=initial(x)
    y=1-x.^2;
end

end