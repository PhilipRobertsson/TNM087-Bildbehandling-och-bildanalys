function [RGB_Range, IR_Select] = LevelSlicing( RGB_Image, IR_Image, LevelRange)
%function GImage = LevelSlicing( RGB_Image, IR_Image, LevelRange )

%   Implement intensity level slicing on an RGB-image, with the range defined from an IR-image:
%   Slect a reference intensity value from the IR image
%   Compute the range of intensity levels of interest
%   Use the defined intensity range from the IR-image to mask out the corresponding areas in the RGB-image
%   the result is the double image GImage with maximum gray value one
%
%% Who has done it
%
% Authors: phiro138 Philip Robertsson 
% Same LiU-IDs/names, as in the Lisam submission
% You can work in groups of max 2 students
%
%% Syntax of the function
%
%   Input arguments:
%       RGB_Image: RGB color image of type uint8 or double
%       IR_Image: Infrared intensity image of type uint8, uint16 or double
%       LevelRange: The range of intensity levels to select (defined in % of total intensity range)
%   Output argument:
%       RGB_Range: RGB image of type double, displaying the selected intensity range
%       IR_Select: RGB image of type double, displaying the position of the
%       selected pixel in the IR-image

% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2023-11-07
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) Often you must do something else between the given commands in the
%       template
%
%% Image size and image class handling
%

RGB_Image = imread(RGB_Image); % Read the image file directly from the file directory
RGB_Image = im2double(RGB_Image); % Convert the read image into a double
% The RGB image is read before the number of rows, columns and channels are
% read as doings so before an image is read will result in all these values
% being 0.

[nr,nc,nch] = size(RGB_Image); % Number of rows, columns and channels in the image

IR_Image = imread(IR_Image); % Read the image file directly from the file directory
IR_Image = im2double(IR_Image); % Convert the read image into a double

%% Show the IR image to select a pixel with reference intensity value
%

fh1=figure; imshow(IR_Image);
set(fh1,'NumberTitle','off','Name','Select a pixel for reference intensity level')
[x,y] = ginput(1); % x and y are the coordinates of the reference pixel

x = round(x); 
y = round(y);
% Converts possible values with decimals into whole numbers to
% find the correct pixel in the IR image

% Note that x and y are not the same as row and column!
% Refer to the help-section for the function ginput for reference

%% Find the selected intensity range from the IR image
% Based on the coordinates of the selected pixel (expressed in x,y )
% find the selected intensity level. Then compute the selected intensity range,
% based on the vaiable LevelRange
Lower =  IR_Image(y,x) - LevelRange/2; % The lowest intensity value in the selected range
Higher = IR_Image(y,x) + LevelRange/2; % The highest intensity value in the selected range

%% Mask out the areas ine th RGB image, based on the selected intensity range in the IR image
% Compute a mask (binary image) from the IR image, which is ONE only where IR<Higher & IR>Lower

Mask = IR_Image < Higher & IR_Image > Lower; 
% Creates a mask where pixels with an intensity value between
% the highest and lowest allowed intensity values becomes white, and any
% pixel with an intensity value outside this range becomes black.

% Use the Mask to mask out the areas within ths selected IR-range in the RGB-images
% (for all 3 color channels)

RGB_Range = cat(3,RGB_Image(:,:,1) .* Mask,RGB_Image(:,:,2) .* Mask,RGB_Image(:,:,3) .* Mask);
%Multiplies the mask elementvise with each channel of the RGB image to
%create an RGB range

%% Show the selected pixel in the IR-image
% Crete an image that shows the position of the selected pixel in the IR-image, using a red mark.
% Marking just a sngle pixel is difficult to see in the image. Use at least a 5x5 pixel area
% if you use a square. You can also consider marking the pixel with a cross, or some other shape
%

IR_Select=cat(3,IR_Image,IR_Image,IR_Image);

% This create an RGB image. Since the color channels are identical, it will
% be displayed in grayscale.
% Now modify IR_select to mark the selected pixel in red!

IR_Select((y-1):(y+1),(x-8):(x+8),1) = 255; % Creates a red three pixel wide line with the height of 18 at the chosen pixel
IR_Select((y-8):(y+8),(x-1):(x+1),1) = 255;  % Creates a red 18 pixel wide line with the height of three at the chosen pixel
% This creates a red cross at the selected pixel on the IR image

%% Display the result
% The result is displayed. Use the following names and formats:
% RGB_Image - Input RGB image (3 channels)
% RGB_range - Output RGB image, displying the selected range (3 channels)
% IR_select - Output image showing the selected pixel position (3 channels)
% Mask - Binary image marking the selected intensity range in IR_Image (1 channel)

fh2=figure;
montageimage = zeros(nr,nc,nch,4);
montageimage(:,:,:,1) = RGB_Image;
montageimage(:,:,:,2) = RGB_Range;
montageimage(:,:,:,3) = IR_Select;
montageimage(:,:,:,4) = cat(3,Mask,Mask,Mask);
montage(montageimage)
set(fh2,'NumberTitle','off','Name','RGB / RGB: selected range/ IR: selected pixel / IR: mask')

end


