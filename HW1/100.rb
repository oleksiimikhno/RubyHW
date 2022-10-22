p "Дан целочисленный массив. Вывести индексы элементов, которые больше своего правого соседа, и количество таких чисел."
p "arr2 = arr[0...arr.size - 1].map.with_index { |v, i| v > arr[i + 1] ? i : nil }.compact, arr2.size"

arr = [22, -200, 44, 55, 66, 6, 5, 7, 2, 1, 8, -1, -100, 44]
p arr2 = arr[0...arr.size - 1].map.with_index { |v, i| v > arr[i + 1] ? i : nil }.compact, arr2.size