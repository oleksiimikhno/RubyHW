arr = [621, 445, 147, 159, 430, 222, 482, 44, 194, 522, 652, 494, 14, 126, 532, 387, 441, 471, 337, 446, 18, 36, 202, 574, 556, 458, 16, 139, 222, 220, 107, 82, 264, 366, 501, 319, 314, 430, 55, 336]

arr.size
arr.reverse
arr.max
arr.min
arr.sort
arr.sort { |a, b| b <=> a }
arr.map { |v| v % 2 }
arr.select { |v| (v % 2).zero? ? v : nil }
arr.select { |v| (v % 3).zero? ? v : nil }
arr.uniq
arr.map { |v| v.to_f / 10 }
