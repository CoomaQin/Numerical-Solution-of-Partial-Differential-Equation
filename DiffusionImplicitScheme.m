function U = DiffusionImplicitScheme(deltaX,deltaT,J,N)
% diffusion equation ÒþÊ½¸ñÊ½

mu=deltaT./deltaX.^2;
U=zeros(N,J);
n=round(0.5.*J);

%initial value 
for j=1:J
    if (j<=n)
        U(1,j)=2.*(j-1).*deltaX;
    else
        U(1,j)=2-2.*(j-1).*deltaX;
    end
end

%boundary value
U(1:N,1)=0;
U(1:N,J)=0;

%solve triangle matrix
A=zeros(J,J);
for i=1:J
    A(i,i)=1+2.*mu;
end
for i=1:J-1
    A(i,i+1)=-mu;
    A(i+1,i)=-mu;
end
for i=2:N
    %U(:,i)=Chase(A,U(:,i-1));
    U(i,:)=U((i-1),:)/A;
end


