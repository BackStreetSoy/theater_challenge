module SessionsHelper

        def login(manager)
            session[:manager_id] = manager.id
        end 

        def current_manager
            @current_manager ||= Manager.find_by(id: session[:manager_id])
        end 

        def logged_in?
            !current_user.nil?
        end 

        def log_out
            session.delete(:manager_id)
            @current_manager = nil 
        end 

        def authorize
            redirect_to '/admin-login' unless current_manager
        end 
end 