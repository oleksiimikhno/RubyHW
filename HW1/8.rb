p "Дан целочисленный массив. Преобразовать его, прибавив к нечетным числам первый элемент. Первый и последний элементы массива не изменять."
p "arr[1...-1].map { |value| value.even? ? value + arr.first : value }.unshift(arr[0]) << arr.last"
arr = [2, 4, 3, 2, 1, 15, 22]
p arr[1...-1].map { |value| value.even? ? value + arr.first : value }.unshift(arr[0]) << arr.last