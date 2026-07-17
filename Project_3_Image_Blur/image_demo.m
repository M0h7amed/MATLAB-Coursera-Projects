%% CLEAN WORKSPACE AND COMMAND WINDOW
clc;
clearvars;
close all;
%--------------------------------------
img = imread('vandy.png');
output = blur(img,10);
imshow(output);