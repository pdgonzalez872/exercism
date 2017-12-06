require 'minitest/autorun'
require_relative 'sum_of_multiples'

# Common test data version: 1.1.0 df076b2
class SumOfMultiplesTest < Minitest::Test

  def test_multiples_of_an_empty_list_up_to_10000
    assert_equal 0, SumOfMultiples.new().to(10000)
  end

  # Problems in exercism evolve over time, as we find better ways to ask
  # questions.
  # The version number refers to the version of the problem you solved,
  # not your solution.
  #
  # Define a constant named VERSION inside of the top level BookKeeping
  # module, which may be placed near the end of your file.
  #
  # In your file, it will look like this:
  #
  # module BookKeeping
  #   VERSION = 1 # Where the version number matches the one in the test.
  # end
  #
  # If you are curious, read more about constants on RubyDoc:
  # http://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/constants.html

  def test_bookkeeping
    assert_equal 2, BookKeeping::VERSION
  end
end
