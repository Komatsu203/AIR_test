function C = MI(d,Pxd,SNR)
    X = [-7, -5, -3, -1, 1, 3, 5, 7];
    dX = X .* d;
    sigma = 1/SNR;
    Hx = -sum(Pxd .* log2(Pxd));
    
    %以下、数値積分
    y_max = 30;
    y_min = -30;
    dy = 0.01;
    Hxy = 0;

    for i = 1:numel(Pxd)
        y = y_min;
        while y ~= y_max
            A = 0;
            for j = 1:numel(Pxd)
                A = A + SER(y, dX(j),sigma) * Pxd(j);
            end
            if isnan(dy * Pxd(i) * SER(y, dX(i), sigma) * log2(A / (SER(y, dX(i), sigma) * Pxd(i)))) == 0
                Hxy = Hxy + dy * Pxd(i) * SER(y, dX(i), sigma) * log2(A / (SER(y, dX(i), sigma) * Pxd(i)));
            else
                Hxy = Hxy + 0;
            end
            y = round(y + dy, 3);
        end
    end
    %通信容量
    C = Hx - Hxy;
end

