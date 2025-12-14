# frozen_string_literal: true

require_relative 'bookmark'

# BookmarkNav represents bookmark navigation of web browser
class BookmarkNav
  attr_reader :bookmarks

  def initialize
    @bookmarks = []
  end

  def append_bookmark(bookmark)
    # append bookmark
    @bookmarks << bookmark

    # return appended index
    @bookmarks.length - 1
  end
end
