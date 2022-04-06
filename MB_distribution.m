function Pxv = MB_distribution(v,X)
    Av = 1/sum(exp(-v * X.^2));
    Pxv = Av * exp(-v * X.^2);
end
