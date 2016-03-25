# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'


10.times do 
    Movie.create!(title: Faker::Lorem.words(2).join(" "), synopsis: Faker::Lorem.sentence, image: Faker::Avatar.image,  runtime: (rand(80.0..180.0) / 60.0).round(2), auditorium: Auditorium.create!(seat_count: 50, movie: Movie.find_by(auditorium: self)))
end 



Auditorium.all.each do |auditorium|
    movie = Movie.find_by(auditorium: auditorium)
    auditorium.update_attributes(movie_title: movie.title)
end 


theater = Theater.create!(name: "Ultimate Theater")
theater.auditoriums = Auditorium.all

