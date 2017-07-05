
n=1:N;
m_n=repmat(n,M-1,1);
m_neg1_powern=(-1*ones(M-1,N)).^m_n; %matrix of (-1)^n

%Fn from galybin04 
%Fnleft=((ones(size(m_n))+m_neg1_powern.*m_UNsub1.*(sqrt(ones(size(m_n))-(m_xi.^2))))./(m_xi-m_eta))+m_K1+m_K2; % for n=1...N
Fnleft=((1+(m_neg1_powern.*m_UNsub1.*(sqrt(1-m_xi.^2))))./(m_xi-m_eta))+m_K1+m_K2;

%Fnright=1i.*(((ones(size(m_n))+m_neg1_powern.*m_UNsub1.*(sqrt(ones(size(m_n))-(m_xi.^2))))./(m_xi-m_eta))+m_K1-m_K2); % for n=(N+1)...2N
Fnright=1i*(((1+(m_neg1_powern.*m_UNsub1.*(sqrt(1-m_xi.^2))))./(m_xi-m_eta))+m_K1-m_K2);


Atop=horzcat(real(Fnleft),(real(Fnright)));
Amid=horzcat(imag(Fnleft),(imag(Fnright)));

Atop=vertcat(Atop,Amid);
clearvars Fnleft Fnright Amid

%Dn from galybin04 - I think I've set this up correctly looking at the real
%and imaginary parts separately.
%dn=exp(1i*theta_s); %
%clearvars m_K1 m_K2 m_n m_neg1 m_TN m_Tr m_Ts m_UNsub1 m_eta m_neg1_powern m_r m_s m_xi theta_s theta_r
%Abot=vertcat(horzcat(real(dn),zeros(1,N)),horzcat(zeros(1,N),imag(dn)));

%Dn from galybin04 - direct copy
dn=horzcat((exp(1i.*theta_s)),(1i*exp(1i.*theta_s)));
Abot=vertcat(real(dn),imag(dn));

clearvars dn
%clearvars Fnleft Fnright dn

%the Dn part is scaled up, in order to improve the conditioning of the
%matrix
meantop=mean(abs(nonzeros(real(Atop))));
meanbot=mean(abs(nonzeros(real(Abot))));
scalefactor=meantop/meanbot;
%scalefactor=1
Abot=Abot*scalefactor;

%stick the matrix together
A=vertcat(Atop,Abot);
clearvars Atop Abot
%clearvars meantop meanbot scalefactor Atop Abot
