if stressstate==2
    gamma=deg2rad(gammadegrees);
end

if initialcracktype==1
    %an inclined straight crack
    disp('Straight Crack')
        crackangle=deg2rad(crackangledeg);
        %a=-1;
        %b=1;
        L=b-a;
        DeltaS=L/(2*J);

elseif initialcracktype==2
    disp('Arc Crack')
    %an arc shaped crack
    %following the wikipedia definition of a circle segment
        Beta=deg2rad(Betadeg);
        angleincrement=Beta/J;
        h=R*(1-cos(angleincrement/2));
        d=R-h
        DeltaS=2*R*sin(angleincrement/2); %chord length
        centreangleoffirstseg=(angleincrement/2)-Beta;
        centreangleoflastseg=Beta-(angleincrement/2);
        centreangles=wrapToPi(centreangleoffirstseg:angleincrement:centreangleoflastseg);
        nsegs=length(centreangles);

        [arcxloc,arcyloc]=pol2cart(centreangles,d);
        arcyloc=arcyloc;
        arcsegangle=wrapToPi(centreangles+(pi/2));

        a=-(J*DeltaS);
        b=J*DeltaS;
        L=b-a
end

%return




%crack contains j, theta(j), xj, yj and the centre of each segment in terms
%of a-b, and then the load that it reached that length at
    crack=zeros(5,2*J);
    crack(1,:)=1:(2*J);
    crack(5,:)=(a+DeltaS/2):DeltaS:(b-DeltaS/2);
    %crack(5,:)=linspace(-1+(1/(2*J)),1-(1/(2*J)),2*J);
    if initialcracktype==1
        %an inclined straight crack
        crack(2,:)=ones(1,2*J)*crackangle;
        crack(3,:)=crack(5,:).*cos(crackangle); 
        crack(4,:)=crack(5,:).*sin(crackangle);
        crack(6,:)=load;
    elseif initialcracktype==2
        %an arc shaped crack
        crack(2,:)=arcsegangle;
        crack(3,:)=arcxloc; 
        crack(4,:)=arcyloc;
    end

    %I haven't worked out what this thing was
    %crack(5,:)=linspace(-1+(1/(2*J)),1-(1/(2*J)),2*J);
