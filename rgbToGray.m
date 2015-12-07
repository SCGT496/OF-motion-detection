for j=111:130
    filePath = strcat('/Users/sichen/Documents/OF-motion-detection/OpticalFlow/',num2str(j),'_png/');
    fileInput = strcat(filePath,'output/');
    cd(fileInput);
    filesNumber = dir('*.png');  
    
    for i=1:(length(filesNumber))
        % load the two frames
        im1 = im2double(imread([fileInput num2str(i) '.png']));
        imToWrite = rgb2gray(im1);
        imwrite(imToWrite,strcat([fileInput num2str(i) '_grey.png']));

    end
    cd ..;
end
