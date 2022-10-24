p "Дан целочисленный массив. Найти количество элементов, между первым и последним минимальным."
p "arr[arr.find_index(arr.detect { |v| v == arr.min }) + 1...arr.rindex(arr.min)].size"

arr = [22, 44, 55, -100, 55, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr[arr.find_index(arr.detect { |v| v == arr.min }) + 1...arr.rindex(arr.min)].size