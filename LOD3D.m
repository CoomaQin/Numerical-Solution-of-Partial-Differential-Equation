%time step
deltaT=0.001;
%x-y-z step
deltaX=0.01;deltaY=0.01;deltaZ=0.01;
%the range of x-y-z
N=101;
%the range of time
M=1;
U=zeros(N,N,N);
mu_x=deltaT./deltaX.^2;mu_y=deltaT./deltaY.^2;mu_z=deltaT./deltaZ.^2;
for i=1:N
    for j=1:N
        for k=1:N
            U(i,j,k)=sin((i-1)./N.*2*pi)*sin((j-1)./50.*2*pi)*sin((k-1)./50.*2*pi);
        end
    end
end
A1=eye(N,N);
A2=eye(N,N);
A3=eye(N,N);
for k=2:N-1
    A1(k,k)=1+mu_x;
    A1(k,k-1)=-mu_x./2;
    A1(k,k+1)=-mu_x./2;
    A2(k,k)=1+mu_y;
    A2(k,k-1)=-mu_y./2;
    A2(k,k+1)=-mu_y./2;
    A3(k,k)=1+mu_z;
    A3(k,k-1)=-mu_z./2;
    A3(k,k+1)=-mu_z./2;
end
for l=1:M
    U1=zeros(N,N,N);
    U2=zeros(N,N,N);
    b1=zeros(N,1);
    b2=zeros(N,1);
    b3=zeros(N,1);
    for j=2:N-1
        for k=2:N-1
            for i=2:N-1
                b1(i)=U(i-1,j,k).*mu_x.*0.5+(1-mu_x).*U(i,j,k)+U(i+1,j,k).*mu_x.*0.5; 
            end
            U1(:,j,k)=A1\b1;
        end
    end
    for i=1:N-1
        for k=2:N-1
            for j=2:N-1
                b2(j)=U1(i,j-1,k).*mu_y.*0.5+(1-mu_y).*U1(i,j,k)+U1(i,j+1,k).*mu_y.*0.5; 
            end
            U2(i,:,k)=A2\b2;
        end
    end 
    for i=1:N-1
        for j=2:N-1
            for k=2:N-1
                b3(k)=U1(i,j,k-1).*mu_z.*0.5+(1-mu_z).*U1(i,j,k)+U1(i,j,k+1).*mu_z.*0.5; 
            end
            U(i,j,:)=A3\b3;
        end
    end    
end