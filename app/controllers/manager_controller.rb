class ManagerController < ApplicationController
    def index
    end 

    def show
        if params[:admin_selection] == "auditoriums" 
            @auditoriums = Auditorium.all
        elsif params[:admin_selection] == "movies"
            @movies = Movie.all 
        elsif params[:admin_selection] == "orders"
            @orders = Order.all
            @order_movies = Movie.all
        end 

    end 

    def new
    end 

    def create
    end 

    def edit
    end 

    def update
    end 

    def delete
    end 
end
