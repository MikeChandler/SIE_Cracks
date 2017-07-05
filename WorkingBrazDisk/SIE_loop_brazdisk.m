disp('-------------------------------')
disp('-------------------------------')
disp('-------------------------------')
cracksetupinitial


for step=1:nsteps
    stringy=strcat('step=',num2str(step));
    disp('-------------------------------')
    disp(stringy)
    clearvars stringy
    
    %set up matrices of eta, xi, s, r, U_(N-1), T_N
    defineinitialvariables
    
    %disp('defined initial variables')
    
    %find the complex locations corresponding to each Eta and Xi value, T(s)
    %and T(r)
    defineTsandTr
    
    %disp('made up Ts and Tr')
    
    %make up the variables K1 and K2. 
    definekernels
   
    %disp('made up kernels')
    
    %construct the matrix A and vector B.
    %stressstate
    defineB_braz
    
    disp('made B')
    defineA
    disp('made A')
    
    %Invert for C
    performinversion
    disp('performed inversion')
    
    %find KI and KII at each end
    findKIandKII
    
        if KIonly == 1
            return
        end


    %calculate propagation angle
    findpropangles_KIcField

    %findpropangles

    if step==1
       plot_braziliandiskcrack    
    end
    
    
    %extend the crack if the load is high enough
    %if KI_right>=KIc
    %    proporno=1;
    %else
    %    proporno=0;
    %    if KI_left>=KIc
    %        proporno=1;
    %    end
    %end
    
    
    
    if proporno==1  
           stringy=strcat('alpha_left =',num2str(alpha_left_deg),', alpha_right =',num2str(alpha_right_deg));
            disp(stringy)
            clearvars stringy


        %add the new segments onto the crack
        cracksetup
             %plot it only when it propagates
            plot_braziliandiskcrack       
        L=b-a;
        stringy=strcat('crack length =',num2str(L));
        disp(stringy)
        clearvars stringy
        disp('set up crack')
        addpath ('.\outputs')
        pwd
            save('.\outputs\tempbrazildisksim.mat','crack')
            rmpath ('.\outputs')
            disp('saved inspection file')
        %24/12/2016 - reset load to zero, so essentially we're running in displacement control    
        %load=initialload;
        %29/12/2016 - instead, just drop this a bit, so that it doesn't take forever to run, so essentially we're running in displacement control    
        load=load-(10*loadstep);
    else %if the load isn't high enough, increase the load
       load=load+loadstep;
    end
stringy=strcat('profile number =',num2str(profile));
disp(stringy)
clearvars stringy     
stringy=strcat('load =',num2str(load));
disp(stringy)
clearvars stringy    

    %now check the length, and stop this nonsense if it is twice
    %the diameter (as we're probably looping)
            if size(crack,2)>(Dratio*3)
                crack=horzcat((ones(size(crack,1),1)*99999),crack,(ones(size(crack,1),1)*99999));
                disp('crack appears to be looping')
                disp('-----')
                break
            end
    
    
    %check that the crack hasn't breached the edge of the sample
    extentcheck=((crack(3,:).^2)+(crack(4,:).^2)).^(1/2);
    extentcheck=max(extentcheck)/(D/2);
    stringy=strcat('maximum extent =',num2str(extentcheck));
    disp(stringy)
    clearvars stringy
    if extentcheck>1%
        disp('reached edge of sample')
        disp('-----')
        break
    end
end