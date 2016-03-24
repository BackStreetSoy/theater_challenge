class Auditorium < ActiveRecord::Base
    belongs_to :theater
    has_one :movie
    has_many :showings, through: :movie
end
