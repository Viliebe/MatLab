% LW_6-7_Task_2. Выбор копировального аппарата
products = {'Canon', 'Huawei', 'Epson', 'Pantum', 'HP', '{Xerox'};
n = length(products);

%Матрица по качеству печати 
matrix_quality = [1,   3,    1/3,  2,   1,   2;
                        1/3, 1,    1/4,  3,   2,   3;
                        3,   4,    1,    2,   3,   4;
                        1/2, 1/3,  1/2,  1,   1,   2;
                        1,   1/2,  1/3,  1,   1,   2;
                        1/2, 1/3,  1/2, 1/4, 1/2,  1];

%Матрица по стоимости устройства
matrix_cost = [1,   3,   5,   4,   2,   3;
                1/3,  1,   2,   3,  1/2,  1;
                1/5, 1/2,  1,   2,  1/4, 1/3;
                1/4, 1/3, 1/2,  1,  1/3, 1/5;
                1/2,  2,   4,   3,   1,   2;
                1/3,  1,   3,   5,  1/2,  1
];

%Матрица по скорость печати
matrix_speed = [1,   2,   4,   3,   1,   5;
               1/2,  1,   2,   2,  1/3,  3;
               1/4, 1/2,  1,  1/3, 1/4,  2;
               1/3, 1/2,  3,   1,  1/2,  4;
                1,   3,   4,   2,   1,   5;
               1/5, 1/3, 1/2, 1/4, 1/5,  1
];

%Матрица по наличии цвета
matrix_color = [1,   2,   3,   4,   5,   6;
                    1/2,  1,   2,   3,   4,   5;
                    1/3, 1/2,  1,   2,   3,   4;
                    1/4, 1/3, 1/2,  1,   2,   3;
                    1/5, 1/4, 1/3, 1/2,  1,   2;
                    1/6, 1/5, 1/4, 1/3, 1/2,  1
];

% Матрица по формату оригинала и копии
matrix_format = [1,   2,   3,   4,   5,   1;
                   1/2,  1,   2,   3,   4,  1/2;
                   1/3, 1/2,  1,   2,   3,  1/3;
                   1/4, 1/3, 1/2,  1,   2,  1/4;
                   1/5, 1/4, 1/3, 1/2,  1,  1/5;
                    1,   2,   3,   4,   5,   1
];

% Матрица по объему печати
matrix_volume = [1,   3,   4,   2,   5,   2;
                 1/3,  1,   2,  1/2,  2,  1/4;
                 1/4, 1/2,  1,  1/3,  1,  1/5;
                 1/2,  2,   3,   1,   4,  1/2;
                 1/5, 1/2,  1,  1/4,  1,  1/3;
                 1/2,  4,   5,   2,   3,   1
];

weights_quality = calculate_weights(matrix_quality);
weights_cost = calculate_weights(matrix_cost);
weights_speed = calculate_weights(matrix_speed);
weights_color = calculate_weights(matrix_color);
weights_format = calculate_weights(matrix_format);
weights_volume = calculate_weights(matrix_volume);

disp('Качеству печати:'); disp(weights_quality);
disp('Стоимость устройства:'); disp(weights_cost);
disp('Скорость печати:'); disp(weights_speed);
disp('Наличие цвета:'); disp(weights_color);
disp('Формат оригинала и копии:'); disp(weights_format);
disp('Объем печати'); disp(weights_volume);


final_scores = zeros(n, 1); 
for i = 1:n
    final_scores(i) = weights_quality(i) + ...
                       weights_cost(i) - ... % Минус цена
                       weights_speed(i) + ...
                       weights_color(i) + ...
                       weights_format(i) + ...
                       weights_volume(i);
end

normalized_final_scores = final_scores / sum(final_scores);

[max_score, best] = max(normalized_final_scores);

% Вывод результата
fprintf('Оптимальный копировальный аппарат: %s с весом: %.4f\n', products{best}, max_score);

% Построение графика
figure;
bar(normalized_final_scores);
xlabel('Копировальные аппараты'); 
ylabel('Итоговый вес');
title('Итоговые оценки копировальных аппаратов');
xticklabels(products);
grid on;

% Функция для вычисления весов из матрицы парных сравнений
function [normalized_weights] = calculate_weights(matrix)
    n = size(matrix, 1);
    row_products = prod(matrix, 2);
    row_n_products = nthroot(row_products, n);
    total_sum = sum(row_n_products);
    normalized_weights = row_n_products / total_sum;
end