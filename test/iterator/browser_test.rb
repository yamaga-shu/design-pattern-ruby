# frozen_string_literal: true

require 'minitest/autorun'

class BrowserTest < Minitest::Test
  def test_can_create_browser
    browser = new Browser
  end
end
