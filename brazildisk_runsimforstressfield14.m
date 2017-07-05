clearvars
close all
addpath ('.\WorkingBrazDisk')
addpath ('.\GeneratePosterFunctions')
%n_angles=181;
%n_KIcs=6;

filename='poster_KIc_functions.mat';
load(filename)

clearvars allcombinations 
            disp('beginning loop')
            
for profile=14


outputfile=zeros(1,5);
gammavals=[0,10,20,30,45,60,70,90];%these are the angles that TillyVilly looked at
 %-----------------------------------------------   

clearvars -except initialload gammavals outputfile profile n_profiles D filenumber linenumber n_angles n_KIcs outputfilename


    for gammaloop=1:length(gammavals)
        allinputs_braz
        gammadeg=gammavals(gammaloop);
        disp(strcat('Gamma = ',num2str(gammadeg),' degrees.'))
            %check whether this one has already been done
outputfilename=strcat('.\outputs\TV_brazildisksim_profileno',num2str(profile),'_crackangle',num2str(crackangledeg),'_gamma',num2str(gammadeg),'.mat') 
addpath ('.\outputs')
if exist(outputfilename, 'file')==2
    disp('Simulation already exists!')
    break
end
rmpath ('.\outputs')
    %-----------------------------------------------------------------------------
    %-----------------------------------------------------------------------------
    %setup parameters
        initialcracktype=1;%1=straight, 2=arc
        stressstate=4;%1=biaxial stress, 2=uniaxial stress, 3=step pressurised, 4=brazilian disk
        %b=1; %crack ends (i.e. b=1/2 length)
        %a=-b;
    

        %max length
        maxlength=300;
        nsteps=5000;
        KIonly=0;%1= only 1 step, just finds KI
    %-----------------------------------------------------------------------------
    %-----------------------------------------------------------------------------
    [KIcField] = readinposterKIcFields(profile,minKIc,maxKIc);

    plotKIcField

    SIE_loop_brazdisk
    close all

    %---------------------------------------
    %this bit makes that correction to the load that I don't quite understand
    %why it's there
    crack(6,:)=((-crack(6,:)*8714.9)+10271)*D*t;
    %---------------------------------------

    %outputfilename=strcat('.\outputs\TV_brazildisksim_profileno',num2str(profile),'_crackangle',num2str(crackangledeg),'_gamma',num2str(gammadeg),'.mat')     

            save(outputfilename,'crack')
            disp('saved output file')

    end
end
rmpath ('.\WorkingBrazDisk')