% Read the PNG image
img = imread('Fireball.png');

% Convert the image to grayscale
img_gray = rgb2gray(img);

% Resize the image to 16x16
img_resized = imresize(img_gray, [16 16]);

% Convert the resized image to a bitmap image
img_bitmap = imbinarize(img_gray); % Otsu's method is used by default

% Write the bitmap image to a file
imwrite(img_bitmap, '/Users/aamaya3/Desktop/311 Sprites/Fireball.bmp');

% Display the bitmap image
%imshow(img_bitmap);
