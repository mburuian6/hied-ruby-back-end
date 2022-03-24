class UsersController < ApplicationController

  skip_before_action :doorkeeper_authorize!, only: [:create]
  
  def create
    user = User.new(
      email: user_params[:email],
      password: user_params[:password],
      username: user_params[:password]
    )
    client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

    return render(json: { error: 'Unauthorized app'}, status: 403) unless client_app

    if user.save
      # create access token for the user, so the user won't need to login again after reg
      access_token = Doorkeeper::AccessToken.create(
        resource_owner_id: user.id,
        application_id: client_app.id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: ''
      )

      # return json containing access token and refresh token
      # so that user won't need to call login API right after registration
      render(json: {
               id: user.id,
               email: user.email,
               username: user.username,
               access_token: access_token.token,
               token_type: 'bearer',
               expires_in: access_token.expires_in,
               refresh_token: access_token.refresh_token,
               created_at: access_token.created_at.to_time.to_i
             })
    else
      puts user.errors.full_messages.to_sentence.downcase
      # log the error
      render(json: { error: 'Unprocessable entity' }, status: 422)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :username, :client_id, :user)
  end

  def generate_refresh_token
    loop do
      # generate a random token string and return it,
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

end