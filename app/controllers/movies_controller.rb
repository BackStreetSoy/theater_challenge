class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end 

    def new
        @movie = Movie.new
    end 

#creates a movie based off params and automatically loads an image(not realistic)
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

#only show available showings if the time hasn't passed them yet

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

        @showings

    end 

    def edit 
        @movie = Movie.find(params[:id])
        @auditoriums = Auditorium.all
    end 

#right now, only movies currently in an auditorium can be edited (in retrospect it should be the opposite)
    def update
        @movie = Movie.find(params[:id])
      

        if movie_params[:auditorium_id] != ""
            @auditorium = Auditorium.find(movie_params[:auditorium_id])
            @movie.set_movie(@auditorium)
            @movie.update_attributes(synopsis: movie_params[:synopsis], runtime: movie_params[:runtime], status: "playing")

            redirect_to '/admin/movies'

        else 

           flash[:notice] = "please enter an auditorium number"
           redirect_to "/movies/#{@movie.id}/edit"
        end 

       
    end 

    #make sure to remove the association between movie and it's auditorium before it is destroyed

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
