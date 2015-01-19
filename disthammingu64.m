function [ sum ] = disthammingu64( x,y )

z = bitxor(x, y);
sum=0;
for i=1:64
    sum = sum + bitget(z,i);
end
