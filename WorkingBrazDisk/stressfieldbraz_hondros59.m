function [sigx,sigy] = Li08BDstressfield(planestressstrain,nu,P,R,x,y,t,alpha)
%calculates the stress field at x,y in a brazilian disk or radius R
%   alpha is the arc angle that it is loaded over in degrees
%THIS IS ONLY DEFINED ALONG THE LOAD LINE

%lastbit=atan((1+(r/R)^2)*tan(alpha)/(1-(r/R)^2));

%Equations from Equation 2 of Li & Wong, (2013)

if planestressstrain==0
    kappa=(3-nu)/(1+nu);%plane stress
else
    kappa=3-(4*nu);%plane strain
end

outsidebit=P/(pi*R*t*alpha);
topbit=(1-((r/R).^2))).*sind(2*alpha);
bottombit=1+((r/R).^4)-(2*((r/R).^2).*cosd(2*alpha));
firstbit=topbit./bottombit;
clearvars topbit bottombit
lastbit =atand(tand(alpha)*(1+((r/R).^2))./(1-((r/R).^2)))

sigtheta=outsidebit.*(firstbit-lastbit);
sigR=-outsidebit.*(firstbit+lastbit);

%is this bit correct?
sigx=sigR.*cosd(sigtheta);
sigy=sigtheta.*sind(sigtheta);
end