class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end 

    def new
        @movie = Movie.new
    end 

    def create
         @movie = Movie.create(movie_params)
         @movie.image = Faker::Avatar.image


         if @movie.save

            redirect_to '/admin/movies'
        else 
            flash[:notice] = @movie.errors.full_messages.to_sentence
            render 'new'
        end 
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
        @movie = Movie.find(params[:id])
        @auditoriums = Auditorium.all
    end 

    def update
        @movie = Movie.find(params[:id])
        @auditorium = Auditorium.find(movie_params[:auditorium_id])
        puts movie_params

        if @auditorium.movie != nil
            @movie.set_movie(@auditorium)
            @movie.update_attributes(synopsis: movie_params[:synopsis], runtime: movie_params[:runtime], status: "playing")

        else 

            @movie.set_movie(@auditorium)
            @movie.update_attributes(synopsis: movie_params[:synopsis], runtime: movie_params[:runtime], status: "playing")
        end 

       

        redirect_to '/admin/movies'
    end 

    def destroy
        @movie = Movie.find(params[:id])

        if @movie.auditorium != nil 
            @movie.auditorium.remove_movie 
        end 

        @movie.destroy! 

        redirect_to '/admin/movies'
    end 


    private 

    def movie_params 
        params.require(:movie).permit(:title, :synopsis, :runtime, :image, :status, :auditorium_id)
    end 


end
