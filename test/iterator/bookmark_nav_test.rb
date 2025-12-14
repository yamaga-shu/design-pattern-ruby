# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/bookmark_nav'
require_relative '../../lib/iterator/bookmark_nav_iterator'
require_relative '../../lib/iterator/bookmark'

class BookmarkNavTest < Minitest::Test
  def setup
    @bookmark_nav = BookmarkNav.new
    @bookmark1 = Bookmark.new('https://youtube.com', 'Youtube')
    @bookmark2 = Bookmark.new('https://google.com', 'Google')
    @bookmark3 = Bookmark.new('https://github.com', 'GitHub')
  end

  def test_can_append_bookmark
    index = @bookmark_nav.append_bookmark(@bookmark1)

    assert_kind_of Integer, index
    assert_equal 0, index
  end

  def test_append_multiple_bookmarks
    index1 = @bookmark_nav.append_bookmark(@bookmark1)
    index2 = @bookmark_nav.append_bookmark(@bookmark2)
    index3 = @bookmark_nav.append_bookmark(@bookmark3)

    assert_equal 0, index1
    assert_equal 1, index2
    assert_equal 2, index3
    assert_equal 3, @bookmark_nav.get_length
  end

  def test_get_bookmark_at
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)

    bookmark_at_one = @bookmark_nav.get_bookmark_at(0)
    bookmark_at_two = @bookmark_nav.get_bookmark_at(1)

    assert_equal @bookmark1, bookmark_at_one
    assert_equal @bookmark2, bookmark_at_two
  end

  def test_get_length
    assert_equal 0, @bookmark_nav.get_length

    @bookmark_nav.append_bookmark(@bookmark1)
    assert_equal 1, @bookmark_nav.get_length

    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)
    assert_equal 3, @bookmark_nav.get_length
  end

  def test_bookmarks_attribute
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)

    bookmarks = @bookmark_nav.bookmarks
    assert_instance_of Array, bookmarks
    assert_equal 2, bookmarks.length
    assert_equal @bookmark1, bookmarks[0]
    assert_equal @bookmark2, bookmarks[1]
  end

  def test_iterator_creation
    iterator = @bookmark_nav.iterator

    assert_instance_of BookmarkNavIterator, iterator
  end

  def test_iterator_iteration
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)

    iterator = @bookmark_nav.iterator
    collected_bookmarks = []

    collected_bookmarks << iterator.next while iterator.has_next?

    assert_equal 3, collected_bookmarks.length
    assert_equal @bookmark1, collected_bookmarks[0]
    assert_equal @bookmark2, collected_bookmarks[1]
    assert_equal @bookmark3, collected_bookmarks[2]
  end

  def test_iterator_stops_at_end
    @bookmark_nav.append_bookmark(@bookmark1)

    iterator = @bookmark_nav.iterator
    iterator.next

    assert_raises(StopIteration) { iterator.next }
  end

  def test_empty_iterator
    iterator = @bookmark_nav.iterator

    assert_equal false, iterator.has_next?
    assert_raises(StopIteration) { iterator.next }
  end

  def test_multiple_iterators_independent
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)

    iterator1 = @bookmark_nav.iterator
    iterator2 = @bookmark_nav.iterator

    iterator1.next
    iterator1.next

    assert_equal true, iterator1.has_next?
    assert_equal true, iterator2.has_next?
    assert_equal @bookmark1, iterator2.next
  end
end
