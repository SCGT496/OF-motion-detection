% for k=1:5
%     for j=111:130
j=111;
k=2;
    %     filePath =
    %     strcat('/Users/sichen/Documents/OF-motion-detection/BMC/',num2str(j),'_png/');
        filePath = strcat('/Users/sichen/Documents/OF-motion-detection/',num2str(j),'_png/');
        fileInput = strcat(filePath,'input/');
        cd(fileInput);
        filesNumber = dir('*.png');  
        cd ..;
        cd ..;

        for i=1:(length(filesNumber)-1)

            image = imread('segment.png');
            cform = makecform('srgb2lab');
            lab_image = applycform(image,cform);
            ab = double(lab_image(:,:,2:3));
            nrows = size(ab,1);
            ncols = size(ab,2);
            ab = reshape(ab,nrows*ncols,2);

%             nColors = 3;
            nColors = k;
            % repeat timage clustering 3 times to avoid local minima
            [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                                  'Replicates',3);
            pixel_labels = reshape(cluster_idx,nrows,ncols);
            imshow(pixel_labels,[]), title('image labeled by cluster index');
            segmented_images = cell(1,6);
            rgb_label = repmat(pixel_labels,[1 1 3]);

            for m = 1:nColors
                color = image;
                color(rgb_label ~= m) = 0;
                segmented_images{m} = color;
            end

%             figure; imshow(segmented_images{1}), title('objects in
%             cluster 1'); figure; imshow(segmented_images{2}),
%             title('objects in cluster 2'); figure;
%             imshow(segmented_images{3}), title('objects in cluster 3');
        end
%     end
% end
