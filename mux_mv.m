function [ output ] = mux_mv( views, n_views, angle, out_width, out_height )

out_dim = [out_height, out_width];

fprintf('=== Multiplex - Multiple Views to Sub-pixel Interlaced ===\n');

%% Scale to Output Dimensions Routine
scaled_views = {};
for v = 1 : n_views
    scaled_views{v} = zeros(out_height, out_width, 3);
end
fprintf('SCALE TO OUTPUT DIM. ');
[iw, pc, pw] = progress_bar_init(n_views, 0, 30);
for v = 1 : n_views
    scaled_views{v} = imresize(views{v}, out_dim, 'bicubic');
    progress_bar(v, iw, pc, pw);
end

%% Flatten Color Components Routine
d1_views = {};
for v = 1 : n_views
    d1_views{v} = zeros(out_height, out_width * 3);
end
fprintf('FLATTEN COLOR STRUCTURE ');
[iw, pc, pw] = progress_bar_init(n_views, 0, 30);
for v = 1 : n_views
    d1_views{v}(:, 1:3:end) = scaled_views{v}(:,:,1);
    d1_views{v}(:, 2:3:end) = scaled_views{v}(:,:,2);
    d1_views{v}(:, 3:3:end) = scaled_views{v}(:,:,3);
    progress_bar(v, iw, pc, pw);
end

%% Generate Interlace Masks Routine
mux_masks = {};
for v = 1 : n_views
    mux_masks{v} = zeros(out_height, out_width * 3);
end
x_interval = n_views;
y_interval = round(n_views / tan(angle * pi / 180.0) / 3);
fprintf('GENERATE MASKS ');
[iw, pc, pw] = progress_bar_init(n_views, 0, 30);
if (y_interval > 0)
    for v = 1 : n_views
        for y = 1 : out_height
            x_off = mod(y, y_interval) + 1;
            x_off = round(x_off * x_interval / y_interval) + v - 1;
            mux_masks{v}(y, floor(x_off):n_views:end) = 1;
        end
        progress_bar(v, iw, pc, pw);
    end
else
    y_interval = -y_interval;
    for v = 1 : n_views
        for y = out_height : -1 : 1
            x_off = mod(-y, y_interval) + 1;
            x_off = round(x_off * x_interval / y_interval) + v - 1;
            mux_masks{v}(y, floor(x_off):n_views:end) = 1;
        end
        progress_bar(v, iw, pc, pw);
    end
end

%% Apply Masks to Color
fprintf('GENERATE MASKS ');
[iw, pc, pw] = progress_bar_init(n_views, 0, 30);
for v = 1 : n_views
    d1_views{v} = mux_masks{v} .* d1_views{v};
    progress_bar(v, iw, pc, pw);
end

%% Reconstruct Color Structure
combined_views = zeros(out_height, out_width * 3);
fprintf('COMBINE VIEWS ');
[iw, pc, pw] = progress_bar_init(n_views, 0, 30);
for v = 1 : n_views
    combined_views = d1_views{v} + combined_views;
    progress_bar(v, iw, pc, pw);
end

output = zeros(out_height, out_width, 3);
fprintf('RECONSTRUCT COLOR STRUCTURE ');
[iw, pc, pw] = progress_bar_init(1, 0, 30);
output(:,:,1) = combined_views(:,1:3:end);
output(:,:,2) = combined_views(:,2:3:end);
output(:,:,3) = combined_views(:,3:3:end);
progress_bar(1, iw, pc, pw);



