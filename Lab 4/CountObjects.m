function [IMG, noRice, noSmallMacs, noLargeMacs]=CountObjects(in)
%% Lab4, Task 3
%% Finds the number of rows of bricks
%
% Counts objects of different class and displays them in different colors. 
% Input images containing three classes of ojects: grains of rice, snall
% macaronis and large macaronis
%
%% Who has done it
%
% Author: Philip Robertsson, phiro138
% Same LiU-ID and name as in the Lisam submission
% Co-author: You can work in groups of max 2, this is the LiU-ID/name of
% the other member of the group
%
%% Syntax of the function
%      Input arguments:
%           in: the original input RGB color image of type double scaled between 0 and 1
%          
%      Output arguments:
%           IMG: the output RGB color image, displaying the three
%           diffferent classes of objects in different colors
%           noRice: Number of grains of rice in the input image
%           noSmallMacs: Number of small macaromis in the input image
%           noLargeMacs: Number of large macaromis in the input image
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2023-12-11
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
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%

%% Make the input color image grayscale, 
% by choosing its most appropriate channel 

bgray =in(:,:,3); % The grayscale version of the input color image
%Using the blue chanel given that the rice and macaronis are yellow which
%is a combination of red and green. This makes the obejects almost black.
    
%% Threshold your image
% to separate the objects from the backgroound
T = graythresh(bgray); %utilizing Otsu's algorithm

b_thresh = T>bgray; % The thresholded image
%The objects will become white and the background will become black    

%% Clean up the binary image 
% Use morphological operations to clean up the binary image from noise. 
% Especially make syre that your cleaned image don't contain any false object
% (i.e. single foreground pixels, or groups of connected foreground pixels, 
% that do not belong to the object classes  
SE1 = strel("disk", 4); % Sufficient SE to remove noise

b_clean =imopen(b_thresh,SE1); %Open with SE1 to remove noise
b_clean = imclose(b_clean,SE1); % Close with the same SE to return to original size
% Cleaned up binary image

%% Labelling
%  Use labelling to assign every object a unique number

L =bwlabel(b_clean); % Labelled image

%% Object features
% Compute relevant object features that you can use to classify 
% the three classes of objects

Stats = regionprops(logical(L),'Perimeter'); % Create struct with relevant object properties
for n=1:length(Stats)
    Perimeter(n) = Stats(n).Perimeter; % Create a vector storing the perimeters of all objects
end

%% Object classification
% Based on your object features, classify the objects, i.e. for each
% labelled object: decide if it belongs to the three classes: Rice, SmallMacs, or LargeMacs 
% In case you didn't suceed in cleaining up all false objects, you should
% discard them here, so they don't count as the classes of objects
threshRice = 200;
threshSmall = 300;
% Values found from studying perimeter histogram

Rice = find(Perimeter<threshRice);% Vector containing the labels of all objects classifies as rice
SmallMacs = find(threshRice<Perimeter&Perimeter<threshSmall); % Vector containing the labels of all objects classifies as SmallMacs
LargeMacs = find(threshSmall<Perimeter);% Vector containing the labels of all objects classifies as LargeMacs

%% Count the objects for each class.

noRice = numel(Rice); % Number of rices
noSmallMacs = numel(SmallMacs); % Number of small macoronis
noLargeMacs = numel(LargeMacs);% Number of large macoronis

%% Create an RGB-image, IMG, displaying the different classes of objects in different colors
% Use for example: Colored objects on black background, colored objects on
% the original background, highlight the borders of the objects in the
% original image in different colors (or some other way of displayig the
% objects)

Rice_Im = zeros(size(bgray)); % Create Rice image
for n=1:length(Rice)
    Rice_Im(L==Rice(n))=1; % Seperate only the rice
end

SmallMacs_Im = zeros(size(bgray)); % Create Small Macs image
for n=1:length(SmallMacs)
    SmallMacs_Im(L==SmallMacs(n))=1; % Seperate only the small macs
end

LargeMacs_Im = zeros(size(bgray)); % Create Large Macs image
for n=1:length(LargeMacs)
    LargeMacs_Im(L==LargeMacs(n))=1; % Seperate only the large macs
end

IMG = in; % Copy the colored input image to the output
IMG(:,:,1) = Rice_Im+in(:,:,1); % The rice image is added to the red channel of the input image
IMG(:,:,2) = SmallMacs_Im+in(:,:,2); % The small macs image is added to the green channel of the input image
IMG(:,:,3) = LargeMacs_Im+in(:,:,3); % The large macs image is added to the blue channel of the input image
% Output RGB-image displaying the three classes of objects in different colors

%% Test your code on the three test images
% % Your code is supposed to work for the three images:
%
% Image          noRice   noSmallMacs   noLargeMacs
% MacnRice1.tif  48       12            6
% MacnRice2.tif  60       14            6
% MacnRice3.tif  42       11            5



