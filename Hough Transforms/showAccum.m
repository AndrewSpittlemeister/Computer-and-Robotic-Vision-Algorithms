function showAccum(A)
    AccumArrayImage = uint8(255 * mat2gray(A));
    figure
    imshow(AccumArrayImage * 5); % multiplied by 5 to accentuate the lines in the image.
    title("Lines Image Accumulator Array");
    xlabel("theta");
    ylabel("rho");
end

