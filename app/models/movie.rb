class Movie < ActiveRecord::Base
    belongs_to :auditorium,  inverse_of: :movie
    has_many :showings
    has_many :tickets, through: :showings
    has_many :orders
    has_many :audience_members, through: :orders, source: :customer
    validates_presence_of :runtime, :synopsis, :title
    validates :runtime, :inclusion => {:in => 1..3}
    after_create :load_showtimes, :load_tickets


#calculates total of ticket sales
    def total_earned
        totals = []

        self.orders.each do |order|
                totals << order.total_price
        end 

        return totals.inject{ |sum, n| sum + n } 
    end

#places a movie into an auditorium
    def set_movie(auditorium)
            @movie = Movie.find(self.id)

        if auditorium.movie != nil
            auditorium.remove_movie
            auditorium.update_attributes!(movie: self)
            self.auditorium = auditorium
        else 
            auditorium.movie = self

            self.update_attributes!(auditorium: auditorium)
        end 

        self.load_tickets
        self.save
    end 

#loads ticekts into the showing for the movie
    def load_tickets
        if self.auditorium != nil 
            self.showings.each do |showing|
                self.auditorium.seat_count.times do 
                        showing.tickets << Ticket.create!(price: 7.30, showing: showing)
                 end 
            end 

             self.status = "playing" 
             self.save!
        end 
    end


    private

#automatic load of showtimes based off of runtime
        def load_showtimes
            available_times = {
             10.45 => "10:45am", 11.00 => "11:00am", 11.15 => "11:15am", 11.30 => "11:30am",11.45 => "11:45am", 12.00 => "12:00pm", 12.15 => "12:15pm", 12.30 => "12:30pm", 12.45 => "12:45pm", 
             13.00 => "1:00pm", 13.15 => "1:15pm", 13.30 => "1:30pm",13.45 => "1:45pm",14.00 => "2:00pm",14.15 => "2:15pm",14.30 => "2:30pm", 14.45 => "2:45pm", 15.00 => "3:00pm",15.15 => "3:15pm",16.00 => "4:00pm", 16.15 => "4:15pm", 16.30 => "4:30pm", 16.45 => "4:45pm", 17.00 => "5:00pm",17.15 => "5:15pm", 17.30 => "5:30pm",17.45 => "5:45pm",18.00 => "6:00pm", 18.15 => "6:15pm", 18.30 => "6:30pm", 18.45 => "6:45pm", 19.00 => "7:00pm", 19.15 => "7:15pm", 19.30 => "7:30pm", 19.45 => "7:45pm", 20.00 => "8:00pm", 20.15 => "8:15pm", 20.30 => "8:30pm", 20.45 => "8:45pm", 21.00 => "9:00pm", 21.15 => "9:15pm", 21.30 => "9:30pm", 
             22.00 => "10:00pm", 22.15 => "10:15pm", 22.30 => "10:30pm", 22.45 => "10:45pm", 23.00=> "11:00pm", 23.15 => "11:15pm", 
             23.30 => "11:30pm", 23.45 => "11:45pm",24.00 => "12:00am"}



             showtimes = [10.45]

            if self.runtime >= 1.33 && self.runtime <= 1.5
                showtimes << 12.30 << 14.00 << 15.30 << 17.00 << 18.30 << 20.00 << 21.30 << 23.00

            elsif self.runtime >= 1.5 && self.runtime <= 2 
                showtimes << 13.00 << 15.00 << 17.00 << 19.00 << 21.00 << 23.00 << 24.00

            elsif self.runtime >= 2 && self.runtime <= 3
                showtimes << 14.15 << 17.15 << 21.15 << 24.00
            end 



            showtimes.map! do |time|
                time = Showing.create!(military_time: time.to_f, time_string: available_times[time], movie: self)
            end

            self.showings = showtimes
        end

     

   

end
