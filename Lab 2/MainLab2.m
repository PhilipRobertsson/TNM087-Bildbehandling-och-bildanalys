Image = imread("zoneplate.tif");
Image = im2double(Image);

lowpass1 = ones(9)/(9^2);
lowpass2 = ones(21)/(21^2);

[olp, ohp, obr, obp, oum, ohb] = myfilter(Image,lowpass1,lowpass2);
montage({olp,ohp,obr,obp,oum,ohb});
%%
Image = imread("test4.tif");
Image = im2double(Image);
q =6;
imElim = eliminateobjects(Image,q);
imshow(Image), figure;
imshow(imElim);