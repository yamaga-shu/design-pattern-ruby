require 'minitest/autorun'

class SampleTest < Minitest::Test
  def test_sample_assertion
    assert_equal 4, 2 + 2
  end

  def test_string_assertion
    assert_equal 'hello', 'hello'
  end

  def test_array_inclusion
    assert_includes [1, 2, 3], 2
  end
end
