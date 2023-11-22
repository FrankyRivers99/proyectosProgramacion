% Puntos de entrada
P = [
    1, 1, 1;
    2, 2, 1;
    -1, -1, -1;
    -2, -2, -1;
    -1, -1, 1;
    1, -1, -1
];

% Clases
T = [
    1, 1, -1, -1, -1, 1;
    1, 1, -1, -1, 1, -1
];

% Separar puntos por clases
P_clase1 = P(T(1,:) == 1, :);
P_clase2 = P(T(1,:) == -1, :);

% Graficar puntos en 3D
scatter3(P_clase1(:,1), P_clase1(:,2), P_clase1(:,3), 'o', 'filled', 'DisplayName', 'Clase 1');
hold on;
scatter3(P_clase2(:,1), P_clase2(:,2), P_clase2(:,3), '+', 'DisplayName', 'Clase -1');
hold off;
legend;
xlabel('X');
ylabel('Y');
zlabel('Z');