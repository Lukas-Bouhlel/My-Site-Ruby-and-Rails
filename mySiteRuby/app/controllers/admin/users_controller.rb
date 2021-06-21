module Admin

    class UsersController < ApplicationController

        before_action :set_users, only: [:update, :edit, :destroy]

        def index
            @users = User.all
        end

        def new
            @users = User.new
        end

        def create
            @users = User.new(users_params)
            if @users.save
                redirect_to({action: :index}, success: 'L\'utilisateur à bien été créer')
            else 
                render :new
            end
        end

        def edit

        end

        def update
            if @users.update(users_params)
                redirect_to({action: :index}, success: 'L\'utilisateur à bien été modifiée')
            else 
                render :new
            end
        end

        def destroy 
            @users.destroy
            redirect_to({action: :index}, success: 'L\'utilisateur à bien été supprimée')
        end

        private

        def users_params
            params.require(:user).permit(:name, :email, :firstname, :lastname, :avatar_file, :password, :password_confirmation, :motto)
        end

        def set_users
            @users = User.find(params[:id])
        end

    end

end