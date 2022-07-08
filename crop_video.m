function  crop_video(input_path,dest_path,x,x_width,y,y_height)
    %crop video manualy without DLC data
    vid1=VideoReader(input_path);
    n=vid1.NumFrames;
    writerObj1 = VideoWriter(dest_path);
    open(writerObj1);
    for i= 1:300
      im=read(vid1,i);
      %black
      %imc=imcrop(im,[650 700 400 400]);% The dimention of the new video
      imc=imcrop(im,[600 700 50 50]);% The dimention of the new video
      imc=rgb2gray(imc);
      %imshow(imc);
      writeVideo(writerObj1,imc);
    croped_precentage = (i/n)*100;
    croped_precentage
    end
        for i= 301:600
      im=read(vid1,i);
      %black
      %imc=imcrop(im,[650 700 400 400]);% The dimention of the new video
      imc=imcrop(im,[50 50 50 50]);% The dimention of the new video
      imc=rgb2gray(imc);
      %imshow(imc);
      writeVideo(writerObj1,imc);
    croped_precentage = (i/n)*100;
    croped_precentage
    end
    close(writerObj1)
end

