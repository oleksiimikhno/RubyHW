p "Дан целочисленный массив. Вывести вначале все его четные элементы, а затем - нечетные."
p "arr.map{|v| v.even? ? v : nil}.compact + arr.map{|v| v.odd? ? v : nil}.compact"

arr = [22, 44, 55, -100, 55, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr.map{|v| v.even? ? v : nil}.compact + arr.map{|v| v.odd? ? v : nil}.compact
