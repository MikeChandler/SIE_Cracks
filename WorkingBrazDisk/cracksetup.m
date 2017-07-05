%if KI is high enough to propagate each end of the crack, it is propagated
%by 1 segment each way. However, if KI is only high enough at one end, it
%is propagated by 2 segments


        %crack propagates each way simultaneously
        disp('crack propagating both ways')
        %I've just done this by running the propagate right bit and then the left
        b=b+DeltaS;
        L=b-a;
        J=J+1;
        %update the crack matrix
        newcrack=zeros(7,2*J);
        newcrack(1,:)=1:(2*J);
        newcrack(2,:)=horzcat(wrapToPi(alpha_left+crack(2,1)),crack(2,:),wrapToPi(alpha_right+crack(2,((2*J)-2))));
        clearvars dxA dyA dxB dyB
        %2J-2 location contains the previous crack tip angle
        [dxA,dyA]=pol2cart(newcrack(2,((2*J)-1)),DeltaS/2);
        %2J location contains the new crack tip angle
        [dxB,dyB]=pol2cart(newcrack(2,(2*J)),DeltaS/2);
        newcrack(3,:)=horzcat(0,crack(3,:),(crack(3,((2*J)-2))+dxA+dxB));
        newcrack(4,:)=horzcat(0,crack(4,:),(crack(4,((2*J)-2))+dyA+dyB));
        newcrack(6,:)=horzcat(load,crack(6,:),load);
        
        crack=newcrack;
        %crack propagates left
        a=a-DeltaS;
        L=b-a;
              
        
        %this bit subs in the left tip parameters
        clearvars dxA dyA dxB dyB
        %3 location contains the previous crack tip angle
        [dxA,dyA]=pol2cart(newcrack(2,2),DeltaS/2);
        %1 location contains the new crack tip angle
        [dxB,dyB]=pol2cart(newcrack(2,1),DeltaS/2);
        crack(3,1)=crack(3,2)-dxA-dxB;
        crack(4,1)=crack(4,2)-dyA-dyB;
        %newcrack(5,:)=(a+DeltaS/2):DeltaS:(b-DeltaS/2);
        crack(5,:)=linspace((a+DeltaS/2),(b-DeltaS/2),2*J);
        %newcrack(5,:)=linspace(-1+(1/(2*J)),1-(1/(2*J)),2*J);
        
        
        %sorts out the actual positions for when a depth is specified
        if stressstate==3
            %crack(6,:)=centredepth+(crack(3,:)*depthgrad);
            %crack(7,:)=(crack(4,:)*depthgrad);
        end
        
    