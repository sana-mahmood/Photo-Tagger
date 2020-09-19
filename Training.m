FDetect = vision.CascadeObjectDetector;
Train=[];
Response=[];
for i=1: 1: 3
    name='';
    if(i==1)
        name='khizar';
        Response(1:40,:)=0;
    elseif(i==2)
        name='uswa';
        Response(41:80,:)=1;
    elseif(i==3)
        name='isfand';
        Response(81:120,:)=2;
    end
    
    for j=1:1:40
        filename=strcat(name,num2str(j),'.jpg');
        I=imread(filename);
        features=extractHOGFeatures(I);
        Train = cat(1,Train,features);
    end
end
mdl=fitcecoc(Train,Response);
save('TrainedDB','mdl');