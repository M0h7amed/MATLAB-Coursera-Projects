function o=blur(img,w)
%% FUNCTION TO BLUR IMG
% (w) intensity of the blur

r=size(img,1); % rows number
c=size(img,2); % columns number



for i=1:r
    for j=1:c
        
        % limits
        upper_limit=max(1,i-w);
        lower_limit=min(r,i+w);

        left_limit=max(1,j-w);
        right_limit=min(c,j+w);

        sub_mat= img(upper_limit : lower_limit , left_limit :right_limit );

        o(i,j)=uint8(mean(sub_mat(:)));
    end
end



    


