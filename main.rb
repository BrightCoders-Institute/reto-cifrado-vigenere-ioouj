class Vigenere

  def initialize(lang, key)
    @lang = lang
    @key = key
  end

  def fit_key_with_single_word(word)
    resized_key = @key * (word.length / @key.length)
    offset = @key[0...(word.length % @key.length)]
    return resized_key + offset
  end

  def fit_key_with_message(message)
    words = message.split(' ')
    joined_words = words.join
    adjusted_key = fit_key_with_single_word(joined_words)

    #Para cada palabra, recorre la key ya ajustada hacia la derecha, dependiendo del tamaño de la palabra
    for i in 0...words.length
      words[i] = adjusted_key[0...words[i].length]
      adjusted_key = adjusted_key[words[i].length...adjusted_key.length]
    end
    words.join(' ')
  end

  def string_to_ascii(string)
    string = string.split('')

    if @lang == 'ESP'
      return string.map { |char|

        new_char = nil
        if char.ord == 'Ñ'.ord
          # El caracter es la Ñ (Posición 144) ahora 14
          new_char = 14
        elsif (char.ord - 'A'.ord) >= 14
          # Caracteres a la derecha de la Ñ
          new_char = char.ord - 65 + 1
        else 
          new_char = char.ord - 65
        end
        new_char
      }
    else
      string.map { |char| char.ord - 65 }
    end
  end

  def add_two_adjusted_arrays(numeric_message, numeric_fit_key)
    mod = @lang == 'ESP' ? 27: 26
    for i in 0...numeric_message.length

      if numeric_message[i] == -33
        next
      end

      numeric_message[i] = (numeric_message[i] + numeric_fit_key[i]) % mod
    end
    numeric_message
  end

  def ascii_values_to_string(array)
    string = nil
    if @lang == 'ESP'

      string = array.map { |value|
        new_value = nil

        if value == 14
          new_value = 'Ñ'.ord

        elsif value >= 14
          new_value = value + 'A'.ord - 1

        else
          new_value = value + 'A'.ord
        end

        new_value.chr(Encoding::UTF_8)
      }
    else
      string = array.map { |value|
        value += 65
        value.chr(Encoding::UTF_8)
      }
    end
    string.join
  end

  def cipher(message)
    key_words = fit_key_with_message(message)
    numeric_message = string_to_ascii(message)
    numeric_key_words = string_to_ascii(key_words)
    added_arrays = add_two_adjusted_arrays(numeric_message, numeric_key_words)
    ascii_values_to_string(added_arrays)
  end

end