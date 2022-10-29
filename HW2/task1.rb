arr = [621, 445, 147, 159, 430, 222, 482, 44, 194, 522, 652, 494, 14, 126, 532, 387, 441, 471, 337, 446, 18, 36, 202,
       574, 556, 458, 16, 139, 222, 220, 107, 82, 264, 366, 501, 319, 314, 430, 55, 336]

p arr.size
p arr.reverse
p arr.max
p arr.min
p arr.sort
p arr.sort { |a, b| b <=> a }
p arr.map { |v| v % 2 }
p arr.select { |v| (v % 2).zero? ? v : nil }
p arr.select { |v| (v % 3).zero? ? v : nil }
p arr.uniq
p arr.map { |v| v.to_f / 10 }
p arr.map.with_index { |_v, i| arr[i] <= ('a'..'z').to_a.size ? ('a'..'z').to_a[i - 1] : nil }.compact
p arr.map { |v| v == arr.max || v == arr.min ? v == arr.min ? arr.max : arr.min : v }
p arr.take_while { |v| v > arr.min }
p arr.sort.take(3)
