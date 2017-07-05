function [KIcField,levels] = readinKIcField(profile,n_angles,n_KIcs,minKIc,maxKIc)
%reads in a KIc field from the various permutations in generated from 
%   error=0 if everything is fine
%   error=1 if line requested is after the end of the file
%   error=2 if file doesn't exist

newmax=maxKIc;%change this if we want a bit above or a bit below
newmin=minKIc;
multiplier=(newmax-newmin)/(n_KIcs-1);
addition=newmin-multiplier;
%-------------
%write up an array which lists the correlation between the level on the
%option, and the actual KIc at that level
    levelcount=1:n_KIcs;
    levels=addition+(levelcount.*multiplier);
    levels=vertcat(levelcount,levels);
    levels=levels';
%-------------
filename=strcat('combinations_',num2str(n_KIcs),'KIcs_',num2str(n_angles),'angles.mat');
load(filename)
        KIcField=((allcombinations(profile,:)).*multiplier)+addition;
clearvars allcombinations
end

