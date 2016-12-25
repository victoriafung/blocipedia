class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      @user.set_confirmation_token
      @user.save(validate: false)
      UserMailer.sign_up_confirmation(@user).deliver_now
      flash[:notice] = "Welcome to Blocipedia #{@user.name}, please confirm your email"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account, please try again."
      render :new
    end
  end
end
