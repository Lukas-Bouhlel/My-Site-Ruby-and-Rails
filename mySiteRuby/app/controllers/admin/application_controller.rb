module Admin

    class ApplicationController < ::ApplicationController
        
        #layout 'admin'
        before_action :only_admin

        private

        def only_admin
            if !user_signed_in? || current_user.role != 'admin'
                redirect_to new_user_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
            end
        end

    end

end    