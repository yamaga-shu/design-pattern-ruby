# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/bookmark'

class BookmarkTest < Minitest::Test
  def setup
    @bookmark = Bookmark.new('https://example.com', 'Example Site')
  end

  def test_initialize_with_url_and_disp_name
    assert_equal 'https://example.com', @bookmark.url
    assert_equal 'Example Site', @bookmark.disp_name
  end

  def test_get_url
    assert_equal 'https://example.com', @bookmark.get_url
  end

  def test_get_disp_name
    assert_equal 'Example Site', @bookmark.get_disp_name
  end

  def test_url_is_accessible
    assert_respond_to @bookmark, :url
    assert_instance_of String, @bookmark.url
  end

  def test_disp_name_is_accessible
    assert_respond_to @bookmark, :disp_name
    assert_instance_of String, @bookmark.disp_name
  end

  def test_url_can_be_modified
    new_url = 'https://newexample.com'
    @bookmark.url = new_url

    assert_equal new_url, @bookmark.url
    assert_equal new_url, @bookmark.get_url
  end

  def test_disp_name_can_be_modified
    new_name = 'New Site Name'
    @bookmark.disp_name = new_name

    assert_equal new_name, @bookmark.disp_name
    assert_equal new_name, @bookmark.get_disp_name
  end

  def test_multiple_bookmarks_are_independent
    bookmark1 = Bookmark.new('https://site1.com', 'Site 1')
    bookmark2 = Bookmark.new('https://site2.com', 'Site 2')

    assert_equal 'https://site1.com', bookmark1.url
    assert_equal 'https://site2.com', bookmark2.url
    assert_equal 'Site 1', bookmark1.disp_name
    assert_equal 'Site 2', bookmark2.disp_name
  end

  def test_bookmark_with_special_characters
    special_bookmark = Bookmark.new(
      'https://example.com/search?q=ruby&lang=en',
      'Ruby Search & Results'
    )

    assert_equal 'https://example.com/search?q=ruby&lang=en', special_bookmark.url
    assert_equal 'Ruby Search & Results', special_bookmark.disp_name
  end
end
