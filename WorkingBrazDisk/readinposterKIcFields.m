function [KIcField] = readinposterKIcFields(profile,minKIc,maxKIc)
%reads in a KIc field from the various permutations in generated from 
%   error=0 if everything is fine
%   error=1 if line requested is after the end of the file
%   error=2 if file doesn't exist

newmax=maxKIc;%change this if we want a bit above or a bit below
newmin=minKIc;
%-------------

filename='poster_KIc_functions.mat';
load(filename)
        KIcField=((allcombinations(profile,:)).*(newmax-newmin))+newmin;
clearvars allcombinations
end

