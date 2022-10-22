p "Дано натуральное число N. Если N - нечетное, то найти произведение 1*3*…*N; если N - четное, то найти произведение 2*4*…*N."
p "(n.odd? ? arr.select{|v| v.odd?} : arr.select{|v| v.even?}).reduce(&:*) * n"
arr = [22, 44, 55, 66 , 6, 5, 7 ,2 , 1, 8]
n = 3
p  (n.odd? ? arr.select{|v| v.odd?} : arr.select{|v| v.even?}).reduce(&:*) * n