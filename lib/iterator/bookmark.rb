# frozen_string_literal: true

# Bookmark holds a pair of URL and display name
class Bookmark
  attr_accessor :url, :disp_name

  def initialize(url, disp_name)
    @url = url
    @disp_name = disp_name
  end
end
