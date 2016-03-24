class MovieController < ApplicationController
    def index
        @movies = Movie.all
    end 

    def new
    end 

    def create
    end 

    def show
        @showings = []
        @movie = Movie.find(params[:id])

        @movie.showings.each do |showing|
        
            hour = /^(2[0-3]|[01]?[0-9])/.match(showing.military_time.to_s)[1].to_i
            
            minute = /\.([0-5]?[0-9])$/.match(showing.military_time.to_s)[1].to_i


            if hour >= Time.now.hour 
                @showings << showing
            end 
        end 

    end 

    def edit 
    end 

    def update
    end 

    def delete
    end 


    private 

    def movie_params 
        params.require(:movie).permit(:id, :synopsis, :runtime, :image, :placed?, :auditorium_id)
    end 


end
