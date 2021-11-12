function image1 = readBOSimage(path)
% read images from folder and calculate average
if nargin == 0
    path = 'BOS\Set0_Photos';
end
folder = uigetdir(path);
files = dir(fullfile(folder, '*.bmp'));
image = double(zeros(size(imread(fullfile(folder, files(1).name)))));
for i = 1:numel(files)
    image = image + im2double(imread(fullfile(folder, files(i).name)));
end
image1 = image./numel(files);



%Keep only the first channel
%image1 = image1(:,:,1);

end