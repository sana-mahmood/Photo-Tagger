FDetect = vision.CascadeObjectDetector;
load('TrainedDB','mdl');
prompt='Enter Image Path';
answer = inputdlg(prompt);
str=char(answer);
Ans=exist(str);

if(Ans==2)
    testpic=imread(str);
    BB = step(FDetect,testpic);
    [x,y]=size(BB);

    ValidFaces=[];
    for i=1:1:x
        if(BB(i,3)>100 && BB(i,4)>100)
            ValidFaces=cat(1,ValidFaces,BB(i,:));
        end
    end

    label=[];
    [m,n]=size(ValidFaces);
    for i=1:1:m
        croppedimg=imcrop(testpic,ValidFaces(i,:));
        resizedimg = imresize(croppedimg,[546 426]);
        testFeatures=extractHOGFeatures(resizedimg);
        temp=predict(mdl,testFeatures);
        label=cat(1,label,temp);
    end
    RGB=testpic;
    for i=1:1:m
        if(label(i,1)==0)
            text='Khizar';
        elseif(label(i,1)==1)
            text='Uswa';
        elseif(label(i,1)==2)
            text='Isfand';
        end
        position=[];
        position=cat(2,position,ValidFaces(i,1));
        position=cat(2,position,ValidFaces(i,2)+ValidFaces(i,3));
        RGB=insertText(RGB,position,text,'FontSize',40,'BoxColor','green');
    end
    imshow(RGB);
else
    h=msgbox('Image not found!');
end