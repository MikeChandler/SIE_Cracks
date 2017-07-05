%writes the new lines into the summary array thingy


%if profile>1 || gammaloop>1 %so any time other than the very first
    %summaryfilename
    %clearvars summaryarray
    %break
    %load(summaryfilename)%, 'summaryarray')
%end
summaryline=summaryline+1;
failureload=crack(6,length(crack));% the load at the last point in the thing
summaryarrayline=horzcat(D,t,n_angles,n_KIcs,profile,gammadeg,failureload,KIcField);
if summaryline==1
    summaryarray=summaryarrayline;    
else
    summaryarray=vertcat(summaryarray,summaryarrayline);
end
%save summaryarray
%if profile==n_profiles
    
   save(summaryfilename,'summaryarray');
%end

clearvars failureload summaryarrayline