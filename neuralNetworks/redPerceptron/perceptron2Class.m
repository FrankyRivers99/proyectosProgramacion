%Red neuronal perceptron.
% Utilizando la funcion de activación hardlims

%Incializamos limpiando 
clc, clear, close all

%Notas:
% El archivo input_p.txt debe de estar formateado para que cada fila representen los valores(parametros) de una entrada
% Por lo que cada fila representa una entrada diferente.
% En el archivo target_t las clases deben de ser valores -1 o 1 y deben de estar en un matriz de 1xTotalValoresEntrada
% Es decir cada valor de entrada debe de saber de que clase es(Aprendizaje supervisado)

%Cargamos los datos desde un inicio 
[conjunto_entrenamiento, resultados, num_epocas] = cargarDatos();

%Iniciamos la red perceptron con los valores inicializados e ingresados
perceptron(conjunto_entrenamiento, resultados, num_epocas)



%-----------------------------------Inicialización de valores---------------------------------%
% Esta función inicializa los valores de la matriz de pesos y el bias y
% necesita de entrada la matriz de valores de entrada
function [w, b] = iniciarParametros (p_input)
    % Obtenemos la cantidad de pesos para cada neurona obteniendo la cantidad de columnas de la matriz de entradas   
    cantidad_parametros_clase  = size(p_input, 2);
    % Indicamos al usuario las clases que desea clasificar
    no_clases = 2;
    % Si desea un numero par de clases entonces se pasa directo el valor entre dos ya que cada neurona puede sacar dos clases
    if no_clases%2 == 0
        w = 2 * rand(cantidad_parametros_clase, no_clases/2) - 1; % Generando un número aleatorio en el rango de -1 a 1    
        b = 2 * rand() - 1;
    
    % Si desea un numero inpar de clases se suma uno al numero de clases ya que cada neurona solo modela dos clases al agregarle 
    % uno representara una clase extra que nunca clasificara pero que si existe
    else 
        no_clases = no_clases+1;
        w = 2 * rand(cantidad_parametros_clase, no_clases/2) - 1; 
        b = 2 * rand() - 1;
    end
end
%---------------------------------------------------------------------------------------------%

%Creamos la funcion de transferencia o activiación de la red perceptron modelando la funcion hardlims
%----------------------------------Función de transferencia-----------------------------------%
function matrizPerceptron = funsionTransferenciaEscalon(matriz_resultado)
    % Creamos una matriz de salida del mismo tamaño que la matriz de entrada
    matrizPerceptron = zeros(size(matriz_resultado));
    
    % Encontrar posiciones donde los valores son mayores o iguales a uno
    indices_mayor_que_uno = matriz_resultado >= 0;
    
    % Asignar valores de 1 a las posiciones mayores o iguales a uno
    matrizPerceptron(indices_mayor_que_uno) = 1;
    
    % Restar 1 a las posiciones que son mayores o iguales a uno
    matrizPerceptron = matrizPerceptron * 2 - 1;
end
%---------------------------------------------------------------------------------------------%

%----------------------------------------Carga de datos---------------------------------------%
function [conjunto_entrenamiento, resultados, num_epocas] = cargarDatos()

    % Solicitar nombres de archivos
    archivo_entrenamiento = input('Ingrese el nombre del archivo de conjunto de entrenamiento: ', 's');
    archivo_resultados = input('Ingrese el nombre del archivo de las clases del conjunto de entrenamiento anterior: ', 's');

    % Cargar datos desde los archivos
    conjunto_entrenamiento = load(archivo_entrenamiento);
    resultados = load(archivo_resultados);

    % Solicitar número de épocas (menor a 100)
    num_epocas = input('Ingrese el número de épocas de entrenamiento (menor a 100): ');    
    %Validar que el número de épocas sea menor a 100
        
    while num_epocas >= 100
        disp('Error: El número de épocas debe ser menor a 100.');
        num_epocas = input('Ingrese el número de épocas de entrenamiento (menor a 100): ');
    end 

    disp('Datos cargados exitosamente.');

end
%---------------------------------------------------------------------------------------------%

%------------------------------------Epoca de entrenamiento-----------------------------------%
function [wnew] = ajustar_pesos(w, bias, entradas, matriz_target)
    
    disp("Entradas transpuestas fila = dato");
    disp(entradas);
    
    numero_entradas = size(entradas, 1);
    
    disp(numero_entradas);

    for i = 1:numero_entradas
        disp("Se multiplico");
        disp(entradas(i,:));
        disp(w);
        disp("Resultado");        
        a_temp = (entradas(i,:) * w) + bias ;
        disp(a_temp);
        a = funsionTransferenciaEscalon(a_temp);
        disp("Aplicando hardlim");
        disp(a);
        e = matriz_target(:,i) - a;
        disp("Valor esperado");
        disp(matriz_target(:,i));
        disp("Resultado error");        
        disp(e);
        [w, bias]= ajustarpeso(w, entradas(i,:), bias, e);
        disp("Nuevo w");
        disp(w);
        disp("-----------------------------------------");
    end
    wnew= w;
    disp(wnew);
