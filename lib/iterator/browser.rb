# frozen_string_literal: true

require_relative 'bookmark_nav'

# Browser represents WebBrowsesr which has bookmark navigation
class Browser
  def open_bookmark_nav
    BookmarkNav.new
  end
end
