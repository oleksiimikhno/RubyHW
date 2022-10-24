p "Дано целое число. Найти произведение его цифр."
p "22.to_s.split('').map { |value| value.to_i }.reduce(:+)"
p 3214.to_s.split('').map { |value| value.to_i }.reduce(:*)