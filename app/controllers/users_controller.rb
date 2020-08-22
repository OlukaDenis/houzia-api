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


  private

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
