class Manager < ActiveRecord::Base
    #bcrypt not needed 
    has_secure_password
    
    validates_presence_of :username
    validates_presence_of :password
end
