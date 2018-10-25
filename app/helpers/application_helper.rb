module ApplicationHelper
  $base_title = "Revground"

  def full_title(page_title="")
    (page_title.blank?) ? $base_title : "#{page_title} | #{$base_title}"
  end

end
