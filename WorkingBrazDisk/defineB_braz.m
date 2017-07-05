if stressstate==1
        %biaxial
        disp('Biaxial Stress')
    P=ones((M-1),1).*P0; % following galybin04


elseif stressstate==2
    disp('Uniaxial Stress')
        %uniaxial
    P=(P0/2)*(1-exp(2*1i*(gamma-theta_r))); %following galybin04



elseif stressstate==3
    disp('Step Pressurised')
        %pressurised, up to a point, following andreev15
    P=zeros((M-1),1);

    %P(eta(m)>=negpressurelim && eta(m)<=pospressurelim)=P0;
        for m=1:(M-1)
            if r(m)>=negpressurelim && eta(m)<=pospressurelim
                P(m)=P0;
            end
        end
elseif stressstate==4
    disp('Brazilian Disk')
        %Brazilian Disk, following Liu (2008)
    [sigmax,sigmay,tauxy]=stressfieldbraz(planestressstrain,nu,load,D/2,t,real(Tr),imag(Tr));

        %------------------------
        %New formulation off mohr circle bruv
        %-------------------------
        [sigmatheta,tau] = mohrcirclemohrproblems(sigmax,sigmay,theta_r);
        P=sigmatheta-(1i.*tau);%following thesis equation 7.16
        %-------------------------
    %return

    clearvars sigmax sigmay tauxy tau sigmatheta
end

%mode-I remote stress above shear remote stress, above two zeros for the
%single-valuedness condition
%p=(b-a)*P/2;
p=P;
B=vertcat(real(p),imag(p),0,0);% should P be multiplied through by length?
clearvars  p P