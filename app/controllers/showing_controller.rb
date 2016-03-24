class ShowingController < ApplicationController
    def show
        @showing = Showing.find(params[:id])
        @movie = Movie.find(@showing.movie.id)
    end 
end
