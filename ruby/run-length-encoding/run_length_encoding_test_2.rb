require 'minitest/autorun'
require_relative 'run_length_encoding'

# Common test data version: 1.0.0 503a57a
class RunLengthEncodingTest < Minitest::Test
  def test_decode_string_with_no_single_characters
    input = '2A3B4C'
    output = 'AABBBCCCC'
    assert_equal output, RunLengthEncoding.decode(input)
  end
end
