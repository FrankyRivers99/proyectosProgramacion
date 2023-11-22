%Red neuronal de Hammington

%Declaramos los valores de entrada conocidos
P1 = [1; 1; -1; 1; 1]; %Limon
P2 = [1; 1; 1; -1; 1]; %Naranja


%Valor entrada desconocido
P = [1; 1; 1; 1; 1]; %Mandarina

%disp("Entrada prueba");
%Valorprueba;
%disp(size(Valorprueba));

%Obtenemos la longitud del vector de entrada para poder obtener R que es el
%total de caracteristicas de un valor de entrada

R = length(P1);  %5

%Numero de neuronas
S = 2;

%Creamos la matriz W para la capa de propagación hacia adelante esto
%transponiendo los valores de entrada y juntandolos en una matriz
matrizW_FeedForward =  [P1'; P2'];

disp("Matriz de la capa de propagación hacia adelante");
disp(matrizW_FeedForward);
disp(size(matrizW_FeedForward))

%Creamos la matriz del bias para que posteriormente se sume con la matriz W
%Para ello se usa ones que creara una matriz de una fila que tendra el bias
%de cada neurona que en este caso es el mismo para todos es decir R es por
%eso que se utiliza ones para crear una matriz de unos y asignarle el valor
%R
bias = R * ones(S, 1);

disp("Matriz del bias");
disp(bias);
disp(size(bias))

%Ahora para crear la salida de la capa feedforward declaramos la salida de
%acuerdo a la red neuronal en este caso la función de transferencia se
%representa con la misma función ya que lo que entra es lo que sale

a1 = (matrizW_FeedForward*P) + bias;

disp('La matriz resultante a1  es:');
disp(a1); 
disp(size(a1))

%Declaramos el valor de epsilon
epsilon = 0.75;

%Comprobamos que el valor epsilon sea adecuado por la formula

if epsilon < (1/(S-1))
    disp('El valor de epsilon se a guardado');
else
    disp('El valor proporcionado para epsilon no es valido');
end

%Ahora creamos la matriz W de la capa recurrente 
matrizW_Recurrente =  eye(S) + (-epsilon * (ones(S) - eye(S)));

%Declaramos las etapas o iteraciones de la red neuronal
etapas = 100;

%Creamos un arreglo que guarde la salida de la primera capa(feedfoorwad)
%y las salidas de la segunda capa (recurrente)


arreglo_saldias_a = cell(etapas, 1);
%Agregamos la primera salida    
arreglo_saldias_a{1,1} = a1;



%Teniendo ya definida la matriz recurrente W2 y la primera entrada de la
%capa recurrente a1 ahora creamos un ciclo que represente el diley


% Inicializar una variable de contador

etapa=1;
% Definir la condición del bucle (mientras el contador sea menor o igual a 5)
while etapa <= etapas    
    a_temporal= funsionTransferenciaPoslin(matrizW_Recurrente*arreglo_saldias_a{etapa,1});
    % Pasamos a la siguiente etapa 
    etapa = etapa+1;
    arreglo_saldias_a{etapa,1} = a_temporal;
end

disp(matrizW_Recurrente);


% Por ultimo mostramos todas las salidas de la red neuronal
for i = 1:etapas
    disp(['Iteración(Etapa): ', num2str(i), ':']);
    disp(arreglo_saldias_a{i});
end

% Por ultimo mostramos todas las salidas de la red neuronal
for i = 1:etapas
    x = i * ones(length(arreglo_saldias_a{i,1}), 1);
    y =  arreglo_saldias_a{i,1};
    plot(x, y,  'o');
    grid on;
    xlim([0, 100]);
    ylim([0, .6]);
    xticks(0:1:100);
    hold on;
end


hold off;

% Etiquetas y título del gráfico
xlabel('Etapas');
ylabel('a2(t)');
title('Gráfica de evolución de la salida a2');

%------------------------------Función de transferencia---------------------%
function output = funsionTransferenciaPoslin(input)
    % Creamos una matriz con valores ceros de la misma dimención que la funcion de entrada
    output = zeros(size(input));
    
    % Encontramos las posiciones de la matriz donde el valor de entrada es mayor o igual a cero
    positive_indices = input >= 0;
    
    % Al final asignamos los valores de entrada que son positivos a la
    % salida con ayuda de los indices positivos
    output(positive_indices) = input(positive_indices);
end