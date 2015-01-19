function [cost] = ca_cross(initial_cost, img, ucd, lcd, usd, lsd)

fprintf('===============================\n');
fprintf('=== COST AGGRAGATION: CROSS ===\n');
fprintf('===============================\n');

fprintf('=== Cross Construction ===\n');
cross_map = ca_init_cross(img, ucd, lcd, usd, lsd);

fprintf('=== Aggragation Iteration 1 ===\n');
cost = ca_cross_hv(initial_cost, cross_map);
fprintf('=== Aggragation Iteration 2 ===\n');
cost = ca_cross_vh(cost, cross_map);
fprintf('=== Aggragation Iteration 3 ===\n');
cost = ca_cross_hv(cost, cross_map);
fprintf('=== Aggragation Iteration 4 ===\n');
cost = ca_cross_vh(cost, cross_map);