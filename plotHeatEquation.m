function s=plotHeatP(t1,t2,n)
%t1 t2 are different deltaT.
%n is the time steps
s=1;
U1=HeatPropagation(0.05,t1,21,50);
U2=HeatPropagation(0.05,t2,21,50);
X=0:0.05:1;
N=abs(n);
Y1=U1(N,:);
Y2=U2(N,:);
plot(X,Y1,'-*','markersize',5);
hold on;
plot(X,Y2,'-o','markersize',5);
grid on
end

