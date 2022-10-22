p "Дан целочисленный массив. Найти количество нечетных элементов"
p "arr.select{ |value| value.odd?}.size"
arr = [22, 44, 55, 66 , 6, 5, 7 ,2 , 1, 8]
p arr.select{ |value| value.odd?}.size