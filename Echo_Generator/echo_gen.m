function oP=echo_gen(y, fs, delay, amp)
%% ECHO GENERATION FUNCTION 
% (y) sound data 
% (fs) sampling rate : number of rows in 1 second
% (delay) : delay time needed

r=round(delay*fs);
d=zeros(r,1); 

% Pad vectors to align signals in time
p_y = [y; d];
p_echo = [d; y * amp];

echo=p_y+p_echo; 

% Peak amplitude checking & normalization
m=max(abs(echo));
if m>1
  oP=(echo)/m;
else
  oP= echo ;
end