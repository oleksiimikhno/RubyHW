p "Дан целочисленный массив. Преобразовать его, прибавив к нечетным числам последний элемент. Первый и последний элементы массива не изменять."
p "arr[1...-1].map { |value| value.odd? ? value + arr.last : value }.unshift(arr[0]) << arr.last"
arr = [2, 4, 3, 2, 1, 15, 22]
p arr[1...-1].map { |value| value.odd? ? value + arr.last : value }.unshift(arr[0]) << arr.last