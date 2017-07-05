%js and jr are vectors containing the segment number, j, in which
%locations s and r lie, respectively

m_js=1+(ceil(m_s/DeltaS))- min((min(ceil(m_s/DeltaS)))');
m_jr=1+(ceil(m_r/DeltaS))- min((min(ceil(m_r/DeltaS)))');

js=m_js(1,:);
jr=m_jr(:,1);

%initiate the sizes of vectors containing;
    %the angle associated with the segment 
        theta_s=zeros(1,N);
        theta_r=zeros(M-1,1);
    %the polar distance between locations s or r and the centre of the
    %segment in which it lies
        s_delta=zeros(1,N);
        r_delta=zeros(M-1,1);
    %the x and y distances from the segment centre to the location s or r
        sdx=zeros(1,N);
        sdy=zeros(1,N);
        rdx=zeros(M-1,1);
        rdy=zeros(M-1,1);
    %Ts and Tr, the locations of 
        Ts=zeros(1,N);
        Tr=zeros(M-1,1);

%fill in these vectors. This needs to be done in loops, because it involves
%looking up the angle and x/y locations from another matrix

for n=1:N
    theta_s(n)=crack(2,js(n)); %looks up the angle from segment j corresponding to location s
    s_delta(n)=(s(n)-crack(5,js(n))); %the distance between s and the centre location of the segment in which s lies
    %should that be scaled by the crack length or something? I don't think so
    [sdx(n),sdy(n)]=pol2cart(theta_s(n),s_delta(n));
    Ts(n)=(crack(3,js(n))+sdx(n))+(1i*(crack(4,js(n))+sdy(n)));
end

for m=1:M-1
    theta_r(m)=crack(2,jr(m)); %looks up the angle from segment j corresponding to location r
    r_delta(m)=(r(m)-crack(5,jr(m))); %the distance between r and the centre location of the segment in which r lies
    %should that be scaled by the crack length or something? I don't think so
    [rdx(m),rdy(m)]=pol2cart(theta_r(m),r_delta(m));
    Tr(m)=(crack(3,jr(m))+rdx(m))+(1i*(crack(4,jr(m))+rdy(m)));
end
%meanTs=mean(mean(Ts))
%meanTr=mean(mean(Tr))

%create matrices of each set of angles and T(s) and T(r)
[m_thetas,m_thetar]=meshgrid(theta_s,theta_r);
[m_Ts,m_Tr]=meshgrid(Ts,Tr);

clearvars s_delta r_delta rdx rdy sdx sdy