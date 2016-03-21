class Ticket < ActiveRecord::Base
    belongs_to :showing
    has_one :order
    has_one :customer, through: :order
end
