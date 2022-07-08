function [frame_size_x,frame_size_y] = get_frame_size(video_path)
    vidObj = VideoReader(video_path);
    frame_size_x = vidObj.Width;
    frame_size_y = vidObj.Height;
end

