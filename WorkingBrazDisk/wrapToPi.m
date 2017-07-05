function [angle_rad_out] = WrapToPi( angle_rad_in )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
angle_rad_out = angle_rad_in - 2*pi*floor( (angle_rad_in+pi)/(2*pi) ); 

end

