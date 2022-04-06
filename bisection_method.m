function [vm, P_row, Pxd] = bisection_method(d)
    %式(9)に相当する演算(bisection method:二分法)
    P_set = 1;
    %二分法の試行回数
    n = 100;
    X = [-7, -5, -3, -1, 1, 3, 5, 7];
    %二分法の初期値
    v1 = 0;
    v2 = 1;
    for i = 1:n
        vm = (v1 + v2) / 2;
        if sign(P_set - Power_constraint(X,MB_distribution(v1,X),d)) == sign(P_set - Power_constraint(X,MB_distribution(vm,X),d))
            v1 = vm;
        else
            v2 = vm;
        end
    end
    P_row = Power_constraint(X,MB_distribution(vm,X),d);
    Pxd = MB_distribution(vm,X);
end