require "test_helper"

class ConfigTest < MiniTest::Test
  def test_sets_an_environment
    assert_equal :test, Qrier.environment
  end
end
