p "Дан целочисленный массив. Заменить все положительные элементы на значение максимального."
p "arr.map{ |value| value > 0 ? arr.max : value }"
arr = [2, 4, 3, -3, 2, -1, 1, 15, -22, 22]
p arr.map { |value| value > 0 ? arr.max : value }