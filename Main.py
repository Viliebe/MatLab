import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

# Определение входных переменных
price = ctrl.Antecedent(np.arange(0, 200000, 1000), 'price')  # Цена
battery_life = ctrl.Antecedent(np.arange(0, 100, 1), 'battery_life')  # Время работы от батареи
camera_quality = ctrl.Antecedent(np.arange(0, 100, 1), 'camera_quality')  # Качество камеры
storage_capacity = ctrl.Antecedent(np.arange(0, 1000, 10), 'storage_capacity')  # Вместимость памяти

# Определение выходной переменной
quality = ctrl.Consequent(np.arange(0, 11, 0.1), 'quality')

# Функции принадлежности для входных переменных
price['low'] = fuzz.trapmf(price.universe, [0, 0, 30000, 50000])
price['medium'] = fuzz.trimf(price.universe, [30000, 70000, 100000])
price['high'] = fuzz.trapmf(price.universe, [80000, 100000, 200000, 200000])

battery_life['poor'] = fuzz.trapmf(battery_life.universe, [0, 0, 10, 20])
battery_life['average'] = fuzz.trimf(battery_life.universe, [10, 40, 70])
battery_life['good'] = fuzz.trapmf(battery_life.universe, [60, 80, 100, 100])

camera_quality['poor'] = fuzz.trapmf(camera_quality.universe, [0, 0, 20, 40])
camera_quality['average'] = fuzz.trimf(camera_quality.universe, [20, 50, 80])
camera_quality['good'] = fuzz.trapmf(camera_quality.universe, [70, 80, 100, 100])

storage_capacity['small'] = fuzz.trapmf(storage_capacity.universe, [0, 0, 32, 64])
storage_capacity['medium'] = fuzz.trimf(storage_capacity.universe, [32, 128, 256])
storage_capacity['large'] = fuzz.trapmf(storage_capacity.universe, [128, 256, 1000, 1000])

# Функции принадлежности для выходной переменной
quality['poor'] = fuzz.trapmf(quality.universe, [0, 0, 2, 3])
quality['average'] = fuzz.trimf(quality.universe, [2, 4.5, 7])
quality['good'] = fuzz.trapmf(quality.universe, [6, 7, 10, 10])

# Правила нечеткого вывода
rule1 = ctrl.Rule(price['low'] & battery_life['poor'] & camera_quality['poor'] & storage_capacity['small'], quality['poor'])
rule2 = ctrl.Rule(price['medium'] & battery_life['average'] & camera_quality['average'] & storage_capacity['medium'], quality['average'])
rule3 = ctrl.Rule(price['high'] & battery_life['good'] & camera_quality['good'] & storage_capacity['large'], quality['good'])

rule4 = ctrl.Rule(price['low'] & battery_life['average'] & camera_quality['poor'] & storage_capacity['small'], quality['poor'])
rule5 = ctrl.Rule(price['medium'] & battery_life['good'] & camera_quality['poor'] & storage_capacity['medium'], quality['average'])
rule6 = ctrl.Rule(price['high'] & battery_life['poor'] & camera_quality['good'] & storage_capacity['large'], quality['average'])

rule7 = ctrl.Rule(price['low'] & battery_life['good'] & camera_quality['average'] & storage_capacity['small'], quality['average'])
rule8 = ctrl.Rule(price['medium'] & battery_life['poor'] & camera_quality['average'] & storage_capacity['large'], quality['poor'])
rule9 = ctrl.Rule(price['high'] & battery_life['average'] & camera_quality['good'] & storage_capacity['medium'], quality['good'])

rule10 = ctrl.Rule(price['low'] & battery_life['poor'] & camera_quality['good'] & storage_capacity['medium'], quality['poor'])
rule11 = ctrl.Rule(price['medium'] & battery_life['average'] & camera_quality['good'] & storage_capacity['large'], quality['good'])
rule12 = ctrl.Rule(price['high'] & battery_life['good'] & camera_quality['average'] & storage_capacity['small'], quality['average'])

rule13 = ctrl.Rule(price['low'] & battery_life['good'] & camera_quality['poor'] & storage_capacity['large'], quality['average'])
rule14 = ctrl.Rule(price['medium'] & battery_life['poor'] & camera_quality['poor'] & storage_capacity['small'], quality['poor'])
rule15 = ctrl.Rule(price['high'] & battery_life['average'] & camera_quality['average'] & storage_capacity['medium'], quality['good'])

rule16 = ctrl.Rule(price['low'] & battery_life['average'] & camera_quality['good'] & storage_capacity['large'], quality['good'])
rule17 = ctrl.Rule(price['medium'] & battery_life['good'] & camera_quality['poor'] & storage_capacity['small'], quality['average'])
rule18 = ctrl.Rule(price['high'] & battery_life['good'] & camera_quality['good'] & storage_capacity['small'], quality['good'])

rule19 = ctrl.Rule(price['medium'] & battery_life['poor'] & camera_quality['average'] & storage_capacity['large'], quality['poor'])

# Создание системы управления
quality_ctrl = ctrl.ControlSystem([rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9, rule10, rule11, rule12, rule13, rule14, rule15, rule16, rule17, rule18, rule19])
quality_sim = ctrl.ControlSystemSimulation(quality_ctrl)


# Ввод входных данных
price_input = 60000
battery_life_input = 50
camera_quality_input = 32
storage_capacity_input = 128

quality_sim.input['price'] = price_input
quality_sim.input['battery_life'] = battery_life_input
quality_sim.input['camera_quality'] = camera_quality_input
quality_sim.input['storage_capacity'] = storage_capacity_input

# Выполнение симуляции
quality_sim.compute()

# Вывод результатов
print(f"Входные данные:")
print(f"Цена: {price_input} рублей")
print(f"Время работы от батареи: {battery_life_input} часов")
print(f"Качество камеры: {camera_quality_input} МП")
print(f"Вместимость памяти: {storage_capacity_input} ГБ")
print(f"\nРезультат: Качество телефона - {quality_sim.output['quality']}")

# Визуализация результатов
plt.subplot(2, 3, 1)
price.view(sim=quality_sim)
plt.title('Цена')
# Визуализация результатов
plt.subplot(2, 3, 2)
battery_life.view(sim=quality_sim)
plt.title('Время работы от батареи')
# Визуализация результатов
plt.subplot(2, 3, 3)
camera_quality.view(sim=quality_sim)
plt.title('Качество камеры')
# Визуализация результатов
plt.subplot(2, 3, 4)
storage_capacity.view(sim=quality_sim)
plt.title('Вместимость памяти')
# Визуализация результатов
plt.subplot(2, 3, 5)
quality.view(sim=quality_sim)
plt.title('Цена')


plt.tight_layout()
plt.show()