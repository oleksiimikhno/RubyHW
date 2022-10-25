p "Дан целочисленный массив. Найти индекс последнего максимального элемента."
p "arr.map.with_index { |v, i| v == arr.max ? i : nil }.compact.last"

arr = [22, 44, 55, -100, 66, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr.map.with_index { |v, i| v == arr.max ? i : nil }.compact.last