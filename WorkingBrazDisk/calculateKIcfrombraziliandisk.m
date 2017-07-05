function [KIc] = calculateKIcfrombraziliandisk(failure_load,D,t)
%calculates KIc from a brazilian disk experiment with a known failure load,
%Diameter and thickness

failure_strength=(2*failure_load)/(1000*pi*D*t)% I don't really know why the 1000 is here
KIc=failure_strength/6.76
end

