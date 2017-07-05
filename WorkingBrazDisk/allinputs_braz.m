%KIc=0; %fracture toughness
%KIIc=0;

%1 = inclined straight crack
%2 = arc crack
initialcracktype=1;

%1 = biaxial
%2 = uniaxial
%3 = pressurised with depth-varying stress field
%4 = brazilian disk according to Li08
stressstate=4;

D=0.05;%m (sample diameter)
t=0.026;%m (sample thickness)
Dratio=60; %number of segments in diameter
%crack tips
a=-2*D/Dratio;
b=2*D/Dratio;%set the crack initial size to one some ratio of the diameter

%half number of crack segments
J=5;
%ratio of nodes to segments
Nratio=8;%*2J
%ratio of M/N (collocation points to nodes. >=1)
MNratio=2.5;
%number of steps
nsteps=500;
%number of angle steps within 180 degrees
angleaccuracy=50000;
%sigratio = [Sigma_T(Arrester)]/[SigmaT(ST)]
%sigratio=1;

%uniaxial or biaxial stress
P0=1;
%angle anticlockwise of positive x-axis at which the crack lies
crackangledeg=89;%90=vertical, 0=horizontal (I think)
%max length
maxlength=10;

    %ARC CRACKS
        %arc angle
        Betadeg=45;
        %arc radius
        R=1;
        
        
KIonly=0;

%these two only come up in a ratio where they're both on the top and the
%bottom, so it really doesn't matter what we canll them
nu=0.2;%because why not?
youngsmod=10000;%MPa


                %I think MPa, because it only ever comes up in calculating
                %GIc, so this should let us compare with KIc in MPa.m(1/2)

min_failure_load=13.8%kN (From tavallali14)
max_failure_load=38%kN (From tavallali14)
minKIc=calculateKIcfrombraziliandisk(min_failure_load,0.05,0.026);
maxKIc=calculateKIcfrombraziliandisk(max_failure_load,0.05,0.026);

loadstep=-min_failure_load/5000;
initialload=loadstep;
load=loadstep;
planestressstrain=0; %0=plane stress, 1=plane strain

%minKIc=1.4103; %from tillyvilly 2010 table 4.3
%maxKIc=2.2387;
n_points=12;