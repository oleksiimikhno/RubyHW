p "Дан целочисленный массив. Заменить все отрицательные элементы на значение минимального."
p "arr.map { |value| value < 0 ? arr.min : value }"
arr = [2, 4, 3, -3, 2, -1, 1, 15, -22, 22]
p arr.map { |value| value < 0 ? arr.min : value }