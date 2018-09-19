%lax Wendoff scheme
%input
deltaX=0.01;t=1;
%exact solution
y=@(x,t)x-t./(1+x.^2);
%function
deltaT=deltaX;
%a(x,t)
a=@(x,t)(1+x^2)/(1+2*x*t+2*x^2+x^4);
%region
%x
N=round(t./deltaT);
%t
M=round(1./deltaX)+1;
U=zeros(N,M);
%initial condition
g=@(x)exp(-10*(4*x-1)^2);
for i=1:M
    U(1,i)=g(i*deltaX);
end
for j=2:N
    for i=2:(M-1)
        v=abs(a(i*deltaX,j*deltaT)).*deltaT./deltaX;
        U(j,i)=0.5.*v.*(1+v).*U(j-1,i-1)+(1-v.^2).*U(j-1,i)-0.5.*v.*(1-v).*U(j-1,i+1);
    end
end
xx=0:deltaX:1;
plot(xx,U(N,:))
hold on;
yy=y(xx,N*deltaT);
U_exact=zeros(1,M);
for k=1:M
    U_exact(k)=g(k*deltaX);
end
plot(xx,U_exact,'--')
grid on;