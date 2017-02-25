class WikisController < ApplicationController
  after_action :verify_authorized, only: [:destroy]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was created."
      redirect_to @wiki
    else
      flash.now[:alert] = "Wiki was unable to save. Please try again."
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user = current_user
    # authorize @wiki
    #
    # if @wiki.update_attributes(permitted_attributes(@wiki))
    #   flash[:notice] = "Wiki was updated."
    #   redirect_to @wiki
    # else
    #   flash.now[:alert] = "You cannot update this wiki. Please try again."
    #   render :edit
    # end
    #
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "Wiki was unable to save. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "#{@wiki.title} was deleted successfully."
      redirect_to wikis_path
    else
      flash[:alert] = "Failed to delete the wiki. Please try again."
      render :show
    end
  end

  def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to wikis_path
     end
   end

end
