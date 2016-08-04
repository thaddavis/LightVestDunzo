class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
    # was only: [:index, :edit, :update, :destroy]
  before_action :correct_user, except: [:new, :create]
    # was only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      flash[:info] = "You are already logged in."
      redirect_to user_path(current_user)
    end

    @user = User.new
    @plans = Plan.all
  end

  def create
    @user = User.new(user_params)
    @plans = Plan.all

    if @user.save

      CreateStripeCustomer.call(params[:plan], @user.email, params[:stripeToken])

      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :username)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
