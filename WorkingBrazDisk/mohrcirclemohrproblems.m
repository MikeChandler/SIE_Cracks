function [ sigtheta, tau ] = mohrcirclemoreproblems(sigx,sigy,theta)
%UNTITLED Summary of this function goes here
%   Following Ernie's Lecture notes
sigtheta=((1/2).*(sigy+sigx))+((1/2).*(sigy-sigx).*cos(2.*theta));
tau=(1/2)*(sigy-sigx).*(sin(2*theta));

end

