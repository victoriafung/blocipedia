class WikisController < ApplicationController
  after_action :verify_authorized, only: [:destroy]

  def index
    if user_can_view_private_wiki?
      @wikis = Wiki.all
    else
      @wikis = Wiki.public?
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.user_id = current_user.id

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

   private

   def user_can_view_private_wiki?
     #might need to add logic if the user is signed in...
     (current_user.admin? || current_user.premium?)
   end
end
