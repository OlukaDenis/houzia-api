class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.admin = true if @user.email == 'admin@gmail.com'
    if @user.save!
      auth_token = AuthenticateUser.new(@user.email, @user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end
  end

  def show
    @result = ''
    if current_user.admin?
      @houses = House.all
      @result = admin_profile(@houses)
    else
      @favorites = current_user.favorites.preload(:house)
      @result = user_profile(@favorites)
    end
    json_response(@result)
  end


  private

    def admin_profile(houses)
      fav = houses.reject { |el| el.favorites.empty? }
      expense = fav.sum(&:price)
      result = {
        profile: current_user,
        favorites: fav,
        expense: expense
      }
      result
    end

    def user_profile(favorites)
      fav = favorites.collect(&:house)
      expense = fav.sum(&:price)
      result = {
        details: current_user,
        favorites: fav,
        expense: expense
      }
      result
    end

    def user_params
      params.permit(
        :username,
        :email,
        :image,
        :admin,
        :password,
        :password_confirmation
      )
    end
end
