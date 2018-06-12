function reduce_video_size(vid, factor, new_vid_name)
% Reduces the dimensions of the video by factor and saves it as new_vid_name.

% vid = VideoReader object of input video.
% factor = floating point number that reduces the video by itself.
% new_vid_name = name of new video file (must be .mp4).

    writerObj = VideoWriter(new_vid_name, 'MPEG-4');
    writerObj.FrameRate = vid.FrameRate;
    open(writerObj);
    
    while hasFrame(vid)
        img = readFrame(vid);
        img = rgb2gray(img);
        img = imresize(img, factor);
        writeVideo(writerObj, img);
    end
    
    close(writerObj);
end

