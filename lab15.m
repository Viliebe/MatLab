% Входные данные
x = [0 0; -1 1; -1 0; -1 1]; 
target = [0; 1; 1; 0]; % Целевые значения
w = [1 -0.8]; % Начальные веса
b = [1]; % Начальное смещение

% Параметры обучения
max_error = 0.01; % Максимальная ошибка
learning_rate = 0.1; % Скорость обучения
epoch = 10; % Кол-во эпох

% Функция активации
linear_activation = @(z) z;

for e = 1 : epoch
    for i = 1 : size(x, 1)
        new_input = w * x(i, :)' + b;
        output = linear_activation(new_input);

        error = target(i) - output;

        if abs(error) < max_error
            continue;
        end

        w = w + learning_rate * error * x(i, :);
        b = b + learning_rate * error;
    end
end

% Итоговые веса и смещение
disp('Итоговые веса: ');
disp(w);
disp('Итоговое смещение: ');
disp(b);

