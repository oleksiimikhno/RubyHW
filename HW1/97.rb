p "Дан целочисленный массив и число К. Вывести индекс последнего элемента, меньшего К."
p "arr.rindex(arr.find_all { |v| v < k }.last)"

arr = [22, -200, 44, 55, 66, 6, 5, 7, 2, 1, 8, -1, -100, 44]
k = 33
p arr.rindex(arr.find_all { |v| v < k }.last)