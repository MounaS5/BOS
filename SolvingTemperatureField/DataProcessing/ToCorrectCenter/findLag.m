function [lag] = findLag(y)
% STEP 1 : Function to split the data into left and right halves
        n = rCenter(y);      
                 
% STEP 2 : Turn data to positive values and split
        y_a1=abs(y);
        if mod(n,2) == 1       % n is odd
            y_l = y_a1(1:n,1);
            y_r = y_a1((end:-1:n),1);
        elseif mod(n,2) == 0   % n is even
            y_l = y_a1(1:n,1);
            y_r = y_a1((end:-1:n+1),1);
        end          
        
% STEP 3 : Apply correlation. Find max correlation value which is lag.
        [Clr,laglr] = xcorr(y_r,y_l); %Correlation
        [~,Ilr] = max(Clr); % Max is where you have lag
        lag = laglr(Ilr);
        
end

 %disp(n); 
