function [proporno,thetamax] = anisopropangle2(KI,KII,phi,KIcField,angleaccuracy,poisrat,Youngsmod,gammadeg)
%Finds the angle at which the maximum value of sig_QQ/sig_T occurs for an
%elliptically anisotropic material
%thetaKIcfield needs to be in radians
%proporno comes out equal to 1 if GI is greater than GIc at some angle,
%otherwise it is zero

%-------------------------------------------------------------
%-------------------------------------------------------------
%   DEFINITIONS
%0 is the direction perpendicular to the loading
%-Theta = angle between final crack segment and next segment
%-Phi = Angle between 0 and (current) final crack segment
%-Zeta = Theta + Phi; Angle between 0 and potential next segment
%-Gamma = Angle between 0 and bedding perpendicular


thetadeg=-(180*angleaccuracy):(180*angleaccuracy);
thetadeg=thetadeg/angleaccuracy;
theta=deg2rad(thetadeg);
clearvars thetadeg
zeta=theta+phi;

%--------------------------------------------------
%Calculate crack tip stress intensity factors
%following cotterell80
%--------------------------------------------------
C11=(1/4)*((3*cos(theta/2))+cos(theta*3/2));
C12=(-3/4)*(sin(theta/2)+sin(theta*3/2));
C21=(1/4)*(sin(theta/2)+sin(theta*3/2));
C22=(1/4)*(cos(theta/2)+(3*cos(theta*3/2)));
KItip=(C11*KI)+(C12*KII);
KIItip=(C21*KI)+(C22*KII);
clearvars C11 C12 C21 C22
Gtip=((1-poisrat^2)./Youngsmod).*((KItip.^2)+(KIItip.^2));
%max(KItip)

clearvars KItip KIItip

%We now have Gtip as a function of theta

%Interpolate KIcField over entire range
%first mirror the KIcField and Theta so that they go in the plus and minus
%direction
kappa=linspace(0,(pi/2),length(KIcField));
KIcField=horzcat(KIcField,fliplr(KIcField(1:(end-1))));
KIcField=horzcat((fliplr(KIcField(2:end))),KIcField);
kappa=horzcat(kappa,((pi/2)+kappa(2:end)));
kappa=horzcat((-fliplr(kappa(2:end))),kappa);
%Now shift kappa by gamma, so that the KIc field is relative to zero
%let's call that iota
%24/12/16 - Pretty sure this is plus
iota=kappa+deg2rad(gammadeg);
%then let's shift by phi to get it into theta space, and call the new
%variable upsilon
%24/12/16 - Pretty sure this is plus, check from page 5 of my theory book
upsilon=iota-phi;
upsilon=horzcat((upsilon(1:end-1)-2*pi),upsilon,(upsilon(2:end)+2*pi));
KIcField=horzcat(KIcField(1:end-1),KIcField,KIcField(2:end));
%so now KIc(upsilon) is equivalent to KI(theta)
%now interpolate it to whatever the angle accuracy is
    KIcFieldFull=interp1(upsilon,KIcField,theta,'pchip');
    %so we now have a KIc value at each angle, theta
    %find GIc field
    GIc=((1-poisrat^2)./Youngsmod).*(KIcFieldFull.^2);
    %------------------------------------------------

%At this point, GIc is a function of theta, and so is Gtip

%find the ratio of GI for a potential crack at each angle, to the GIc at
%that angle
GtipoverGIc=Gtip./GIc;
%anglecomponent=roundsd(anglecomponent,18);
%anglecomponent = round(anglecomponent*(10^18))/(10^18);
clearvars ftt KIcFieldfull
%calculate the preferred angle for the crack

%this bit is to find the nearest value to theta=0, where the 
[maxval,maxloc]=max(GtipoverGIc);
%maxval
if maxval>=1
    proporno=1;
else
    proporno=0;
end

maxlocations=find(GtipoverGIc==maxval);
thetasatmax=(theta(maxlocations));
%[val,loc]=min(abs(zetasatmax)); %find closest to zeta=0
%thetamax=zetasatmax(loc)-phi;


%[val,loc]=min(abs(thetasatmax));
%thetamax=thetasatmax(loc);
%-----------------------------------------
%01/01/17 version
%----------------------------------------
absthetasatmax=abs(thetasatmax);
absthetamax=min(absthetasatmax);
thetamax=thetasatmax(absthetasatmax==absthetamax);
%--------------------------------------
%previous version
%--------------------------------------
thetamax=mean(thetasatmax);
%-----------------------------------------
thetamaxdeg=rad2deg(thetamax);

    if length(thetasatmax)>1 | length(thetasatmax')>1
    thetasatmaxdeg=rad2deg(thetasatmax);
        fname=['.\outputs\angleswithmax_',num2str(thetamaxdeg),'.mat'];
        save(fname,'thetasatmaxdeg')
        disp('multiple angles with peak sigmaQQ')
    end
%-------------------------------------
%replicate those plots from my ambient jgr paper
%------------------------------------------------

%h=figure ;

%plot(rad2deg(theta),Gtip)
%hold all
%plot(rad2deg(theta),GIc)
%plot([thetamaxdeg thetamaxdeg],[0 max(GIc)])
%hold off
%xlabel('\theta (^o)')
%xlim(rad2deg([min(theta) max(theta)]))
%set(gca,'XDir','reverse')
%ylabel('G')
%drawnow %limitrate;
    
%close(h);    
end