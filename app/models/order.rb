class Order < ActiveRecord::Base
    belongs_to :movie
    belongs_to :customer 
end
