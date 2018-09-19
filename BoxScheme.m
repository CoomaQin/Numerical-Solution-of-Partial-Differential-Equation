%box scheme
%input
deltaX=0.02;t=1;
%retangular wave initial condition
%exact solution
y=@(x,t)x-t./(1+x.^2);
%function
deltaT=deltaX;
a=@(x,t)(1+x^2)/(1+2*x*t+2*x^2+x^4);
%x
N=round(t./deltaT);
%t
M=round(1./deltaX)+1;
U=zeros(N,M);
for i=1:M
    if (i/M>=0.2)&&(i/M<=0.4)
        U(1,i)=1;
    end
end
for j=2:N
    for i=2:(M-1)
        U(j,i)=U(j-1,i-1)+(1-a(deltaX*(i+0.5),deltaT*(j+0.5)))./(1+a(deltaX*(i+0.5),deltaT*(j+0.5))).*(U(j-1,i)-U(j,i-1));        
    end
end
xx=0:deltaX:1;
plot(xx,U(N,:))
hold on;
yy=y(xx,N*deltaT);
U_exact=zeros(1,M);
for k=1:M
    if (yy(k)>=0.2)&&(yy(k)<=0.4)
        U_exact(k)=1;
    end
end
plot(xx,U_exact,'--')
grid on;

%Guassian initial condition
%exact solution
y=@(x,t)x-t./(1+x.^2);
%function
deltaT=deltaX;
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
    for i=2:(M-1)        
    U(j,i)=U(j-1,i-1)+(1-a(deltaX*(i+0.5),deltaT*(j+0.5)))./(1+a(deltaX*(i+0.5),deltaT*(j+0.5))).*(U(j-1,i)-U(j,i-1));       
    end
end
xx=0:deltaX:1;
figure;
plot(xx,U(N,:))
grid on;