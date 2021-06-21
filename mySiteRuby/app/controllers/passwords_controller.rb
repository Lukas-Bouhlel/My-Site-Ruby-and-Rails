class PasswordsController < ApplicationController
    
    skip_before_action :only_signed_in
    before_action :only_signed_out

    def new
    end

    def create
        user_params = params.require(:user)
        @user = User.find_by_email(user_params[:email])
        if @user
            @user.regenerate_recover_password
            UserMailer.password(@user).deliver_now
            redirect_to new_password_path, success: 'Un email vous a été envoyé'
        else
            redirect_to new_password_path, danger: 'Aucun utilisateur ne correspond à cet email'
        end
    end

    def edit
        @user = User.find(params[:id])
        if @user.recover_password != params[:token]
            redirect_to new_password_path, danger: 'Token invalide'
        end
    end

    def update
        user_params = params.require(:user).permit(:password, :password_confirmation, :recover_password)
        @user = User.find(params[:id])
        if @user.recover_password === user_params[:recover_password]
            @user.assign_attributes(user_params)
            if @user.valid? 
                @user.recover_password = nil
                @user.save
                session[:auth] = @user.to_session
                redirect_to profil_path, success: 'Votre mot de passe à bien été modifié'
            else
                render :edit
            end
        else
            redirect_to new_password_path, danger: 'Token invalide'
        end
    end

end