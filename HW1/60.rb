p "Дан целочисленный массив. Найти количество элементов, между первым и последним максимальным."
p "arr[arr.find_index(arr.detect { |v| v == arr.max}) + 1...arr.rindex(arr.max)].size"

arr = [22, 44, 55, -100, 55, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr[arr.find_index(arr.detect { |v| v == arr.max}) + 1...arr.rindex(arr.max)].size