%lax Wendoff scheme of conservation law
%input
deltaX=0.02;t=0.3;
%exact solution
y=@(x,t)x-t./(1+x.^2);
%function
deltaT=deltaX;
mu=deltaT./deltaX;
%a(x,t)
a=@(x,t)(1+x^2)/(1+2*x*t+2*x^2+x^4);
%region
N=round(t./deltaT);
M=round(1./deltaX)+1;
U=zeros(N,M);
F=zeros(N,M);
%initial condition
g=@(x)exp(-10*(4*x-1)^2);
for i=1:M
    U(1,i)=g(i*deltaX);
end
for j=2:N
    for k=1:M
        F(j-1,k)=0.5*U(j-1,k)^2;
    end
    for i=2:(M-1)        
        A1=0.5*(U(j-1,i)+U(j-1,i+1));
        A2=0.5*(U(j-1,i)+U(j-1,i-1));
        U(j,i)=U(j-1,i)-0.5*mu*((1-A1*mu)*(F(j-1,i+1)-F(j-1,i))+(1+A2*mu)*(F(j-1,i)-F(j-1,i-1)));
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