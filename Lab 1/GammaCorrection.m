function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )
%function GImage = GammaCorrection( OImage, Gamma, Lower, Upper )

%   Implement gamma correction:
%   Truncate the original gray values using lower and upper quantiles
%   (Lower, Upper) and then apply gamma correction with exponent Gamma 
%   to the input image OImage,
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
%       OImage: Grayscale image of type uint8 or double
%       Gamma: exponent used in the gamma correction, 
%       Lower: value in the range 0, 1
%       Upper: value in the range 0, 1 and lower < upper
%       Lower and Upper are quantile values. 
%   Output argument: GImage: gamma corrected gray value image of type double
%
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
%% Image class handling
% Make sure that you can handle input images of class uint8, uint16 and double 

Image = imread(OImage); % Read the image file directly from the file directory
Image = im2double(Image); % Convert the read image into a double

%% Compute lower and upper gray value boundaries. 
% Use the parameteers Lower and Upper to find the corresponding gray values
% for the boundaries
% Look at the help function for the command quantile
%
lowgv = quantile(Image(:),Lower); % Lower-bound gray value
uppgv = quantile(Image(:),Upper); % Upper-bound gray value

%% Compute a scaled version GImage of the image, where: 
% the lower-bound gray value is zero 
% the upper-bound gray value is one 
% because 0^Gamma = 0 and 1^Gamma = 1
%

GImage = imadjust(Image,[lowgv, uppgv]); %Adjust the image so it's in the range of [0,1]

%% Gamma mapping of the previous result 
% Make sure that your image is in the range [0,1] before applying gamma
% correction!
%
GImage = GImage.^Gamma;... % apply gamma correction (which is an elementwise operation)
% Opperation done according to the equation s=c*r^gamma, where c was chosen
% as 1 given that the image is in double form


end

%% Experiments with your code
%
% Use your code to modify the images 'aerialview-washedout.tif' and
% 'spillway-dark.tif' for different values for Gamma, Lower and Upper
% Write some comments on your experiments and propose some good parameters
% to use (don't forget to comment your text so that the code will work)
% 
% 'spillway-dark.tif':
%   To lighten up the image gamma was chosen to 0.50 which reveals much of
%   the detail in the image. Moreover the boundieries was shortended to
%   [0.02, 0.80] to lower the strong contrasts in the waves.
%
%
%
% 'aerialview-washedout.tif'
%  To make the roads and airport have well defined lines a higher value of
%  gamma (2.5) was chosen and the bounderies was set to [0.01, 0.98]. The
%  sky however became a bit grainy but the detail of the airport and city
%  was deemed more important.
%
%
%
% The image ?IntensityRampGamma25.tif? illustrates the effect of an intensity
% ramp displayed on a monitor with gamma =2.5. 
% Which value for gamma should you use in your code to correct the image to appear as a linear intensity ramp?
% (Set Lower=0 and Upper=1)
% Gamma = 0.4, which is calculated with 1/2.5 = 0.4




