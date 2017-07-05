%define the kernels according to andreev15. I believe that these are the
%same as those on galybin04, galybin04b and andreev13

%m_K1=(((b-a)/2).*(exp(1i*(m_thetas-m_thetar))).*real((exp(1i*m_thetar))./(m_Ts-m_Tr)))-((ones(M-1,N))./(m_xi-m_eta));
%m_K2=(((b-a)/4)*((exp(-1i*m_thetas)))./(conj(m_Ts)-conj(m_Tr))).*(ones(size(m_Ts))-(((m_Ts-m_Tr)./(conj(m_Ts)-conj(m_Tr))).*exp(-2*1i*m_thetar)));

%m_K1=(((b-a)/2).*(exp(1i*(m_thetas-m_thetar))).*real((exp(1i*m_thetar))./(m_Ts-m_Tr)))-(1./(m_xi-m_eta));
%m_K2=(((b-a)/4)*((exp(-1i*m_thetas)))./(conj(m_Ts)-conj(m_Tr))).*(1-(((m_Ts-m_Tr)./(conj(m_Ts)-conj(m_Tr))).*exp(-2*1i*m_thetar)));

m_K1_1=(b-a)/2;
meanK1_1=mean(mean(m_K1_1));
m_K1_2=exp(1i*(m_thetas-m_thetar));
meanK1_2=mean(mean(m_K1_2));
m_K1_3=real((exp(1i*m_thetar))./(m_Ts-m_Tr));
meanK1_3=mean(mean(m_K1_3));
m_K1_4=1./(m_xi-m_eta);
meanK1_4=mean(mean(m_K1_4));
m_K1=(m_K1_1.*m_K1_2.*m_K1_3)-m_K1_4;
%meanK1=mean(mean(m_K1))
%meanabsK1=mean(mean(abs(m_K1)))
clearvars m_K1_1 m_K1_2 m_K1_3 m_K1_4

m_K2_1=(b-a)/4;
meanK2_1=mean(mean(m_K2_1));
m_K2_2=(exp(-1i*m_thetas))./(conj(m_Ts)-conj(m_Tr));
meanK2_2=mean(mean(m_K2_2));
m_K2_3=1-(((m_Ts-m_Tr)./(conj(m_Ts)-conj(m_Tr))).*(exp(-2*1i*m_thetar)));
meanK2_3=mean(mean(m_K2_3));
m_K2=m_K2_1.*m_K2_2.*m_K2_3;
%meanK2=mean(mean(m_K2))
%meanabsK2=mean(mean(abs(m_K2)))
clearvars m_K2_1 m_K2_2 m_K2_3

%Kernelsmatrix=[meanK1_1,meanK1_2,meanK1_3,meanK1_4,meanK1;meanK2_1,meanK2_2,meanK2_3,0,meanK1];