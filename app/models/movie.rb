class Movie < ActiveRecord::Base
    belongs_to :auditorium
    has_many :showings
    has_many :tickets, through: :showings
    has_many :orders, through: :tickets
    has_many :audience_members, through: :orders, source: :customer
end
