class Showing < ActiveRecord::Base
    belongs_to :movie
    has_many :tickets

    def sold_out?
        return true if self.tickets.count == 0 

        false 
    end 
end
