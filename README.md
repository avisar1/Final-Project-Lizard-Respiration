# Final-Project-Lizard-Respiration

Lizard Breathing Monitor Manual:

1) Run install.m and then make.m. Without this step EVM option won't work.
2) Set the parameters in main.m file:

video_path - Lizards video path.
generate_crop:\n \n \n \n  
  1 - The program will generate automaticly cropped video in "cropped_video_path" according to "video_path" .
  0 - There is already cropped video in "cropped_video_path".
  If generate_crop is turned off make sure there is a video in "cropped_video_path"!
skip_evm:
  1 - The program will apply EVM amplification.
  0 - The program will run without EVM amplification.
  It is highly recommended not to skip EVM amplification because it can increase the error rate.
window_length_in_seconds - set between 10 to 30 (seconds).
cropped_video_path - path for the generating of the cropped video.
DLCcsvfile_path - path of the csv file of the analyzed video (output of the DLC trained model, bodyparts locations).

3) Run the main.m 
4) Get your RR results :) 
There will be two graphs. The first one for the breathing pattern and the second one for RR. 
If the lizard is not detected for a couple of frames it will result 0 in both graphs until the next detection.

