p "Дан целочисленный массив. Найти индекс первого максимального элемента."
p "arr.map.with_index {|v, i| v == arr.max ? i : nil }.compact.first"

arr = [22, 44, 55, 66, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr.map.with_index {|v, i| v == arr.max ? i : nil }.compact.first