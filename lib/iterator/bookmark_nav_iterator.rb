# frozen_string_literal: true

# BookmarkNavIterator iterates through BookmarkNav
class BookmarkNavIterator
  def initialize(bookmark_nav)
    @bookmark_nav = bookmark_nav
    @index = 0
  end

  def has_next?
    @index < @bookmark_nav.get_length
  end

  def next
    raise StopIteration, 'No more bookmarks' unless has_next?

    bookmark = @bookmark_nav.get_bookmark_at(@index)
    @index += 1
    bookmark
  end
end
