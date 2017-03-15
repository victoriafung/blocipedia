class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
    @users = User.all
  end

  def create
    @collaborator = Collaborator.new
    @wiki = params[:wiki_id]
    # @collaborator.wiki_id = params[:wiki_id]
    @collaborator.user_id = params['collaborator'][:user_id]
    @collaborator.wiki_id = params['collaborator'][:wiki_id]

    if @collaborator.save
      flash[:notice] = 'Collaborator added'
      redirect_to wiki_path(@wiki)

    else
      flash[:notice] = 'This is not a valid user'
      redirect_to wiki_path(@wiki)
    end
  end

  def destroy
    @collaborator = Collaborator.find(params['collaborator'][:user_id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed from wiki."
      redirect_to wiki_path(@wiki.id)
    else
      flash[:error] = "Collaborator could not be removed."
      redirect_to wiki_path(@wiki.id)
    end
  end

end