end
%---------------------------------------------------------------------------------------------%

%-----------------------------------Funcion para ajustar wi-----------------------------------%
function [w_new, b_new] = ajustarpeso(w_old, p, b_old, e)
    disp("wnew");
    disp(w_old);
    disp("+");
    disp((e/2*p)');
    w_new = w_old + (e/2*p)';
    disp("Nuevo_W")
    disp(w_new);
    b_new= b_old + e/2;
end
%---------------------------------------------------------------------------------------------%

%-------------------------------Validación de entrenamiento-----------------------------------%
function [Validacion] = validacion_Perceptron(wfinal, entradas, matriz_clases, bias)
    numero_entradas = size(entradas, 1);
    contadorAciertos = 0;
    
    for i = 1:numero_entradas
        a_temp = (entradas(i,:) *wfinal) + bias ;        
        a = funsionTransferenciaEscalon(a_temp);    
        disp("Valor obtenido");
        disp(a);
        disp("Valor estimado");
        disp(matriz_clases(:, i));
        %Si la matriz de resultados es igual a la matriz target es decir la matriz que contiene 
        if a == matriz_clases(:, i)
            contadorAciertos= contadorAciertos + 1;
        end
    end
    disp("Aciertos");
    disp(contadorAciertos);
    if contadorAciertos == 4
        Validacion = 1;
    else
        Validacion = 0;
    end

end
%---------------------------------------------------------------------------------------------%


%------------------------------------Función de guardado--------------------------------------%
function guardarPesosBias(w, b)
    % Guardar valores finales de pesos en w.txt
    fid = fopen('w.txt', 'w');
    fprintf(fid, '%f\n', w);
    fclose(fid);

    % Guardar valores finales de sesgo en b.txt
    fid = fopen('b.txt', 'w');
    fprintf(fid, '%f\n', b);
    fclose(fid);

    disp('Valores finales de pesos y sesgo guardados en w.txt y b.txt.');
end

%---------------------------------------------------------------------------------------------%


%-----------------------------------Entrenamiento Perceptron----------------------------------%
function perceptron (conjunto_entrenamiento, resultados, num_epocas)    
    disp(conjunto_entrenamiento);
    disp(resultados);
    %Iniciamos la matriz de pesos 
    [w, b] = iniciarParametros(conjunto_entrenamiento);
    disp(w);
    disp(b);
    %Iniciamos con el entrenamiento.
    for i = 1 : num_epocas
        w = ajustar_pesos(w, b, conjunto_entrenamiento, resultados);        
        validacion = validacion_Perceptron(w, conjunto_entrenamiento, resultados, b);
        if validacion == 1
            %Guardamos los pesos y el bias en un archivo .txt
            guardarPesosBias(w, b);    
    
            %Fijamos la grafica en -2 y 2
            disp(conjunto_entrenamiento');
            disp(hardlim(resultados));            
            plotpv(conjunto_entrenamiento', hardlim(resultados));
            linehandle = plotpc(w', b);
            set(linehandle, 'Color', 'r');
            set(linehandle, 'Linestyle', '--');
            axis([-2 2 -2 2]);
    
            %Preguntamos si se desea hacer otra iteración de aprendizaje con los mismo datos 
            Repeticion = input('Si desea repetir el aprendizaje ingrese 1, de caso contrario ingrese 0: ');
            if Repeticion == 1
                perceptron (conjunto_entrenamiento, resultados, num_epocas)
            else
                disp("No ingreso una respuesta correcta");
                break;
            end
            break;
        elseif i == num_epocas
            disp("Se alcanzo el maximo numero de epocas y no se logro clasificar correctamente");
            Repeticion = input('Si desea repetir el aprendizaje ingrese 1, de caso contrario ingrese 0: ');
            if Repeticion == 1                
                perceptron (conjunto_entrenamiento, resultados, num_epocas)                
            else
                disp("No ingreso una respuesta correcta");
                break;
            end
        end   
    end    
    %Validacion de entrenamiento
    disp("Ultimo peso obtenido")
    disp(w);    
end
%---------------------------------------------------------------------------------------------%