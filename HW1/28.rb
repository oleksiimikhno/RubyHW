p "Дан целочисленный массив. Преобразовать его, вставив после каждого отрицательного элемента нулевой элемент."
p "arr.map { |value| value.negative? ? [value, arr[0]] : value }.flatten"
arr = [23, 13, 25, 29, -33, 19, 34, -45, 65, -67]
p arr.map { |value| value.negative? ? [value, arr[0]] : value }.flatten