p "Дан целочисленный массив. Преобразовать его, прибавив к четным числам первый элемент. Первый и последний элементы массива не изменять."
p "arr[1...-1].map { |value| value % 2 == 0 ? value + arr[0] : value }.unshift(arr[0]) << arr.last"
arr = [2, 4, 3, 2, 1, 15, 22]
p arr[1...-1].map { |value| value % 2 == 0 ? value + arr[0] : value }.unshift(arr[0]) << arr.last
