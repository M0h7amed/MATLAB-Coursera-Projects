function in=saddle(M)
in=[];
%find max in each col

for j=1:size(M,1)
    maX=max(M(j,:));
    for i=1:size(M,2)
        miN=min(M(:,i));
        if M(j,i)==maX && M(j,i)==miN
            in=[in;j ,i];
            
        end
    end
    
end
        
        
    

    
    