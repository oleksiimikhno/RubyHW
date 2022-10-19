p "Дан целочисленный массив. Необходимо вывести вначале его элементы с четными индексами, а затем - с нечетными."
p "[5, 4, 3, 2, 1].map.with_index{ |value, index| [value, index] }.sort_by{ |value, index| index % 2 }.map{ |value, index| value }"
p [5, 4, 3, 2, 1].map.with_index{ |value, index| [value, index] }.sort_by{ |value, index| index % 2 }.map{ |value, index| value }