require_relative 'vigenere'

class VigenereESP < Vigenere
  def initialize(*args)
    super
    @abc_length = 27
  end

  def string_to_ascii(string)
    # Convierte un string a una cadena de enteros
    # representando los valores de los caracteres en ASCII.
    # Se toma en cuenta la Ñ como caracter, y se simula que se encuentra
    # dentro de los rangos  en ASCII
    string = string.split('')
    string.map { |char|
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
  end

  def ascii_values_to_string(array)
    # Convierte una cadena de enteros a string en Español (Simulado)
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
    string.join
  end

end
