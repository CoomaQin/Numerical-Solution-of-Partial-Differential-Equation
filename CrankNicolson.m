function[b] = CrankNicolson(b,mu,N)

% The one-dimensional heat equation, approximated using the Crank-Nicolson
% finite-difference scheme.
% b: initial value. mark b(0)=0
% mu: The product dt/(dx)^2.
% N: Number of time-steps

n = length(b)+1;
A = zeros(n-1);
B = zeros(n-1);
for i = 1:(n-1)
  A(i,i) = 1+mu;
  if (i > 1 && i < (n-1))
    A(i,i+1)=-mu./2;
    A(i,i-1)=-mu./2;
  elseif (i==1) 
    A(i,i+1)=-mu./2;
  elseif (i==(n-1)) 
    A(i,i-1)=-mu./2;
  end
end
for i = 1:(n-1)
  B(i,i) = 1-mu;
  if (i > 1 && i < (n-1))
    B(i,i+1)=mu./2;
    B(i,i-1)=mu./2;
  elseif (i==1) 
    B(i,i+1)=mu./2;
  elseif (i==(n-1)) 
    B(i,i-1)=mu./2;
  end
end

for i=1:N
  b=A\(B*b);
  b(1)=0;
  b(n-1)=0; 
  plot(b);
  pause(.2);
  drawnow();
end