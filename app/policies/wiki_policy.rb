class WikiPolicy
  attr_reader :user, :wiki

  def initalize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user.admin? || wiki.user == @current_user
  end
end
