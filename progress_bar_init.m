function [items_width, progress_current, progress_width] =  progress_bar_init(iw, pc, pw)
items_width = iw;
progress_current = pc;
progress_width = pw;

fprintf('PROGRESS '); fprintf('['); fprintf(repmat(sprintf(' '), 1, progress_width)); fprintf(']');
