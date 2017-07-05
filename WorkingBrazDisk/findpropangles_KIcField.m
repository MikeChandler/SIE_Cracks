

[proporno_right,alpha_right]=anisopropangle_vDec16(KI_right,KII_right,crack(2,2*J),KIcField,angleaccuracy,nu,youngsmod,gammadeg);
[proporno_left,alpha_left]=anisopropangle_vDec16(KI_left,KII_left,crack(2,1),KIcField,angleaccuracy,nu,youngsmod,gammadeg);

alpha_right_deg=rad2deg(alpha_right);
alpha_left_deg=rad2deg(alpha_left);
if proporno_right | proporno_left ==1
    proporno=1;  
else
    proporno=0;
end

