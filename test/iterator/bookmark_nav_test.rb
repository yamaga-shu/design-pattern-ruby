# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/bookmark_nav'

class BookmarkNavTest < Minitest::Test
  def setup
    @bookmark_nav = BookmarkNav.new
  end

  def test_can_append_bookmark
    index = @bookmark_nav.append_bookmark Bookmark.new('https://youtube.com', 'Youtube')

    assert_kind_of Integer, index
  end
end
