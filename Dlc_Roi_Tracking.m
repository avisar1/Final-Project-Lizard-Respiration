function [Roi_Frame_Num, Roi_Rect, Valid_Frames_For_RR] = Dlc_Roi_Tracking(input_path, dest_path, DLCcsvfile_path, frame_size_x, frame_size_y)
%Dlc_Roi_Tracking function gets path of DLC_csv coordinates file
%returns an array of the frames number the lizard moves with the new ROI

%TODO - add frame boundries to the function and check that the ROI
%rectangle x does't goes out of boundries from the frame. if it does - change
%the rectangle to fit the boundries.

%parsing the file according to selected bodyparts

    dist_margine = 10; %sets the radius of the point that allowed the lizard to move withput change ROI 
    Roi_Size_Factor = 1.7;%enlarge the ROI to avoid offsets
    Num_Of_Min_Frames_Per_Roi = 10;
    [num,txt,raw] = xlsread(DLCcsvfile_path);
    Valid_Frames_For_RR = ones(1, length(num(:,1)));

    
    bodyparts_raw = strcmpi(txt(:,:), 'bodyparts');
    head_x_y_likelihood = strcmpi(txt(bodyparts_raw,:), 'head');
    nose_x_y_likelihood = strcmpi(txt(bodyparts_raw,:), 'nose');
    right_shoulder_x_y_likelihood =  strcmpi(txt(bodyparts_raw,:), 'right_shoulder');
    left_shoulder_x_y_likelihood = strcmpi(txt(bodyparts_raw,:), 'left_shoulder');
    right_armpit_x_y_likelihood =  strcmpi(txt(bodyparts_raw,:), 'right_armpit');
    left_armpit_x_y_likelihood = strcmpi(txt(bodyparts_raw,:), 'left_armpit');
    tailbase_x_y_likelihood = strcmpi(txt(bodyparts_raw,:), 'tailbase');
    %idx = idx + strcmpi(txt(:,:), 'x') + strcmpi(txt(:,:), 'y');
    
    %Roi_Rect_array[frame_num, x, y, width, hight] - [x, y] = coordinates of the mose upper and lefty point 
    Roi_Rect = zeros(length(num(:,1)) ,4);
    Roi_Frame_Num = zeros(1, length(num(:,1)));
    Roi_Valid_Rects = [];
    counter = 1;

    for i = 1:length(num(:,1))
        right_shoulder_i_x_y_likelihood = num(i,right_shoulder_x_y_likelihood);
        left_shoulder_i_x_y_likelihood = num(i,left_shoulder_x_y_likelihood);
        right_armpit_i_x_y_likelihood = num(i,right_armpit_x_y_likelihood);
        left_armpit_i_x_y_likelihood = num(i,left_armpit_x_y_likelihood);
        %tailbase_i_x_y_likelihood = num(i,tailbase_x_y_likelihood);
        
        %TODO - check if to add an option to take on consideration the
        %likelihood of the coordinates - valid or not

        %calculate the [x, y] coordinate - the mose upper anf left point
        %this point can be either one of the bodyparts, or if the lizard
        %angle not aligned with the frame - the mose upper y coordination
        %and the most lefty x coordination
