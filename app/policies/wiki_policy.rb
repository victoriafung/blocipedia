class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user.admin? || wiki.user == @current_user
  end

  def update?
    user.admin? || wiki.user == @current_user
  end

  def permitted_attributes
   if user.admin? || user.owner_of?(post)
     [:title, :body]     
   end
 end
end
