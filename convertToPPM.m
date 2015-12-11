for i=1:1498
    fileOut = strcat(num2str(i),'.ppm');
    fileIn = strcat(num2str(i),'_flow.png');
    imgTemp = imread(fileIn);
    imwrite(imgTemp,fileOut);
    
end
