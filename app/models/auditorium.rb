class Auditorium < ActiveRecord::Base
    belongs_to :theater
    has_one :movie,  inverse_of: :auditorium
    has_many :showings, through: :movie
    before_destroy :remove_movie


   
   #handling associated objects
   
    def remove_movie
        self.movie.update_attributes!(status: "not playing")
        self.movie.auditorium = nil

        self.movie.showings.each do |showing|
                showing.tickets.destroy_all
        end 

     
        self.movie = nil
        self.save

    end 
end
