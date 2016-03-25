class AuditoriumController < ApplicationController

    def show
        @auditorium = Auditorium.find(params[:auditorium_id])
    end 

    def new
    end 

    def create
    end 

    def edit
    end 

    def update
    end 

    def destroy
    end 
end
