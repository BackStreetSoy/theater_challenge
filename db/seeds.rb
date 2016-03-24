# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

showtimes_as_strings_and_integers = {
     10.45 => "10:45am", 
     11.00 => "11:00am", 
     11.15 => "11:15am", 
     11.30 => "11:30am", 
     11.45 => "11:45am", 
     12.00 => "12:00pm", 
     12.15 => "12:15pm", 
     12.30 => "12:30pm", 
     12.45 => "12:45pm", 
     13.00 => "1:00pm", 
     13.15 => "1:15pm", 
     13.30 => "1:30pm", 
     13.45 => "1:45pm", 
     14.00 => "2:00pm",  
     14.15 => "2:15pm", 
     14.30 => "2:30pm", 
     14.45 => "2:45pm", 
     15.00 => "3:00pm", 
     15.15 => "3:15pm", 
     16.00 => "4:00pm", 
     16.15 => "4:15pm", 
     16.30 => "4:30pm", 
     16.45 => "4:45pm", 
     17.00 => "5:00pm", 
     17.15 => "5:15pm", 
     17.30 => "5:30pm", 
     17.45 => "5:45pm", 
     18.00 => "6:00pm", 
     18.15 => "6:15pm", 
     18.30 => "6:30pm", 
     18.45 => "6:45pm", 
     19.00 => "7:00pm", 
     19.15 => "7:15pm", 
     19.30 => "7:30pm", 
     19.45 => "7:45pm", 
     20.00 => "8:00pm", 
     20.15 => "8:15pm", 
     20.30 => "8:30pm", 
     20.45 => "8:45pm", 
     21.00 => "9:00pm", 
     21.15 => "9:15pm", 
     21.30 => "9:30pm", 
     22.00 => "10:00pm", 
     22.15 => "10:15pm", 
     22.30 => "10:30pm", 
     22.45 => "10:45pm", 
     23.00 => "11:00pm", 
     23.15 => "11:15pm", 
     23.30 => "11:30pm", 
     23.45 => "11:45pm", 
     24.00 => "12:00am"}


10.times do 
    Movie.create(title: Faker::Lorem.words(2).join(" "), synopsis: Faker::Lorem.sentence, image: Faker::Avatar.image,  runtime: (rand(80.0..180.0) / 60.0).round(2))
end 

num = 1 
Movie.all.each do |movie|
    movie.auditorium = Auditorium.create!(number: num, seat_count: 50, movie: movie)
    num += 1
end 

Movie.all.each do |movie|
    showtimes = [10.45]


#movie runtimes have to be at least 80 minutes and can't be longer than 3 hours

    if movie.runtime >= 1.33 && movie.runtime <= 1.5
        showtimes << 12.30 << 14.00 << 15.30 << 17.00 << 18.30 << 20.00 << 21.30 << 23.00

    elsif movie.runtime >= 1.5 && movie.runtime <= 2 
        showtimes << 13.00 << 15.00 << 17.00 << 19.00 << 21.00 << 23.00

    elsif movie.runtime >= 2 && movie.runtime <= 3
        showtimes << 14.15 << 17.15 << 21.15 
    end 


    showtimes.map! do |time|
        time = Showing.new(military_time: time.to_f, time_string: showtimes_as_strings_and_integers[time], movie: movie)
    end

    movie.showings = showtimes
end 

Showing.all.each do |showing|
    showing.movie.auditorium.seat_count.times do 
        showing.tickets << Ticket.new(price: 7.30, showing: showing)
    end 

end 

theater = Theater.create!(name: "Ultimate Theater")
theater.auditoriums = Auditorium.all

