module WikisHelper
  def user_is_authorized_for_wiki?
    current_user || (current_user == wiki.user || current_user.admin? )
  end

  # def markdown_html(text)
  #   renderer = Redcarpet::Render::HTML.new
  #   extensions = {safe_links_only: true, strikethrough: true}
  #   markdown = Redcarpet::Markdown.new(renderer, extensions)
  # end

end
