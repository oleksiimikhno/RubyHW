p "Дан целочисленный массив. Удалить все элементы, встречающиеся ровно три раза."
p "arr.map.with_index{|v, i| arr.find_all {|elem| elem == v}.size != 3 ? v : nil }.compact"

arr = [22, 44, 55, 66, -6, 5, 7, -2, 1, 55, 8, -1, 44, -100, 55]
p arr.map.with_index{|v, i| arr.find_all {|elem| elem == v}.size != 3 ? v : nil }.compact