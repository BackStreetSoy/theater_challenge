class Customer < ActiveRecord::Base
    has_many :orders
    validates :email, :name, :credit_card_number, :card_expiration_day, :card_expiration_month, :card_expiration_year, presence: true 

    validates :email, :credit_card_number, uniqueness: true 



    def self.valid_visa?(card_number)
        if /\A4[0-9]{12}(?:[0-9]{3})?\z/ === card_number.to_s
            return true 
        else 
            return "please enter valid card number"
        end 
    end 

    def self.valid_mastercard?(card_number)
        if /\A5[1-5][0-9]{14}\z/ === card_number.to_s
            return true 
        else 
            return "please enter valid card number"
        end 
    end 

    def self.valid_amex?(card_number)
        if /\A3[47][0-9]{13}\z/ === card_number.to_S
            return true 
        else 
            return "please enter valid card number"
        end 
    end 

    def self.valid_discover?(card_number)
        if /\A6(?:011|5[0-9]{2})[0-9]{12}\z/ === card_number.to_s
            return true 
        else 
            return "please enter valid card number"
        end 
    end 


    def self.card_expired?(card_exp_day, card_exp_month, card_exp_year)
        return true if card_exp_day <= Time.now.day && card_exp_month <= Time.now.month && card_exp_year <= Time.now.year

        false
    end
end
