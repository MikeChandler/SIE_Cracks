%define total number of nodes, N
N=Nratio*2*J;
%define N values of xi, and N-1 values of eta
n=1:N;
xi=cos((((2*n)-1)*pi)/(2*N)); %following galybin04 and galybin04b, disagreeing with andreev15, not totally sure where the pi is meant to be
%meanxi=mean(xi)
M=ceil(N*MNratio);
%M=N+1;
m=1:M-1;
eta=(cos(m*(pi/M)))'; % following galybin04 and galybin04b. I'm pretty sure the bottom hewre is meant to be M, but is could *possibly* be N
%meaneta=mean(eta)
%make up a pair of NxM matrices of xi and eta
[m_xi,m_eta]=meshgrid(xi,eta);

%define s and r according to galybin04 etc.
m_s=(m_xi*((b-a)/2))+((b+a)/2);
m_r=(m_eta*((b-a)/2))+((b+a)/2);

s=m_s(1,:);
r=m_r(:,1);
%meanS=mean(s)
%meanR=mean(r)
%Find U_(N-1) and T(N)
%Galybin04 and andreev15 both use U_N(eta) and T_N(eta), but galybin04b
%use T_N{xi)
%if these are all functions of eta, the Ns should presumably be Ms?
m_TN=cos(N*acos(m_eta));
meanTN=mean(mean(m_TN));
meanabsTN=mean(mean(abs(m_TN)));
m_UNsub1=(sin(N*acos(m_eta)))./((1-m_eta.^2).^(1/2));

meanUN=mean(mean(m_UNsub1));
meanabsUN=mean(mean(abs(m_UNsub1)));
%UNsub1=m_UNsub1(:,1);
%TN=m_TN(:,1);