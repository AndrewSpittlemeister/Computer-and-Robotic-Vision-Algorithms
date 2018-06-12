function run_opticalflowHS(in_vid,out_vid)
% Performs optical flow algorithm on a video, creates and saves a new mp4
% video to the filesystem containing the optical flow field vectors for
% each frame.

% in_vid = name of input video file.
% out_vid = name of output video file (must be .mp4).

    axis tight manual 
    set(gca,'nextplot','replacechildren'); 
    vid = VideoReader(in_vid);
    vidWriter = VideoWriter(out_vid, 'MPEG-4');
    vidWriter.FrameRate = vid.FrameRate;
    open(vidWriter);
    imshow(flip(rgb2gray(read(vid,1))));
    
    for i=2:vid.NumberOfFrames
        im1 = gpuArray(flip(rgb2gray(read(vid,i-1))));
        im2 = gpuArray(flip(rgb2gray(read(vid,i))));
        [u,v] = computeFlow(im1, im2, 100);
        u = imresize(u, 0.125);
        v = imresize(v, 0.125);
        quiver(u,v);
        frame = getframe(gcf);
        writeVideo(vidWriter,frame);
    end
    close(vidWriter);
end

