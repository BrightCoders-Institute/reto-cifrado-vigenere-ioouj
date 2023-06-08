message = 'HOLA'
key = 'SECRETO'

def string_to_ascii_values(string)
  string.map { |char| char.ord - 65 }
end

def fill_with_offset(message, key)
  resized_key = key * (message.length / key.length)
  offset = key[0...(message.length % key.length)]
  resized_key + offset
end

def add_two_adjusted_arrays(numeric_message, numeric_fit_key)
  for i in 0...numeric_message.length
    numeric_message[i] += numeric_fit_key[i] % 26
  end
  numeric_message
end

def ascii_values_to_char(array)
  return array.map { |value|
    value += 65
    value.chr
  }
end

fit_key = fill_with_offset(message, key)

numeric_message = string_to_ascii_values(message.split(''))
numeric_fit_key = string_to_ascii_values(fit_key.split(''))

puts "numeric_message: #{numeric_message}"
puts "numeric_fit_key: #{numeric_fit_key}"

new_message = add_two_adjusted_arrays(numeric_message, numeric_fit_key)

puts "new_message: #{new_message}"


numeric_message = nil

new_message = ascii_values_to_char(new_message).join

puts new_message
# puts new_message

# puts message
# puts key

puts ""
for i in 0..26
  j = i+65  
  print j.chr
end
