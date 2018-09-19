function U = HeatPropagation(deltaX,deltaT,J,N)
%   关于初始值为帽型函数的基于有限差分方法的热方程数值解
mu=deltaT./deltaX.^2;
U=zeros(N,J);
n=round(0.5.*J);
%initial values
for j=1:J
    if (j<=n)
        U(1,j)=2.*(j-1).*deltaX;
    else
        U(1,j)=2-2.*(j-1).*deltaX;
    end
end
%boundary values
U(1:N,1)=0;
U(1:N,J)=0;

for i=2:N
    for j=2:J-1
        U(i,j)=U(i-1,j)+mu.*(U(i-1,j+1)-2.*U(i-1,j)+U(i-1,j-1));
    end
end
    
end

