%upwind method
%input
deltaX=0.02;t=1;
%exact solution
y=@(x,t)x-t./(1+x.^2);
%function
deltaT=deltaX;
mu=deltaT./deltaX;
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
        %a for U(j,i) or for U(j-1,i)?
        if a(i.*deltaX,(j-1).*deltaT)<0
            U(j,i)=U(j-1,i)-a(i.*deltaX,(j-1).*deltaT).*mu.*(U(j-1,i+1)-U(j-1,i));
        else
            U(j,i)=U(j-1,i)-a(i.*deltaX,(j-1).*deltaT).*mu.*(U(j-1,i)-U(j-1,i-1));
        end
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