# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/browser'

class BrowserTest < Minitest::Test
  def setup
    @browser = Browser.new
  end

  def test_can_open_bookmark_nav
    bookmark_nav = @browser.open_bookmark_nav

    assert_instance_of BookmarkNav, bookmark_nav
  end
end
