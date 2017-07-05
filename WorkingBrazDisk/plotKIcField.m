kappaKIcField=linspace(0,90,length(KIcField));
kappadeg=0:(90*angleaccuracy);
kappadeg=kappadeg/angleaccuracy;

KIcFieldFull=interp1(kappaKIcField,KIcField,kappadeg,'pchip');

%-------
%The actual plotting bit
%----------
%figure 
%plot(kappadeg,KIcFieldFull)
%xlabel('Angle from bedding perpendicular (^o)') % x-axis label
%ylabel('KIc (MPa.m^{1/2})') % y-axis label
%hold off
%drawnow %limitrate