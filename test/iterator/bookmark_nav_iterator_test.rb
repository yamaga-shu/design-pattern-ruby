# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/iterator/bookmark_nav_iterator'
require_relative '../../lib/iterator/bookmark_nav'
require_relative '../../lib/iterator/bookmark'

class BookmarkNavIteratorTest < Minitest::Test
  def setup
    @bookmark_nav = BookmarkNav.new
    @bookmark1 = Bookmark.new('https://site1.com', 'Site 1')
    @bookmark2 = Bookmark.new('https://site2.com', 'Site 2')
    @bookmark3 = Bookmark.new('https://site3.com', 'Site 3')
  end

  def test_initialize_with_bookmark_nav
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_instance_of BookmarkNavIterator, iterator
  end

  def test_has_next_on_empty_nav
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_equal false, iterator.has_next?
  end

  def test_has_next_with_bookmarks
    @bookmark_nav.append_bookmark(@bookmark1)
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_equal true, iterator.has_next?
  end

  def test_next_returns_bookmark
    @bookmark_nav.append_bookmark(@bookmark1)
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    bookmark = iterator.next
    assert_instance_of Bookmark, bookmark
    assert_equal @bookmark1, bookmark
  end

  def test_iteration_through_multiple_bookmarks
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)

    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_equal true, iterator.has_next?
    assert_equal @bookmark1, iterator.next
    assert_equal true, iterator.has_next?
    assert_equal @bookmark2, iterator.next
    assert_equal true, iterator.has_next?
    assert_equal @bookmark3, iterator.next
    assert_equal false, iterator.has_next?
  end

  def test_next_raises_stop_iteration_when_exhausted
    @bookmark_nav.append_bookmark(@bookmark1)
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    iterator.next
    assert_raises(StopIteration) { iterator.next }
  end

  def test_next_on_empty_raises_stop_iteration
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_raises(StopIteration) { iterator.next }
  end

  def test_index_increments_correctly
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)

    iterator = BookmarkNavIterator.new(@bookmark_nav)

    iterator.next
    # After first next, should be at index 1
    assert_equal @bookmark2, iterator.next
  end

  def test_iterator_reset_on_new_instance
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)

    iterator1 = BookmarkNavIterator.new(@bookmark_nav)
    iterator1.next

    iterator2 = BookmarkNavIterator.new(@bookmark_nav)
    assert_equal true, iterator2.has_next?
    assert_equal @bookmark1, iterator2.next
  end

  def test_multiple_sequential_iterations
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)

    # First iteration
    iterator1 = BookmarkNavIterator.new(@bookmark_nav)
    first_iteration_count = 0
    while iterator1.has_next?
      iterator1.next
      first_iteration_count += 1
    end

    # Second iteration
    iterator2 = BookmarkNavIterator.new(@bookmark_nav)
    second_iteration_count = 0
    while iterator2.has_next?
      iterator2.next
      second_iteration_count += 1
    end

    assert_equal 2, first_iteration_count
    assert_equal 2, second_iteration_count
  end

  def test_iteration_with_single_bookmark
    @bookmark_nav.append_bookmark(@bookmark1)
    iterator = BookmarkNavIterator.new(@bookmark_nav)

    assert_equal true, iterator.has_next?
    bookmark = iterator.next
    assert_equal @bookmark1, bookmark
    assert_equal false, iterator.has_next?
  end

  def test_can_collect_all_bookmarks_in_array
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)

    iterator = BookmarkNavIterator.new(@bookmark_nav)
    collected = []

    collected << iterator.next while iterator.has_next?

    assert_equal 3, collected.length
    assert_equal [@bookmark1, @bookmark2, @bookmark3], collected
  end

  def test_has_next_after_partial_iteration
    @bookmark_nav.append_bookmark(@bookmark1)
    @bookmark_nav.append_bookmark(@bookmark2)
    @bookmark_nav.append_bookmark(@bookmark3)

    iterator = BookmarkNavIterator.new(@bookmark_nav)

    iterator.next
    assert_equal true, iterator.has_next?

    iterator.next
    assert_equal true, iterator.has_next?

    iterator.next
    assert_equal false, iterator.has_next?
  end
end
