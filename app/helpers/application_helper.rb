# encoding: UTF-8
module ApplicationHelper

  def default_title
    "CoderDojo San Francisco"
  end

  def title (page_title)
    title = default_title()
    if (title)
      title = page_title.to_s + ' · ' + title
    end
    content_for :title, title
  end

end
