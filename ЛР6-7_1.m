% Показатели эффективности работы предприятий
enterprises = [
    30, 40, 20; % Предприятие 1: Прибыль, Себестоимость, Доходы
    25, 20, 30; % Предприятие 2
    40, 45, 54; % Предприятие 3
    28, 30, 35; % Предприятие 4
    15, 12, 20; % Предприятие 5
    50, 30, 40  % Предприятие 6
];

% Основной код
n = size(enterprises, 1);

% Задаём матрицы парных сравнений вручную
% Эти значения необходимо заменить на реальные данные по парным сравнениям
matrix_profit = [1,    2,    0.33,   3,   5, 0.25; 
                 0.5,  1,    5,      2,   4, 0.2; 
                 3,    0.2,  1,      3,   7, 0.25; 
                 0.33, 2,    0.33,   1,   5, 0.2; 
                 0.2,  0.25, 0.1429, 0.2, 1, 0.5; 
                 4,    0.5,  0.4,    0.5, 2, 1]; % Прибыль

matrix_cost = [1,      7,      0.33,   5,      9,     5; 
               0.1429, 1,      0.1429, 0.1667, 4,     0.25; 
               3,      7,      1,      5,      8,     4; 
               0.2,    0.1667, 0.2,    1,      7,     1; 
               0.11,   0.25,   0.125,  0.1429, 1,     0.125; 
               0.2,    4,      0.25,   1,      0.125, 1]; % Себестоимость

matrix_income = [1, 0.25,   0.125,  0.33,   1,      0.1429; 
                 4, 1,      0.1429, 0.5,    6,      0.33; 
                 8, 7,      1,      5,      0.1667, 0.25; 
                 3, 0.1667, 0.2,    1,      6,      0.75; 
                 1, 0.25,   6,      0.1667, 1,      0.2; 
                 7, 4,      4,      4,      5,      1]; % Доходы

weights_profit = calculate_weights(matrix_profit);
weights_cost = calculate_weights(matrix_cost);
weights_income = calculate_weights(matrix_income);

disp('Прибыль:'); disp(weights_profit);
disp('Себестоимость:'); disp(weights_cost);
disp('Доходы:'); disp(weights_income);

final_scores = zeros(n, 1);
for i = 1 : n
    final_scores(i) = ...
        weights_profit(i) + ... 
        weights_cost(i) + ... 
        weights_income(i);
end

disp("Оценка каждого предприятия:"); disp(final_scores);

[max_score, best] = max(final_scores);
fprintf('Оптимальный вариант: предприятие %d с весом: %.4f\n', best, max_score);

figure;
bar(final_scores);
xlabel('Варианты предприятий');
ylabel('Итоговый вес');
title('Итоговые веса вариантов предприятий');
xticklabels({'Пред_1', 'Пред_2', 'Пред_3', 'Пред_4', 'Пред_5', 'Пред_6'});
grid on;

% Функция для вычисления весов из матрицы парных сравнений
function [normalized_weights] = calculate_weights(matrix)
    n = size(matrix, 1);
    row_products = prod(matrix, 2);
    row_n_products = nthroot(row_products, n);
    total_sum = sum(row_n_products);
    normalized_weights = row_n_products / total_sum;
end