%         if (left_shoulder_i_x_y_likelihood(1) < right_armpit_i_x_y_likelihood(1))
%             if (left_shoulder_i_x_y_likelihood(2) <= right_armpit_i_x_y_likelihood(2))
%                 if (left_armipit_i_x_y_likelihood(2) < left_shoulder_i_x_y_likelihood(2))
%                     %meaning the lizard's head facing down
% 
% 
%                 end
%             end
%         end
        
        %the mose upper y coordination and the most lefty x coordination
        rect_x_i = min([left_shoulder_i_x_y_likelihood(1), left_armpit_i_x_y_likelihood(1), right_shoulder_i_x_y_likelihood(1), right_armpit_i_x_y_likelihood(1)]);
        rect_y_i = min([left_shoulder_i_x_y_likelihood(2), left_armpit_i_x_y_likelihood(2), right_shoulder_i_x_y_likelihood(2), right_armpit_i_x_y_likelihood(2)]);
        
        if (i == 1)
            width_line = [left_shoulder_i_x_y_likelihood(1),left_shoulder_i_x_y_likelihood(2);right_shoulder_i_x_y_likelihood(1),right_shoulder_i_x_y_likelihood(2)];
            hight_line = [left_armpit_i_x_y_likelihood(1),left_armpit_i_x_y_likelihood(2);right_armpit_i_x_y_likelihood(1),right_armpit_i_x_y_likelihood(2)];
    
            width_i = pdist(width_line,'euclidean');
            hight_i = pdist(hight_line,'euclidean');
            width_i = floor(width_i * Roi_Size_Factor);
            hight_i = floor(hight_i * Roi_Size_Factor);
            width_init = width_i;
            hight_init = width_init;
        end

        %TODO - consider taking the width for hight as well since the
        %lizard can be 90 degrees rotated, and the width 10 timed larger
        %then the hight - we'll get a square 
        rect_x_i = floor(rect_x_i-50);
        rect_y_i = floor(rect_y_i-100);
        if (rect_x_i < 0 || rect_y_i < 0 || rect_x_i+width_init > frame_size_x || rect_y_i+hight_init > frame_size_y)
            %do nothing
        elseif (i ~= 1)
            prev_valid_rect = Roi_Valid_Rects(end - 3 : end);
            prev_to_curr_line = [prev_valid_rect(1),prev_valid_rect(2);rect_x_i,rect_y_i];
            dist = floor(pdist(prev_to_curr_line,'euclidean'));
            if (dist < dist_margine)
                %meeaning the lizard didnt realy moved - the ROI stays thE
                %same
            else
                Roi_Rect(i, :) = [rect_x_i rect_y_i width_init width_init];
                Roi_Frame_Num(counter) = i;
                counter = counter + 1;%counting the num of changes in ROI
                Roi_Valid_Rects = [Roi_Valid_Rects, [Roi_Rect(i, :)]];
            end

        else
            Roi_Rect(i, :) = [floor(rect_x_i) floor(rect_y_i) floor(width_init) floor(width_init)];
            Roi_Frame_Num(counter) = i;
            counter = counter + 1;%counting the num of changes in ROI
            Roi_Valid_Rects = [Roi_Valid_Rects, [Roi_Rect(i, :)]];
        end
    end
    counter = counter - 1;
    Roi_Frame_Num = Roi_Frame_Num(1:counter);
    Roi_Final_Valid_Rects = zeros(length(Roi_Valid_Rects)/4, 4);
    for i=1:length(Roi_Final_Valid_Rects)
        if (i == 1)
            Roi_Final_Valid_Rects(i,1) = Roi_Valid_Rects(i);
            Roi_Final_Valid_Rects(i,2) = Roi_Valid_Rects(i+1);
            Roi_Final_Valid_Rects(i,3) = Roi_Valid_Rects(i+2);
            Roi_Final_Valid_Rects(i,4) = Roi_Valid_Rects(i+3);
        else
            Roi_Final_Valid_Rects(i,1) = Roi_Valid_Rects(i*4-3);
            Roi_Final_Valid_Rects(i,2) = Roi_Valid_Rects(i*4-2);
            Roi_Final_Valid_Rects(i,3) = Roi_Valid_Rects(i*4-1);
            Roi_Final_Valid_Rects(i,4) = Roi_Valid_Rects(i*4);
        end

    end
    
    j = 2;
    i = 530;
    while i <= length(num(:,1))
        if i == Roi_Frame_Num(j) && j < counter
            while i < Roi_Frame_Num(j+1)
                if ((Roi_Frame_Num(j+1) - Roi_Frame_Num(j)) < Num_Of_Min_Frames_Per_Roi)%meaning the Roi changes quickly
                    Valid_Frames_For_RR(i) = 0;
                end
                i = i + 1;
            end
            j = j + 1;
        else
            i = i + 1;
        end
    end
    
    vid1=VideoReader(input_path);
    n=vid1.NumFrames;
    writerObj1 = VideoWriter(dest_path);
    open(writerObj1);
    j = 1;
    for i= 1:n
      im=read(vid1,i);
      %imshow(im);
      %black
      %imc=imcrop(im,[650 700 400 400]);% The dimention of the new video
      if (j <= counter)   
          if (i == Roi_Frame_Num(j))
              if (Roi_Final_Valid_Rects(j, 3) ~= 0 && Roi_Final_Valid_Rects(j, 4) ~= 0)
                  crop = Roi_Final_Valid_Rects(j, :);
              else 
                  fprintf("not valid ROI");
              end
              j = j + 1;
          end
      end
      imc=imcrop(im,crop);% The dimention of the new video
      imc=rgb2gray(imc);
      %imshow(imc);
      %size(imc)
      writeVideo(writerObj1,imc);
      %imc.
      %writeVideo(writerObj1,imc);
    %croped_precentage = (i/n)*100;
    %croped_precentage
    end
    close(writerObj1)

end

