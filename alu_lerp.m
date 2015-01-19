function [ output ] = lerp( pos, values )
% Linear Interpolation
weights = zeros(1,2);
weights(2) = pos - floor(pos);
weights(1) = 1.0 - weights(2);
output = values(1) * weights(1) + values(2) * weights(2);