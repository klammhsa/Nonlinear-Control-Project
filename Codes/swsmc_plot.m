clc; clear; close all;

opts = odeset('RelTol', 1e-3);

[t, x] = ode45(@vgsmc, [0, 10], [0.5, 0.3, 0.8], opts);

s1 = x(:, 3);  
s2 = 2 * x(:, 2);  
e = 1; 
M = diag([1, 2]); 

c = s1.^2 + 2 * s2.^2;

U = zeros(size(t));
h = zeros(size(t));

for i = 1:length(t)
    if c(i) <= 0.3
        U(i) = 2;  
    elseif c(i) <= 0.7
        U(i) = 3;  
    else
        U(i) = 5;  
    end
    
    v = rand(1) - rand(1);  
    h(i) = v * (1 + sin(t(i)) + abs(x(i, 3) + 4 * x(i, 2)^2));
end

u = -2 * (2 * x(:, 1) .* x(:, 2) + sin(x(:, 2))) - U .* sign(s1 + s2 .* abs(s2) / (2 * e));

figure(1)
subplot(221)
plot(t, x(:, 1), '-', 'LineWidth', 1.2); hold on;
plot(t, x(:, 2), '--', 'LineWidth', 1.2);
plot(t, x(:, 3), '-.', 'LineWidth', 1.2);
xlabel('Time [s]'); ylabel('x(t)');
legend('x_1', 'x_2', 'x_3'); 
grid on;

subplot(222)
plot(t, u, 'LineWidth', 1.2);
xlabel('Time [s]'); ylabel('u(t)'); 
grid on;

subplot(223)
plot(s1, s2, 'b', 'LineWidth', 1.2); 
hold on;

X = [-1 -1 1 1 -1]; Y = [-1 1 1 -1 -1]; 
plot(X, Y, 'k', 'LineWidth', 4);
xlabel('\sigma_1'); ylabel('\sigma_2'); 
grid on;

subplot(224)
plot (t, 1+x(:,1)-exp (2*x(:,2)))
xlabel('Time [s]'); ylabel('\zeta(t)'); 
grid on;

% figure(2)
% plot(t, h, 'k', 'LineWidth', 1.2);
% xlabel('Time [s]'); ylabel('h(x,t)'); grid on;