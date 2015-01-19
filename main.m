function [ ] = main(imgs, file_prefix, num)

for i = 1 : num
    imwrite(imgs{i}, strcat(file_prefix, num2str(i), '.bmp'));
end