# frozen_string_literal: true

require_relative 'bookmark'
require_relative 'bookmark_nav_iterator'

# BookmarkNav represents bookmark navigation of web browser
class BookmarkNav
  attr_reader :bookmarks

  def initialize(bookmarks = [])
    @bookmarks = bookmarks
    @last_index = 0
  end

  def get_bookmark_at(index)
    @bookmarks[index]
  end

  def append_bookmark(bookmark)
    # append bookmark
    @bookmarks << bookmark

    # return appended index
    @bookmarks.length - 1
  end

  def get_length
    @bookmarks.length
  end

  def iterator
    BookmarkNavIterator.new(self)
  end
end
