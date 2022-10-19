p "Дан целочисленный массив. Необходимо вывести вначале его элементы с нечетными индексами, а затем - четными."

odd = []
even = []

[5, 4, 3, 2, 1].each_with_index do |value, index| 
    if index.odd?
        odd << value
    else 
        even << value
    end
end 

p odd + even