function [ output ] = blerp( pos, values )
% Bilinear Interpolation
output = lerp(pos(1), [lerp( pos(2), values(1, :)), lerp( pos(2), values(2, :))]);



