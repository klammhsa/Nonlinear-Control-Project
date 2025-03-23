clc; clear all;

opts = odeset('RelTol', 1e-3);

[t, x] = ode45(@hosmc, [0, 10], [0.5 0.3 0.8], opts);

s1 = x(:, 3);  
s2 = 2 * x(:, 2);  

e = 1;
U = 5;
u = -2 * (2 * x(:, 1) .* x(:, 2) + sin(x(:, 2))) - U .* sign(s1 + s2 .* abs(s2) / (2 * e));

h = t;
for i = 1:length(t)
    v = rand(1) - rand(1);
    h(i) = v * (1 + sin(t(i)) + abs(x(i, 3) + 4 * x(i, 2)^2));
end

figure(1)
subplot(221)
plot(t, x(:,1), '-', t, x(:,2), '--', t, x(:,3), '-.')
legend('x_1', 'x_2', 'x_3')
xlabel('time [s]'); ylabel('x(t)');
grid on

subplot(222)
plot(t, u)
xlabel('time [s]'); ylabel('u(t)');
grid on

subplot(223)
plot(s1, s2, 'b')
hold on

X = [-1 -1 1 1 -1]; 
Y = [-1 1 1 -1 -1]; 
plot(X, Y, 'k', 'LineWidth', 4)
xlabel('\sigma_1'); ylabel('\sigma_2');
grid on

subplot(224)
plot(t, 1 + x(:,1) - exp(2 * x(:,2)))
xlabel('time [s]'); ylabel('\zeta');
grid on

% figure(2)
% plot(t, h, 'k')
% xlabel('time [s]'); ylabel('h(x,t)');
% grid on