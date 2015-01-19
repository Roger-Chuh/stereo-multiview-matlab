function output = f_bilateral(input)

[rows, cols, dims] = size(input);

fprintf('=== Bilateral Filter ===\n');
output = zeros(rows, cols, 'uint8');
fprintf('CONSISTENCY CHECK ');
[iw, pc, pw] = progress_bar_init(rows, 0, 30);
for y = 1 : rows
    for x = 1 : cols
    
    end
    progress_bar(y, iw, pc, pw);
end
