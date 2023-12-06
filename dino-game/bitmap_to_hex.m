% Read the bitmap 
b = imread('FireballFR.bmp');

% Initialize the array to store hex values
a = [];

% Convert image data to hexadecimal
k = 1;
for i = size(b, 1):-1:1  % image is written from the last row to the first row
    for j = 1:size(b, 2)
        a(k) = b(i, j, 1);  % Red
        a(k + 1) = b(i, j, 2);  % Green
        a(k + 2) = b(i, j, 3);  % Blue
        k = k + 3;
    end
end

% Write the hex data to a file
fid = fopen('FireballFR.hex', 'wt');
fprintf(fid, '%x\n', a);
fclose(fid);
