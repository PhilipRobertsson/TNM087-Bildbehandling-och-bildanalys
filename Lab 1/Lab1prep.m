Image=imread('book-cover.tif');
max(Image(:))

Image2 = Image/16;
max(Image2(:));
imshow(Image2);

Image3 = Image2 * 16;
max(Image3(:));
imshow(Image3);

ImageDouble = im2double(Image);
imshow(ImageDouble);

Einstein=imread('einstein-low-contrast.tif');
DoubleEinstein = im2double(Einstein);
gmax = max(DoubleEinstein(:));
gmin = min(DoubleEinstein(:));
K = 1;
for i=1:490
    for k=1:600
        ResultEinstein(k,i) = K*(DoubleEinstein(k,i) - gmin)/(gmax-gmin);
    end
end
imshow(ResultEinstein);
max(ResultEinstein(:))
min(ResultEinstein(:))
imhist(ResultEinstein);

%%
angimask = imread('angiography-mask-image.tif');
angi = imread('angiography-live-image.tif');
angimask = im2double(angimask);
angi= im2double(angi);
AngiResult = angi - angimask;
imshow(AngiResult,[]);
%%
pollenlowc = imread('pollen-lowcontrast.tif');
pollenlowc = im2double(pollenlowc);
imshow(pollenlowc);
histeq(pollenlowc)
imhist(histeq(pollenlowc))
%%
shadepat = imread('Shade_pattern.tif');
shadepat = im2double(shadepat);

shadeest = imread('Shade_estimate.tif');
shadeest = im2double(shadeest);
imshow(shadepat), figure;
imhist(shadepat),figure;

%
%shadeReverse = shadepat ./ shadeest;
%imshow(shadeReverse), figure;
%imhist(shadeReverse),figure;
%

shadeSegment= imbinarize(shadepat, 0.28);
imshow(shadeSegment), figure;
imhist(shadeSegment),figure;
%%
I = zeros(400,600,3);
I(:,:,1) = 0.3;
I(:,:,2) = 0.1;
I(:,:,3) = 0.7;

I(150:250,:,3) = 0;
I(:,150:250,3) = 0;
I(150:250,:,2) = 1;
I(:,150:250,2) = 1;
I(150:250,:,1) = 1;
I(:,150:250,1) = 1;
imshow(I);