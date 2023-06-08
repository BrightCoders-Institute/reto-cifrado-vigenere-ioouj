require "minitest/autorun"
require_relative "main"

class TestVigenere < Minitest::Test
  def setup
    @cipher_esp = Vigenere.new('ESP', 'SECRETO')
    # @cipher_eng = Vigenere.new('ENG')
  end

  def test_fit_key_with_single_word
    assert_equal 'SECR', @cipher_esp.fit_key_with_single_word('HOLA')
    assert_equal 'SECRETO', @cipher_esp.fit_key_with_single_word('HOLAHOL')
    assert_equal 'SECRETOSE', @cipher_esp.fit_key_with_single_word('HOLAHOLAH')
    assert_equal 'SECRET', @cipher_esp.fit_key_with_single_word('ÑAÑAÑA')
  end

  def test_fit_key_with_message
    assert_equal 'SECR', @cipher_esp.fit_key_with_message('HOLA')
    assert_equal 'SECRETO SECRE', @cipher_esp.fit_key_with_message('MENSAJE LARGO')
    assert_equal 'S E C R E T', @cipher_esp.fit_key_with_message('A B C D E F')
    assert_equal 'SE CR', @cipher_esp.fit_key_with_message('ÑA ÑA')
  end

  def test_string_to_ascii
    assert_equal [7,14,15,11,0], @cipher_esp.string_to_ascii('HÑOLA')
    assert_equal [19,4,2,18,4,20,15], @cipher_esp.string_to_ascii('SECRETO')
    assert_equal [7,-33,15,-33,11,-33,0], @cipher_esp.string_to_ascii('H O L A')
    assert_equal [14,0,-33,14,0], @cipher_esp.string_to_ascii('ÑA ÑA')
  end

  def test_add_two_adjusted_arrays
    assert_equal [6,6,6,6,6], @cipher_esp.add_two_adjusted_arrays([1,2,3,4,5], [5,4,3,2,1])
  end

  def test_ascii_values_to_string
    assert_equal 'HOLA', @cipher_esp.ascii_values_to_string([7,15,11,0])
    assert_equal 'H O L A', @cipher_esp.ascii_values_to_string([7,-33,15,-33,11,-33,0])
    assert_equal 'HÑOLA', @cipher_esp.ascii_values_to_string([7,14,15,11,0])

  end

  def test_cipher
    assert_equal 'ZSNR', @cipher_esp.cipher('HOLA')
    
                                                 # SECR ETOSE
    assert_equal 'AZCE WBZÑE', @cipher_esp.cipher('IVAN SILVA')
  end

end