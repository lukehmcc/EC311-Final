% Read the image file into an array
imageArray = imread('WizardFall.png');

% Write the array to a bitmap file
imwrite(imageArray, 'WizardFall.bmp', 'bmp');

% Display the bitmap image
imshow('WizardFall.bmp');
