function U = CNNorman_3(mu,N)

% Crank-Nicolson Norman boundary:U(0,n)=U(1,n);U(J-1,n)=U(J,n) n=2,3,...,J
% finite-difference scheme.
% mu: The product dt/(dx)^2.
% N: Number of time-steps

J = 11;
U=zeros(N,J);
x=0:0.1:1;
b=initial(x);
U(1,:)=b;
A = zeros(J);
B = zeros(J);
A(1,1)=1;
A(1,2)=-1;
A(J,J-1)=1;
A(J,J)=-1;

for i = 2:(J-1)
  A(i,i) = 1+mu;
  if (i > 2 && i < (J-1))
    A(i,i+1)=-mu./2;
    A(i,i-1)=-mu./2;
  elseif (i==1) 
    A(i,i+1)=-mu./2;
  elseif (i==(J-1)) 
    A(i,i-1)=-mu./2;
  end
end

for i = 2:(J-1)
  B(i,i) = 1-mu;
  if (i > 2 && i < (J-1))
    B(i,i+1)=mu./2;
    B(i,i-1)=mu./2;
  elseif (i==1) 
    B(i,i+1)=mu./2;
  elseif (i==(J-1)) 
    B(i,i-1)=mu./2;
  end
end

for i=1:(N-1)
  U(i+1,:)=A\(B*U(i,:)');
end

function s=initial(x)
    n=length(x);
    s=zeros(n,1);
    s(1)=1;
    s(n)=0;
    for j=2:n-1
        s(j)=x(j+1)-x(j)+1./3.*(x(j+1).^3-x(j).^3);
    end
end

end