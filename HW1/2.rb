p "Дан целочисленный массив. Необходимо вывести вначале его элементы с нечетными индексами, а затем - четными."
p "p [5, 4, 3, 2, 1, 15, 22, 33].map.with_index{ |value, index| [value, index] }.sort_by{ |value, index| index % -2}.map{ |value, index| value }"
p [5, 4, 3, 2, 1, 15, 22, 33].map.with_index{ |value, index| [value, index] }.sort_by{ |value, index| index % -2}.map{ |value, index| value }