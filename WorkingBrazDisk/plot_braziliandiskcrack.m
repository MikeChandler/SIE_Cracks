%HAVE CHECKED (24/12/16). I am pretty sure 

if step>1
    close (h1) %close the most recent plot
end
[xp yp] = makeprettycircle(0,0,D/2);


h1=figure 
plot(xp,yp)
hold all
%plot a line at the angle of gamma
%gamma is defined as the angle between zero and bedding perpendicular
plot([D/2*cosd(90-gammadeg) -D/2*cosd(90-gammadeg)],[-D/2*sind(90-gammadeg) D/2*sind(90-gammadeg)])
axis equal
plot(crack(3,:),crack(4,:))

hold off
drawnow %limitrate