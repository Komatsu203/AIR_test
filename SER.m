function ser = SER(y,x,sigma)
    ser = exp(-(y - x)^2 / (2 * sigma)) / sqrt(2 * pi * sigma);
end