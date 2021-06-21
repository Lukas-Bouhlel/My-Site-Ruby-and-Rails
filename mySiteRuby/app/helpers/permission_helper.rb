module PermissionHelper

    def isAdmin?
        user_signed_in? && current_user.role === 'admin'
    end

end