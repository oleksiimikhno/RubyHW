p "Дан целочисленный массив. Определить количество участков, на которых его элементы монотонно возрастают."
p "arr.chunk_while { |i, j| i + 1 == j}.to_a.select {|item| item.length > 1 }.length"
arr = [23, 13, 23, 24, 25, 29, 33, 19, 34, 35, 45, 44, 43, 65, 67]
p arr.chunk_while { |i, j| i + 1 == j }.to_a.select {|item| item.length > 1}.length