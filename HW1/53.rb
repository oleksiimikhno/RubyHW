p "Дан целочисленный массив. Найти количество элементов, расположенных перед последним максимальным."
p "arr.slice_after(arr.max).to_a.reverse.drop(1).flatten.size"

arr = [22, 44, 55, -100, 55, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr.slice_before(arr.max).to_a.reverse.drop(1).flatten.size