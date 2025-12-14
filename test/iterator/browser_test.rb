# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/browser'
require_relative '../../lib/iterator/bookmark_nav'
require_relative '../../lib/iterator/bookmark'

class BrowserTest < Minitest::Test
  def setup
    @browser = Browser.new
  end

  def test_can_open_bookmark_nav
    bookmark_nav = @browser.open_bookmark_nav

    assert_instance_of BookmarkNav, bookmark_nav
  end

  def test_opened_bookmark_nav_is_empty
    bookmark_nav = @browser.open_bookmark_nav

    assert_equal 0, bookmark_nav.get_length
  end

  def test_opened_bookmark_nav_is_usable
    bookmark_nav = @browser.open_bookmark_nav
    bookmark = Bookmark.new('https://example.com', 'Example')

    index = bookmark_nav.append_bookmark(bookmark)

    assert_equal 0, index
    assert_equal 1, bookmark_nav.get_length
  end

  def test_multiple_browsers_independent
    browser1 = Browser.new
    browser2 = Browser.new

    bookmark_nav1 = browser1.open_bookmark_nav
    bookmark_nav2 = browser2.open_bookmark_nav

    bookmark_nav1.append_bookmark(Bookmark.new('https://site1.com', 'Site 1'))

    assert_equal 1, bookmark_nav1.get_length
    assert_equal 0, bookmark_nav2.get_length
  end

  def test_browser_workflow
    bookmark_nav = @browser.open_bookmark_nav

    # Add some bookmarks
    bookmark_nav.append_bookmark(Bookmark.new('https://ruby-lang.org', 'Ruby'))
    bookmark_nav.append_bookmark(Bookmark.new('https://github.com', 'GitHub'))
    bookmark_nav.append_bookmark(Bookmark.new('https://stackoverflow.com', 'StackOverflow'))

    assert_equal 3, bookmark_nav.get_length

    # Iterate through bookmarks
    iterator = bookmark_nav.iterator
    count = 0

    while iterator.has_next?
      bookmark = iterator.next
      assert_instance_of Bookmark, bookmark
      assert_instance_of String, bookmark.get_url
      assert_instance_of String, bookmark.get_disp_name
      count += 1
    end

    assert_equal 3, count
  end
end
