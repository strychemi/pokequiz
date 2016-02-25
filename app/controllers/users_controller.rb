class UsersController < ApplicationController

  def index
    @activities = Activity.all.order("created_at DESC").limit(10)
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end

  # TODO: welcome email
  def create
    @user = User.new( user_params )
    if @user.save
      flash[:success] = "Thanks for signing up!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Oops... please correct errors and try again."
      render :new
    end
  end


  def edit
  end


  def update
    if current_user.update( user_params )
      flash[:success] = "User information updated!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Oops... please correct errors and try again."
      render :edit
    end
  end


  def destroy
    if current_user.destroy
      flash[:success] = "User destroyed!"
      redirect_to root_path
    else
      flash[:danger] = "Could not destroy user!"
      redirect :back
    end
  end


  private

  def user_params
    # TODO: update necessary params based on backend
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 profile_attributes: [:first_name, :last_name, :pokemon_id, :type_id, :id, :username])
  end

end
