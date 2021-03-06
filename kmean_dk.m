function [ finalThresh, finalD ] = kmean_dk( input )
%UNTITLED2 calculates kmeans on input array
%   Detailed explanation goes here

%set params
lastCentroid1 = 0;
lastCentroid2 = 0;

D = 0;
finalD = 1000000;

epsilon = 1;
thresh = 0;
R = 10;
N = length(input);

finalThresh = 0;


for r = 1:R
    centroid1 = input(randi(N));
    centroid2 = input(randi(N));
    while(abs(lastCentroid1 - centroid1) > epsilon && abs(lastCentroid2 - centroid2) > epsilon)
        %update distances
        for i = 1:length(input)
            if(abs(input(i) - centroid1) < abs(input(i) - centroid2))
                clusters(i) = false;
            else
                clusters(i) = true;
            end
        end

        %update centroids
        sum1 = 0; sum2 = 0;
        cnt1 = 0; cnt2 = 0;
        for i = 1:length(input)
            if(clusters(i) == false)
                sum1 = sum1 + input(i);
                cnt1 = cnt1 + 1;
            else
                sum2 = sum2 + input(i);
                cnt2 = cnt2 + 1;
            end
        end

        if(cnt1 == 0) 
            cnt1 = 1;
        end
        if(cnt2 == 0)
            cnt2 = 1;
        end

        lastCentroid1 = centroid1;
        lastCentroid2 = centroid2;

        centroid1 = sum1/cnt1;
        centroid2 = sum2/cnt2;
        
        %D = (cnt1*sum1 + cnt2*sum2)/N;
        D = sum(abs(input(clusters == false) - centroid1)) + sum(abs(input(clusters == true) - centroid2));

        thresh = (centroid1 + centroid2)/2;
    
    end
    
    if(D < finalD)
        finalD = D;
        finalThresh = thresh;
    end
    
end
