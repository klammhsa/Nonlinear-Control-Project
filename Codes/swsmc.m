function dx = swsmc(t, x)
    s1 = x(3);
    s2 = 2 * x(2);
    e = 1;
    M = diag([1, 2]);

    sigma = [s1; s2];
    c = sigma' * M * sigma;  

    if c <= 0.3
        U = 2;  
    elseif c <= 0.7
        U = 3;  
    else
        U = 5;  
    end

    u = -2 * (2 * x(1) * x(2) + sin(x(2))) - U * sign(s1 + s2 * abs(s2) / (2 * e));
    v = rand(1) - rand(1);
    d = v * (1 + sin(t) + abs(x(3) + 4 * x(2)^2));
    a = [-x(1) + exp(2 * x(2)) * d;
         2 * x(1) * x(2) + sin(x(2)) + 0.5 * d;
         2 * x(2)];
    b = [exp(2 * x(2)); 0.5; 0];
    dx = a + b * u;
