%videoName = 'girl';
output_videoName = 'Human6KCF';
outputVideo = VideoWriter(['D:\Mukul Ranjan\mukul\Context-based-Occlusion-Detection-Tracking-master\videobb\human6\',output_videoName]);
outputVideo.FrameRate = 25;
open(outputVideo)
%%
% resultPath = 'siameseResultsV5\';
% resultPath = 'siameseResults_no_rtn\';
videoPath = 'D:\Mukul Ranjan\mukul\Context-based-Occlusion-Detection-Tracking-master\videobb\';
imgDir = dir([videoPath,'*.png']);
images = sort({imgDir.name});
%for ii = 43:numel(images)
  for ii = 1:792
   %baseFileName = sprintf('%d.png', f); % e.g. "1.png"
   %fullFileName = fullfile(Resultados, baseFileName);
   imgPath = [videoPath,num2str(ii),'.png'];
   img = imread(imgPath);
   img=imresize(img,[400,500]);
   writeVideo(outputVideo,img)
 end

close(outputVideo)
%D:\Mukul Ranjan\mukul\Context-based-Occlusion-Detection-Tracking-master\videobb