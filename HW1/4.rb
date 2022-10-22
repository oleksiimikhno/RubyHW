p "Дан целочисленный массив. Вывести номер последнего из тех его элементов, которые удовлетворяют двойному неравенству: A[0] < A[i] < A[-1]. Если таких элементов нет, то вывести [ ]."
p "arr.index(arr.select { |value| arr[0] < value && value < arr[-1] }.last) || []"
arr = [2, 2, 4, 1, 3, 5, 6]
p arr.index(arr.select { |value| arr[0] < value && value < arr[-1] }.last) || []