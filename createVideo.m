% Make an avi movie from a collection of PNG images in a folder.
% Specify the folder.
% myFolder = '/Users/sichen/Documents/OF-motion-detection/111/';
myFolder = '/Users/sichen/Downloads/111_png/input/';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
% Get a directory listing.
filePattern = fullfile(myFolder, '*.png');
pngFiles = dir(filePattern);
% Open the video writer object.

writerObj = VideoWriter('111_input.avi');
open(writerObj);
% Go through image by image writing it out to the AVI file.
for frameNumber = 1 : length(pngFiles)
    % Construct the full filename.
    baseFileName = pngFiles(frameNumber).name;
    fullFileName = fullfile(myFolder, baseFileName);
    % Display image name in the command window.
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Display image in an axes control.
    imageArray = imread(fullFileName);
%     imshow(imageArray);  % Display image.
%     drawnow; % Force display to update immediately.
    % Write this frame out to the AVI file.
    writeVideo(writerObj, imageArray);
end
% Close down the video writer object to finish the file.
close(writerObj);
