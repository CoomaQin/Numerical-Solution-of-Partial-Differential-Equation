U1=CNNorman_1(0.5,200);
U2=CNNorman_2(0.5,200);
U3=CNNorman_3(0.5,200);
U_exact=zeros(200,11);
for i=1:200
    for j=1:11
        U_exact(i,j)=2/3;
    end
end
for k=1:200
    a=((1:11)-1)*0.1;
    for n=1:50
    U_exact(k,:)=U_exact(k,:)+(4.*(-1)^(n+1).*cos(n.*pi.*a).*exp(-n^2*(pi)^2.*0.005.*(k-1)))./(n*pi)^2;
    end
end
Y1=max(abs(U_exact-U1),[],2);
Y2=max(abs(U_exact-U2(1:200,2:12)),[],2);
Y3=max(abs(U_exact-U3),[],2);

tt=0.005:0.005:1;
%plot(tt,log10(Y1),tt,log10(Y2),tt,log10(Y3));

plot(tt,log10(Y3));

