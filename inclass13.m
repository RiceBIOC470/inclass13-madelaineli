%Inclass 13
%GB comments
It may be helpful in the future to use bwareaopen to remove the tiny masks without changing your real larger masks. 
1a 100
1b 100
1c 100
1d 100
2a 100
2b 100
2c 100
overall: 100

%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright. 
img = imread('Dish1Well8Hyb1Before_w0001_m0006.tif');
img = im2double(img);
mean = sum(img(:))/(1024^2);
bg = img<mean;
img(bg) = 0;
figure(1)
imshow(img)

noise = strel('disk',10);
img_d = imdilate(img,noise);
normimg = img./img_d;
figure(2)
imshow(normimg)

% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true. 
mask = normimg > mean;
mask = imerode(mask,noise);
mask = imdilate(mask,noise);

figure(3)
imshow(mask);


% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.
border = edge(mask,'sobel');
figure(4)
imshow(border)

% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 
color = cat(3,img,mask,border);
figure(5)
imshow(color)

%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the objects
stat = regionprops(mask,'Centroid');
center = cat(1,stat.Centroid);

%center = cat(1,stat.Centroid)
%B. display the mask and plot the centers of the objects on top of the
%objects
figure(6)
imshow(mask)
hold on
plot(center(:,1), center(:,2),'r*', 'MarkerSize', 5);
hold off
%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 
blank = ones(1024);
figure(7)
axis([0 1024 0 1024])
imshow(blank)
hold on
plot(center(:,1),center(:,2),'r*', 'MarkerSize', 5);
hold off
