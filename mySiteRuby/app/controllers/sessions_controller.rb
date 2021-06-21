class SessionsController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]
  
  def new
  end

  def create
    user_params = params.require(:user)
    @user = User.where(name: user_params[:name]).or(User.where(email: user_params[:name])).first
    if @user and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: 'Connexion réussie'
    else
      redirect_to new_session_path, danger: 'Identifiants incrorrects'
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: 'Vous êtes maintenant déconnecté'
  end

end
