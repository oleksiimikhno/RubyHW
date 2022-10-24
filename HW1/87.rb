p "Дан целочисленный массив. Найти все четные элементы."
p "arr.select { |value| value.even? }"
arr = [22, 44, 55, 66 , 6, 5, 7 ,2 , 1, 8]
p arr.select { |value| value.even? }