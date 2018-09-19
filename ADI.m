%time step
deltaT=0.001;
%x-y step
deltaX=0.01;deltaY=0.01;
%the range of x-y
N=101;
%the range of time
M=1;
U=zeros(N,N);
mu_x=deltaT./deltaX.^2;mu_y=deltaT./deltaY.^2;
for i=1:N
    for j=1:N
        U(i,j)=sin((i-1)./N.*2*pi)*sin((j-1)./50.*2*pi);
    end
end
[x,y]=meshgrid(-1:0.02:1,-1:0.02:1);
mesh(x,y,U)
A1=eye(N,N);
A2=eye(N,N);
for k=2:N-1
    A1(k,k)=1+mu_x;
    A1(k,k-1)=-mu_x./2;
    A1(k,k+1)=-mu_x./2;
    A2(k,k)=1+mu_y;
    A2(k,k-1)=-mu_y./2;
    A2(k,k+1)=-mu_y./2;    
end
for l=1:M
    U_half=zeros(N,N);
    b1=zeros(N,1);
    b2=zeros(N,1);
    for j=2:N-1
        for k=2:N-1
            b1(k)=U(k,j+1).*mu_y.*0.5+(1-mu_y).*U(k,j)+U(k,j-1).*mu_y.*0.5; 
        end
        U_half(:,j)=A1\b1;
    end
    for i=2:N-1
        for k=2:N-1
            b2(k)=U_half(i+1,k).*mu_x./2+(1-mu_x).*U_half(i,k)+U_half(i-1,k).*mu_x./2; 
        end
        U(i,:)=(A2\b2)';
    end
    U(1,:)=0;U(N,:)=0;
    figure;
    mesh(x,y,U);
    axis([-1 1 -1 1 -1 1]);
end