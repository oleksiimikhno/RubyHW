p "Дан целочисленный массив. Вывести индексы элементов, которые меньше своего левого соседа, и количество таких чисел."
p "arr2 = arr.unshift(arr[0])[1...arr.size].map.with_index { |v, i| arr[i] > arr[i + 1] ? i : nil }.compact, arr2.size"

arr = [22, -200, 44, 55, 66, 6, 5, 7, 2, 1, 8, -1, -100, 44]
p arr2 = arr.unshift(arr[0])[1...arr.size].map.with_index { |v, i| arr[i] > arr[i + 1] ? i : nil }.compact, arr2.size