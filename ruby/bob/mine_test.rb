require 'minitest/autorun'
require_relative 'bob'

# Common test data version: 1.0.0 65756b1
class BobTest < Minitest::Test
  def test_non_question_ending_with_whitespace
    assert_equal "WATCH OUT", Bob.remark_without_last_character("WATCH OUT!")
  end

  def test_remove_punctuation_1
    assert_equal "123", Bob.remove_punctuation("1, 2, 3")
  end

  def test_all_digits_1
    assert_equal true, Bob.all_digits?("123")
  end

  def test_all_punctuation_1
    assert_equal true, Bob.all_punctuation?(":) ")
  end

  def test_silence_1
    assert_equal true, Bob.silence?("")
  end

  def test_remove_whitespace_1
    assert_equal "Thisisastatementendingwithwhitespace", Bob.remove_punctuation("This is a statement ending with whitespace      ")
  end
end
