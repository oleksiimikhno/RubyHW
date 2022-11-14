p "Дан целочисленный массив. Преобразовать его, вставив перед каждым положительным элементом нулевой элемент."
p "arr.map { |value| value.positive? ? [arr[0], value] : value }.flatten"
arr = [23, 13, 25, 29, -33, 19, 34, -45, 65, -67]
p arr.map { |value| value.positive? ? [arr[0], value] : value }.flatten