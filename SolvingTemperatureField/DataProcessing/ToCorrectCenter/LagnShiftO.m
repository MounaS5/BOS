function [y_a_avg_c,lag1,y_a_avg_c2] = LagnShiftO(y_1,y_2)
%y_1 = U_Ch(1,:); y_2 = V_Ch(1,:);
         if isrow(y_1) 
            y=y_1(:);
            x=y_2(:);
         end
        
% STEP 1: Find Lag
        lag1 = findLag(y); 
        
% STEP 2 : Lag correction. Append that many zeros (lag1+1) to shift the plot. 
        if lag1 > 0
           y_new1 = y(1:(end-lag1+1),1); % right part needs corrections
           x_new1 = x(1:(end-lag1+1),1);
        elseif lag1 < 0
           y_new1 = y(-lag1+1:end,1); % left part needs correction
           x_new1 = x(-lag1+1:end,1);
        elseif lag1 == 0
           y_new1 = y;
           x_new1 = x;
        end
        
% STEP 3 : Find the centre to split the data again to generate an averaged plot

% %         n1 = rCenter(y_new1);    
% %         n2 = n1+1;
        centres =[rCenter(y_new1),rCenter(y_new1)+1];
        y_nnew = y_new1.';
        x_nnew = x_new1.';
        n3 = zeroValuedPixel(y_nnew,centres);
        [xNew,yNew] = interpolatedData(y_nnew,n3);
        [yNew2] = interpolatedData2(x_nnew,xNew);
        y_new1 = yNew.';
        y_new2 = yNew2.';
        
        %n1 = n3;   %new centre
        if n3 == centres(1)
            n1 = centres(1);
        elseif n3 == centres(2)
            n1 = centres(2);
        else
            n1 = floor(n3);
        end
               
%         if mod(n1,2) == 1 
%             Avg_l = abs(y_new1(1:n1,1));
%             Avg_r = abs(y_new1((end:-1:n1),1));
%         elseif mod(n1,2) == 0
%             Avg_l = abs(y_new1(1:n1,1));
%             Avg_r = abs(y_new1((end:-1:n1+1),1));
%         end
       Avg_l = abs(y_new1(1:n1,1));
       Avg_r = abs(y_new1((end-2:-1:n1),1));
       
       Avg_l2 = abs(y_new2(1:n1,1));
       Avg_r2 = abs(y_new2((end-2:-1:n1),1));
       
      % Averaging won't be possible for unequal dimensions.
        d = size(Avg_r,1)-size(Avg_l,1);
 
      % Find averaged plot. If the left and right parts are of unequal
      % lengths adjust the other according to the shorter one
        if d==0
            Avg   = (Avg_l + Avg_r)./2;
            Avg2  = (Avg_l2 + Avg_r2)./2;
        elseif d > 0
            Avg_r1 = Avg_r(1+d:1:end,1);
            Avg   = (Avg_l + Avg_r1)./2;
            Avg_r12 = Avg_r2(1+d:1:end,1);
            Avg2  = (Avg_l2 + Avg_r12)./2;
        elseif d < 0
            Avg_l1 = Avg_l(-d+1:n1);
            Avg   = (Avg_l1 + Avg_r)./2; 
            Avg_l12 = Avg_l2(-d+1:n1);
            Avg2   = (Avg_l12 + Avg_r2)./2; 
        end
        
%         if mod(n1,2) == 0
%             y_a_avg = vertcat(-Avg,(Avg(end:-1:1,1)));
%         elseif mod(n1,2)==1
%             y_a_avg = vertcat(-Avg,(Avg(end-1:-1:1,1)),0);
%         end
%         
        y_a_avg = vertcat(-Avg(1:1:end-1),Avg(end,1),Avg(end-1:-1:1,1));
        y_a_avg2 = vertcat(Avg2(1:1:end-1),Avg2(end,1),Avg2(end-1:-1:1,1));
       
        if isrow(y_1)
            y_a_avg_c = y_a_avg.';
        end
        
        if isrow(y_2)
            y_a_avg_c2 = y_a_avg2.';
        end
        %y_a_avg = y_a_avg.';
        %disp(y_a_avg)
end

