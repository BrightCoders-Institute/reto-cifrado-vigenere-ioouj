require "minitest/autorun"
require_relative "vigenere"
require_relative "vigenere_esp"
require_relative "vigenere_eng"

class TestVigenere < Minitest::Test
  def setup
    @cipher = Vigenere.new('SECRETO')
    @cipher_esp = VigenereESP.new('SECRETO')
    @cipher_eng = VigenereENG.new('SECRETO')
  end

  def test_fit_key_with_single_word
    assert_equal 'SECR', @cipher.fit_key_with_single_word('HOLA')
    assert_equal 'SECRETO', @cipher.fit_key_with_single_word('HOLAHOL')
    assert_equal 'SECRETOSE', @cipher.fit_key_with_single_word('HOLAHOLAH')
    assert_equal 'SECRET', @cipher.fit_key_with_single_word('ÑAÑAÑA')
  end

  def test_fit_key_with_message
    assert_equal 'SECR', @cipher.fit_key_with_message('HOLA')
    assert_equal 'SECRETO SECRE', @cipher.fit_key_with_message('MENSAJE LARGO')
    assert_equal 'S E C R E T', @cipher.fit_key_with_message('A B C D E F')
    assert_equal 'SE CR', @cipher.fit_key_with_message('ÑA ÑA')
  end

  def test_string_to_ascii_esp
    assert_equal [7,14,15,11,0], @cipher_esp.string_to_ascii('HÑOLA')
    assert_equal [19,4,2,18,4,20,15], @cipher_esp.string_to_ascii('SECRETO')
    assert_equal [7,-33,15,-33,11,-33,0], @cipher_esp.string_to_ascii('H O L A')
    assert_equal [14,0,-33,14,0], @cipher_esp.string_to_ascii('ÑA ÑA')
  end

  def test_string_to_ascii_eng
    assert_equal [7,14,11,0], @cipher_eng.string_to_ascii('HOLA')
    assert_equal [18,4,2,17,4,19,14], @cipher_eng.string_to_ascii('SECRETO')
    assert_equal [7,-33,14,-33,11,-33,0], @cipher_eng.string_to_ascii('H O L A')
  end

  def test_add_two_adjusted_arrays_esp
    assert_equal [6,6,6,6,6], @cipher_esp.add_two_adjusted_arrays([1,2,3,4,5], [5,4,3,2,1])
    assert_equal [0,0,0], @cipher_esp.add_two_adjusted_arrays([20,20,20], [7,7,7])
  end

  def test_add_two_adjusted_arrays_eng
    assert_equal [6,6,6,6,6], @cipher_eng.add_two_adjusted_arrays([1,2,3,4,5], [5,4,3,2,1])
    assert_equal [1,1,1], @cipher_eng.add_two_adjusted_arrays([20,20,20], [7,7,7])
  end

  def test_ascii_values_to_string_esp
    assert_equal 'HOLA', @cipher_esp.ascii_values_to_string([7,15,11,0])
    assert_equal 'H O L A', @cipher_esp.ascii_values_to_string([7,-33,15,-33,11,-33,0])
    assert_equal 'HÑOLA', @cipher_esp.ascii_values_to_string([7,14,15,11,0])
  end

  def test_ascii_values_to_string_eng
    assert_equal 'HOLA', @cipher_eng.ascii_values_to_string([7,14,11,0])
    assert_equal 'ZH O L AZ', @cipher_eng.ascii_values_to_string([25,7,-33,14,-33,11,-33,0,25])
  end

  def test_cipher_esp
    assert_equal 'ZSNR', @cipher_esp.cipher('HOLA')
                                                 # SECR ETOSE
    assert_equal 'AZCE WBZÑE', @cipher_esp.cipher('IVAN SILVA')
  end

  def test_cipher_eng
                                            # SECRE
    assert_equal 'SHKFW', @cipher_eng.cipher('ADIOS')
  end

end