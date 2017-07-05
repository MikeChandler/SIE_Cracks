function [sigx,sigy,tauxy] = Li08BDstressfield(planestressstrain,nu,F,R,t,x,y)
%calculates the stress field at x,y in a brazilian disk or radius R
%   Detailed explanation goes here
F=F/t; %normalise by sample thickness

%lastbit=atan((1+(r/R)^2)*tan(alpha)/(1-(r/R)^2));

%Equations from Appendix of Liu, (2008)

if planestressstrain==0
    kappa=(3-nu)/(1+nu);%plane stress
else
    kappa=3-(4*nu);%plane strain
end

%up1=(F/(4*pi*shearmod));
%up2=(1-kappa)*atan((2*R*x)/(x^2+y^2-R^2));
%up3=(1-kappa)*x/R;
%up4t=4*R*x*(R^2-y^2+x^2);
%up4b=(R^2+x^2-(2*R*y)+y^2)*(R^2+x^2+(2*R*y)+y^2);
%u=-up1*(up2+up3-(up4t/up4b));

%vp1=up1;
%vp4b=up4b;
%clearvars up1 up2 up3 up4t up4b
%vp2=((1+kappa)/2)*ln(((R+y)^2+x^2)/((R-y)^2+x^2));
%vp3=up3;
%vp4t=8*R*(x^2)*y;

%v=-vp1*(vp2+vp3-(vp4t/vp4b));
%clearvars vp1 vp2 vp3 vp4t vp4b

sigxp1=(-2*(F))/pi;
sigxp4=F/(pi*R);
sigxp2=((x.^2).*(R-y))./((R^2+x.^2-(2*R*y)+y.^2).^2);
sigxp3=((x.^2).*(R+y))./((R^2+x.^2+(2*R*y)+y.^2).^2);
sigx=(sigxp1.*(sigxp2+sigxp3))+sigxp4;

clearvars sigxp2 sigxp3
sigyp2=((R-y).^3)./((R^2+x.^2-(2*R*y)+y.^2).^2);
sigyp3=((R+y).^3)./((R^2+x.^2+(2*R*y)+y.^2).^2);
sigy=(sigxp1.*(sigyp2+sigyp3))+sigxp4;

clearvars sigyp2 sigyp3
tauxyp1=(2*F)/pi;
tauxytop=(4*R.*x.*y).*(R^2-y.^2-x.^2).*(R^2-y.^2+x.^2);
tauxybot=((R^2+x.^2-(2*R*y)+y.^2).^2).*((R^2+x.^2+(2*R*y)+y.^2).^2);
tauxy=tauxyp1*(tauxytop./tauxybot);

end