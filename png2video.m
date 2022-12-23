path = dir('output\*.png');
images    = cell(size(path,1),1);
for i=1:size(path,1)
    [image{i} cmap{i}] = imread([path(i).folder '\' path(i).name]);
end
 % create the video writer with 1 fps
 writerObj = VideoWriter('.\output\100.avi');
 writerObj.FrameRate = 1;
 % set the seconds per image
 %secsPerImage = [2:2:40];
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=1:length(images)
     % convert the image to a frame
     frame = im2frame(image{u},cmap{u});
     %for v=1:secsPerImage(u) 
         writeVideo(writerObj, frame);
     %end
 end
 % close the writer object
 close(writerObj);