% Правила нечеткого вывода
rules = [
    [1, 1, 1, 1, 1],
    [1, 1, 1, 2, 1],
    [1, 1, 2, 1, 1],
    [1, 1, 2, 2, 1],
    [1, 1, 3, 3, 1],
    [1, 2, 1, 1, 1],
    [1, 2, 2, 2, 1],
    [1, 2, 3, 3, 2],
    [1, 3, 1, 1, 1],
    [1, 3, 2, 2, 2],
    [1, 3, 3, 3, 2],
    [2, 1, 1, 1, 1],
    [2, 1, 2, 1, 1],
    [2, 1, 3, 2, 2],
    [2, 1, 2, 2, 2],
    [2, 1, 3, 3, 2],
    [2, 2, 1, 1, 1],
    [2, 2, 2, 1, 2],
    [2, 2, 3, 2, 2],
    [2, 3, 1, 1, 2],
    [2, 3, 2, 2, 2],
    [2, 3, 3, 3, 3],
    [3, 1, 1, 1, 1],
    [3, 1, 2, 1, 2],
    [3, 1, 3, 2, 2],
    [3, 1, 3, 3, 2],
    [3, 2, 1, 1, 2],
    [3, 2, 2, 1, 2],
    [3, 2, 3, 2, 3],
    [3, 2, 3, 3, 3],
    [3, 3, 1, 1, 2],
    [3, 3, 2, 2, 3],
    [3, 3, 3, 3, 3]
]

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
maxMinResult = calcAggregationMaxMin([40000, 9, 5, 55], [2, 2, 2, 2]);
disp('Степень уверенности (максиминная):');
disp(maxMinResult);

algResult = calcAggregationAlg([40000, 9, 5, 55], [2, 2, 2, 2]);
disp('Степень уверенности (алгебраическая):');
disp(algResult);

% % Определяем диапазон для графиков
x = linspace(0, 1, 1000); % Степень принадлежности входная
minValues = min(x, x); % Значение для максиминной агрегации (просто x)
algValues = x.*x; % Значение для алгебраической агрегации
figure;
hold on;
plot(x, minValues, 'r', 'DisplayName', 'maxMin');
plot(x, algValues, 'b', 'DisplayName', 'Alg');
xlabel('Степень принадлежности входная');
ylabel('Результат вычисления условия правила');
legend;
title('Сравнение степеней уверенности: максиминная и алгебраическая агрегация');
grid on; 
hold off;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
calcMinImplic([40000 9 5 55],[2 2 2 2 2],[4, 5, 6, 7]);
calcProdImplic([40000 9 5 55],[2 2 2 2 2],[4, 5, 6, 7]);

% % Определяем диапазон для графиков
x = linspace(0, 1, 1000); % Степень принадлежности входная
figure;
hold on;
plot(x, min(x, x), 'r', 'DisplayName', 'Min');
plot(x, x.*x, 'b', 'DisplayName', 'Prod');
xlabel('Степень принадлежности входная');
ylabel('Результат вычисления импликации');
legend;
grid on;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Определяем диапазон для графиков
input = [40000, 8, 5, 45 8];
x = linspace(1, 10, 1000000); % Степень принадлежности входная
figure;
hold on;
plot(x, calcMaxAcc(x, input, rules), 'Color', 'r', 'DisplayName', 'MaxAcc');
plot(x, calcSumAcc(x, input, rules), 'Color', 'b', 'DisplayName', 'SumAcc');
xlabel('Оценка');
ylabel('Степень принадлежности');
legend;
grid on;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bis = calcBissect(x, input, rules);
centr = calcCentroid(x, input, rules);
disp(bis);
disp(centr);

figure;
hold on;
plot(x, calcMaxAcc(x, input, rules), 'Color', 'r');
plot([bis, bis], [0, 1], 'Color', 'b', 'DisplayName', 'Bissector');
plot([centr, centr], [0, 1], 'Color', 'g', 'DisplayName', 'Centroid');
xlabel('Оценка')
ylabel('Степень принадлежности')
legend;

function output = calcPrice(x, number)
    if (number == 1)
        output = trapmf(x, [0, 0, 20000, 30000]);
    elseif (number == 2)
        output = trimf(x, [20000, 40000, 60000]);
    else
        output = trapmf(x, [50000, 60000, 100000, 100000]);
    end
end

function output = calcBattery(x, number)
    if (number == 1)
        output = trapmf(x, [5, 5, 7, 8]);
    elseif (number == 2)
        output = trimf(x, [7, 9, 11]);
    else
        output = trapmf(x, [10, 11, 15, 15]);
    end
end

function output = calcCamera(x, number)
    if (number == 1)
        output = trapmf(x, [0, 0, 2, 3]);
    elseif (number == 2)
        output = trimf(x, [2, 4.5, 7]);
    else
        output = trapmf(x, [6, 7, 10, 10]);
    end
end

function output = calcStorage(x, number)
    if (number == 1)
        output = trapmf(x, [30, 30, 45, 50]);
    elseif (number == 2)
        output = trimf(x, [45, 57.5, 70]);
    else
        output = trapmf(x, [65, 70, 80, 80]);
    end
end

function output = calcQuality(x, number)
    if (number == 1)
        output = trapmf(x, [0, 0, 2, 3]);
    elseif (number == 2)
        output = trimf(x, [2, 4.5, 7]);
    else
        output = trapmf(x, [6, 7, 10, 10]);
    end
end

function output = calcAggregationMaxMin(vals, row)
    output = min(calcPrice(vals(1), row(1)), ...
                 min(calcBattery(vals(2), row(2)), ...
                 min(calcCamera(vals(3), row(3)), ...
                 calcStorage(vals(4), row(4)))));
end

function output = calcAggregationAlg(vals, row)
    output = calcPrice(vals(1), row(1)) * ...
             calcBattery(vals(2), row(2)) * ...
             calcCamera(vals(3), row(3)) * ...
             calcStorage(vals(4), row(4));
end

function output = calcMinImplic(vals, row, outputVal)
    output = min(calcAggregationMaxMin(vals, row),calcQuality(outputVal, row(5)));
end

function output = calcProdImplic(vals, row, outputVal)
    output = calcQuality(outputVal, row(5)) .* calcAggregationMaxMin(vals, row);
end

function output = calcMaxAcc(x, vals, rows)
    xOut = x;
    output = 0;
    for i = 1:length(rows)
        row = rows(i, :);
        output = max(calcMinImplic(vals, row, xOut), output);
    end
end

function output = calcSumAcc(x, vals, rows)
    xOut = x;
    output = 0;
    for i = 1:length(rows)
        row = rows(i, :);
        output = calcMinImplic(vals, row, xOut) + output;
    end
    output = min(1,output);
end

function output = calcCentroid(x, input, rules)
    mf = calcMaxAcc(x, input, rules);
    numerator = trapz(x, x .* mf);
    denominator = trapz(x, mf);
    output = numerator / denominator;
end

function output = calcBissect(x, input, rules)
    mf = calcMaxAcc(x, input, rules);
    totalArea = trapz(x, mf);
    halfArea = totalArea / 2;
    currentArea = 0;
    output = NaN;

    for i=1:length(x)
        currentArea = currentArea + trapz(x(i:i + 1), mf(i:i + 1));
        if currentArea >= halfArea
            output = x(i);
            break;
        end
    end
end