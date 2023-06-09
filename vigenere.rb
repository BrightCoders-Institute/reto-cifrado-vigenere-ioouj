class Vigenere

  def initialize(key)
    @key = key
    @abc_length = nil
  end

  def fit_key_with_single_word(word)
    # La clave se ajusta para tener la misma longitud que una palabra
    # Obtiene el multiplo para poder rellenar con la key si es de mayor longitud
    # Si es menor, solo toma offset como su longitud
    resized_key = @key * (word.length / @key.length)
    offset = @key[0...(word.length % @key.length)]
    return resized_key + offset
  end

  def fit_key_with_message(message)
    # La clave se ajusta para tener la misma longitud del mensaje original
    # Se toman en cuenta los espacios
    words = message.split(' ')
    joined_words = words.join
    adjusted_key = fit_key_with_single_word(joined_words)

    # Para cada palabra, la clave ya ajustada se recorre hacia la derecha,
    # dependiendo del tamaño de la palabra
    for i in 0...words.length
      words[i] = adjusted_key[0...words[i].length]
      adjusted_key = adjusted_key[words[i].length...adjusted_key.length]
    end
    words.join(' ')
  end

  def add_two_adjusted_arrays(numeric_message, numeric_fit_key)
    # Suma dos arrays de enteros de misma longitud.
    # El valor resultante se ajusta en cero al rebasar el limite de caracteres del idioma.
    if not @abc_length
      raise Exception.new(
        "No language specified.\n@abc_length is needed for modular addition"
      )
    end

    for i in 0...numeric_message.length
      # El caracter de "espacio" no se toma en cuenta
      if numeric_message[i] == -33 then next end
      numeric_message[i] = (numeric_message[i] + numeric_fit_key[i]) % @abc_length
    end
    numeric_message
  end

  def string_to_ascii(*args)
    raise Exception.new("No language specified.")
  end

  def ascii_values_to_string(*args)
    raise Exception.new("No language specified.")
  end

  def cipher(message)
    # Realiza el cifrado Vigenere de un mensaje
    key_words = fit_key_with_message(message)
    numeric_message = string_to_ascii(message)
    numeric_key_words = string_to_ascii(key_words)
    added_arrays = add_two_adjusted_arrays(numeric_message, numeric_key_words)
    ascii_values_to_string(added_arrays)
  end

end