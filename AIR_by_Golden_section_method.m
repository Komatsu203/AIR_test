clear all
tic
SNR_List = [0:2:30];
for SNR_index = 1:numel(SNR_List)
    %�?10)に相当する演�?
    %�?���?��探索法を利用し�?信容量Cを最大化す�?
    %% 以下�?�?���?��探索�?
    SNR = 10^(SNR_List(SNR_index)/10);
    phi = (1 + sqrt(5)) / 2;
    d0 = 0;
    d3 = 1;
    d1 = (d0 * phi + d3) / (1 + phi);
    d2 = (d0 + d3 * phi) / (1 + phi);
    e = 1e-6;
    while d0 + e < d3
        [v1, P_row1, Pxd1] = bisection_method(d1);
        C1 = MI(d1,Pxd1,SNR);
        [v2, P_row2, Pxd2] = bisection_method(d2);
        C2 = MI(d2,Pxd2,SNR);
    
        if C1 < C2
            d0 = d1;
            d1 = d2;
            d2 = (d0 + d3 * phi) / (1 + phi);
        else
            d3 = d2;
            d2 = d1;
            d1 = (d0 * phi + d3) / (1 + phi);
        end
    end
    d = d0;
    [v, P_row, Pxd] = bisection_method(d);
    C = MI(d,Pxd,SNR);
    
    Ha = 0;
    for i = 1:4
        Ha = Ha - Pxd(i + 4) * 2 * log2(Pxd(i + 4) * 2);
    end
    
    C_List(SNR_index) = C; Ha_List(SNR_index) = Ha; v_List(SNR_index) = v; Pxd_List(:,SNR_index) = [Pxd];
end

SNR_List = SNR_List.'; C_List = C_List.'; Ha_List = Ha_List.'; v_List = v_List.'; Pxd_List = Pxd_List.';
DATA = [SNR_List, C_List, Ha_List, v_List, Pxd_List];
toc