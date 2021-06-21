class UsersController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create, :confirm]
  before_action :only_signed_out, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    @user.recover_password = nil
    if @user.valid?
      @user.save
      UserMailer.confirm(@user).deliver_now
      redirect_to new_user_path, success: 'Votre compte à bien été créer, vous devriez recevoir un email pour confirmer votre compte'
    else
      render 'new'
    end   
  end

  def confirm 
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      @user.save(validate: false)
      @user.update(confirmed: true, confirmation_token: nil)
      session[:auth] = @user.to_session
      redirect_to profil_path, success: 'Votre compte a bien été confirmé'
    else
      redirect_to new_user_path, danger: 'Ce token ne semble pas valide'
    end 
  end

  def edit 
    @user = current_user
  end

  def update 
    @user = current_user
    user_params = params.require(:user).permit(:name, :email, :firstname, :lastname, :avatar_file, :password, :password_confirmation, :motto)
    if @user.update(user_params)
      redirect_to profil_path, success: 'Votre compte a bien été mis à jour !'
    else
      render :edit
    end
  end

end