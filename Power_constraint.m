function P_row = Power_constraint(X,Pxv,d)
    P_row = sum((X.*d).^2.*Pxv);
end