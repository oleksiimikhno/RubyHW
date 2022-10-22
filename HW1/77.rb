p "Дано целое число. Найти сумму его цифр."
p "22.to_s.split('').map{ |value| value.to_i}.reduce(:+)"
22.to_s.split('').map{ |value| value.to_i}.reduce(:+)