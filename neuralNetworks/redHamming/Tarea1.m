clc 
clear

% Datos de ejemplo
x = [1, 2, 3, 4, 5];
y = [2, 1, 3, 5, 4];

% Grado del polinomio que deseas ajustar
grado_polinomio = 4;

% Ajustar el polinomio a los datos
coeficientes = polyfit(x, y, grado_polinomio);

% Crear una función polinómica a partir de los coeficientes
funcion_polinomica = poly2sym(coeficientes);

% Evaluar la función en un rango de valores de x
x_interp = linspace(min(x), max(x), 100); % Genera 100 puntos entre el mínimo y el máximo de x
y_interp = polyval(coeficientes, x_interp);

% Mostrar la gráfica
plot(x, y, 'O', x_interp, y_interp);
title('Gráfica de la función interpoladora (Polinómica)');
xlabel('x');
ylabel('y');
legend('Puntos de datos', 'Función interpoladora');
grid on;

