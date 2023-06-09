require_relative 'vigenere'

class VigenereENG < Vigenere
  def initialize(*args)
    super
    @abc_length = 26
  end
  
  def string_to_ascii(string)
    # Convierte un string a una cadena de enteros
    # en sus valores por defecto en el idioma Ingles
    string = string.split('')
    string.map { |char| char.ord - 65 }
  end

  def ascii_values_to_string(array)
    # Convierte una cadena de enteros a string en ingles)
    string = array.map { |value|
      value += 65
      value.chr(Encoding::UTF_8)
    }
    string.join
  end
end
