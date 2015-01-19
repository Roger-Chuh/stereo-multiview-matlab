function [ progress_next ] = progress_bar(items_current, items_width, progress_current, progress_width)

progress_next = round((double(items_current) / double(items_width)) * double(progress_width));
if  progress_next > progress_current
    progress_current = progress_next;
    fprintf(repmat(sprintf('\b'), 1, progress_width + 2));
    fprintf('[');
    for bar = 1 : progress_width
        if bar <= progress_current
            fprintf('.');
        else
            fprintf(' ');
        end
    end
    fprintf(']');
end
if items_current >= items_width
    fprintf(' DONE!\n');
end