%Make sure to have image files in the matlab directory in order to execute this code. BMP file will be stored in local Matlab directory 


% Read the image file into an array
imageArray = imread('WizardFall.png');

% Write the array to a bitmap file
imwrite(imageArray, 'WizardFall.bmp', 'bmp');

% Display the bitmap image
imshow('WizardFall.bmp');
