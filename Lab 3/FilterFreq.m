function [olp, ohp]=FilterFreq(f, D0)
%
% function [olp, ohp]=FilterFreq(f, D0)
%
%% Lab3, Task 2
%
%% Performs filtering in the frequency domain
%
% Lowpass and highpass filters the image in the frequency domain by
% a Gaussian filter constructed in the frequency domain
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
%           f: the original input grayscale image of type double scaled
%               between 0 and 1
%           D0: The cutoff frequency of the Gaussian lowpass filter
%
%      Output arguments:
%           olp: the result after lowpass filtering the input image by
%                the Gaussian lowpass filter
%           ohp: the result after highpass filtering the input image by
%                the Gaussian highpass filter
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2023-11-28
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
%% zero pad the input image
% The input image is zero padded to an image of size P x Q, where P = 2M and
% Q = 2N (M x N is the size of the input image). Notice that the input
% image has to be placed at the top-left corner of the zero-padded image

[P,Q] = size(f); % Size returns two values, length and width

fp= padarray(f,[P,Q],0,"post"); % the zero padded image
    
%% construct the Gaussian lowpass filter transfer function
% If you want, you can write a separate function to construct the Gaussian filter.
% If you do so, don't forget to submit that MATLAB function as well.
%
% The transfer function is supposed to be the same size as the padded image
% that is P x Q
% The cutoff frequency of this filter, D0, is the second input argument of
% this MATLAB function

[X,Y] = meshgrid(0:2*P-1,0:2*Q- 1);
X=X';
Y = Y';
D=sqrt((X-P).^2+(Y-Q).^2); %From slide 108 in Lecture 5 and 6.

GLPF= exp(-(D.^2)./(2.*D0.^2)); % the Gaussian lowpass filter transfer function
    
%% Perform filtering in the frequency domain
% Find the product between the filter transfer function and the Fourier
% transform of the padded image (Notice that the zero frequency is supposed
% to be shifted to the center of the Fourier transform)

F = fftshift(fft2(fp));
OLP= GLPF.*F; % The Fourier transform of the lowpass filtered image
    
%% Find the padded lowpass filtered image
% The zero frequency of OLP should be shifted back to the top left corner of the
% image followed by the inverse Fourier transform. Take the real part of
% the result.

olpf= real(ifft2((ifftshift(OLP))));% The padded lowpass filtered image of size P x Q
    
%% Find the lowpass filtered image
% Extract the final lowpass filtered image from the padded lowpass filtered
% image

olp= olpf(1:P,1:Q);% The final lowpass filtered image
    
%% Find the final highpass filtered image
% Read the document for this task

ohp= f - olp; % The final highpass filtered image
    
%% Test your code
%
% Test your code on different images (for example Einstein1.jpg,
% Einstein2.jpg or characterTestPattern.tif) using different cutoff
% frequencies and look at the result of lowpass filtering and highpass
% filtering the original image. Ask yourself, what happens if you increase
% the cutoff frequency (the second input argument of your function). Will the
% result be blurrier or less blurry? Test it and see whether or not you are
% correct. Hopefully, you are not surprised by the result, if you are,
% discuss it with your classmates or the teachers.
