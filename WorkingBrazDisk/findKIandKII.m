%extrapolating qn to +/-1 to find K at the right and left crack tip
%respectively

%KI_left=-M*(interp1(xi,real(qn),-1,'spline','extrap'))*(((b-a)/2).^(1/2))
%KII_left=-M*(interp1(xi,imag(qn),-1,'spline','extrap'))*(((b-a)/2).^(1/2))
%KI_right=M*(interp1(xi,real(qn),1,'spline','extrap'))*(((b-a)/2).^(1/2))
%KII_right=M*(interp1(xi,imag(qn),1,'spline','extrap'))*(((b-a)/2).^(1/2))

%--------------------------------------------------------------
%andreev15 formulation
%--------------------------------------------------------------
TN_neg1=cos(N*acos(-1));
TN_1=cos(N*acos(1));
neg1_powern=((-1*ones(1,N)).^(1:N)); %vector of (-1)^n
neg1_powernp1=((-1*ones(1,N)).^(2:N+1)); %vector of (-1)^n+1
sqrtbit=sqrt(1-(xi.^2));
q_neg1=(TN_neg1/M)*sum((neg1_powernp1.*qn'.*sqrtbit)./(-1-xi));
q_pos1=(TN_1/M)*sum((neg1_powernp1.*qn'.*sqrtbit)./(1-xi));

%--------------------------------------------------------------
%Galybin04 formulation
%-------------------------------------------------------------
%TN_neg1=cos(N*acos(-1));
%TN_1=cos(N*acos(1));
%neg1_powern=((-1*ones(1,N)).^(1:N)); %vector of (-1)^n
%sqrtbit=sqrt(1-(xi.^2));
%q_neg1=(TN_neg1/N)*sum((neg1_powern.*qn'.*sqrtbit)./(xi+1));
%q_pos1=(TN_1/N)*sum((neg1_powern.*qn'.*sqrtbit)./(xi+1));



KI_left=-M*sqrt((b-a)/2)*real(q_neg1);
KII_left=-M*sqrt((b-a)/2)*imag(q_neg1);
KI_right=M*sqrt((b-a)/2)*real(q_pos1);
KII_right=M*sqrt((b-a)/2)*imag(q_pos1);
stringy=strcat('KI_left=',num2str(KI_left),' KI_right=',num2str(KI_right),' KII_left=',num2str(KII_left),' KII_right=',num2str(KII_right));
disp(stringy)
clearvars TN_neg1 TN_1 neg1_powern neg1_powernp1 sqrtbit stringy
%KI_left_ratio=KI_left/KI_left1
%KII_left_ratio=KII_left/KII_left1
%KI_right_ratio=KI_right/KI_right1
%KII_right_ratio=KII_right/KII_right1