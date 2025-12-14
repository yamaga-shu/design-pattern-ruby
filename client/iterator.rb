# frozen_string_literal: true

require_relative '../lib/iterator/browser'
require_relative '../lib/iterator/bookmark'

# Client code demonstrating the Iterator pattern
browser = Browser.new
bookmark_nav = browser.open_bookmark_nav

# Append some bookmarks
bookmark_nav.append_bookmark(Bookmark.new('https://www.google.com', 'Google'))
bookmark_nav.append_bookmark(Bookmark.new('https://www.github.com', 'GitHub'))
bookmark_nav.append_bookmark(Bookmark.new('https://www.ruby-lang.org', 'Ruby'))
bookmark_nav.append_bookmark(Bookmark.new('https://www.wikipedia.org', 'Wikipedia'))

puts "Total bookmarks: #{bookmark_nav.get_length}"
puts "\nIterating through bookmarks:"

# Use iterator to traverse bookmarks
iterator = bookmark_nav.iterator
while iterator.has_next?
  bookmark = iterator.next
  puts "  - #{bookmark.get_disp_name}: #{bookmark.get_url}"
end
