addpath('mex');

for j=111:130
%     filePath = strcat('/Users/sichen/Documents/OF-motion-detection/BMC/',num2str(j),'_png/');
    filePath = strcat('/Users/sichen/Documents/OF-motion-detection/OpticalFlow/',num2str(j),'_png/');
    fileInput = strcat(filePath,'input/');
    cd(fileInput);
    filesNumber = dir('*.png');  
    cd ..;
    cd ..;
    
    for i=1:(length(filesNumber)-1)
        % load the two frames
        im1 = im2double(imread([fileInput num2str(i) '.png']));
        im2 = im2double(imread([fileInput num2str(i+1) '.png']));

        % set optical flow parameters (see Coarse2FineTwoFrames.m for the definition of the parameters)
        alpha = 0.012;
        ratio = 0.75;
        minWidth = 20;
        nOuterFPIterations = 7;
        nInnerFPIterations = 1;
        nSORIterations = 30;

        para = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];

        % this is the core part of calling the mexed dll file for computing optical flow
        % it also returns the time that is needed for two-frame estimation
%         tic;
        [vx,vy,warpI2] = Coarse2FineTwoFrames(im1,im2,para);
%         toc

    %     figure;imshow(im1);figure;imshow(warpI2);

        % output gif
        clear volume;
        volume(:,:,:,1) = im1;
        volume(:,:,:,2) = im2;
        if exist('output','dir')~=7
            mkdir('output');
        end
%         frame2gif(volume,fullfile('output',[example '_input.gif']));
        volume(:,:,:,2) = warpI2;
%         frame2gif(volume,fullfile('output',[example '_warp.gif']));

        % visualize flow field
%         clear flow;
        flow(:,:,1) = vx;
        flow(:,:,2) = vy;
        imflow = flowToColor(flow);

%         figure;imshow(imflow);
        imwrite(imflow,strcat([fileInput num2str(i) '_flow.png']));

    end
end
