class UserMailer < ApplicationMailer

    def confirm(user)
        @user = user
        mail(to: user.email, subject: 'Votre inscription sur le site' + Rails.application.config.site[:name] )
    end

    def password(user)
        @user = user
        mail(to: user.email, subject: 'Rénitialisation de votre mot de passe' + Rails.application.config.site[:name] )
    end
    
end
