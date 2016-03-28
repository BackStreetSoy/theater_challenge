class  AuditoriaController < ApplicationController

    def show
        @auditorium = Auditorium.find(params[:id])
    end 

    def new
        @auditorium = Auditorium.new
    end 

#upon creation managers dictate how many seats an auditorium has
    def create
        @auditorium = Auditorium.create!(seat_count: auditorium_params[:seat_count])
        redirect_to @auditorium
    end 

    def edit
        @auditorium = Auditorium.find(params[:id])
    end 

#in order to update the auditorium, manager needs to make sure that there are seats
#because available tickets is dependent on seat count, on update, the auditorium destroys current tickets and resets them to accomodate the new seat count 
    def update

        @auditorium = Auditorium.find(params[:id])

        if @auditorium.is_a?(Auditorium) && auditorium_params[:seat_count].to_i > 0

            @auditorium.update_attributes(seat_count: auditorium_params[:seat_count])

            @auditorium.showings.each do |showing|
                showing.tickets.destroy_all

                @auditorium.seat_count.to_i.times do 
                    showing.tickets << Ticket.create(price: 7.30, showing: showing)
                end 
            end 


            redirect_to @auditorium
        else 

            flash[:notice] = "Woops. Something went wrong.x"

            render 'edit'
        end 
    end 

    def destroy
        @auditorium = Auditorium.find(params[:id])
        @auditorium.destroy!

        redirect_to '/admin/auditoriums'
    end 

    def auditorium_params
        params.require(:auditorium).permit(:seat_count, :movie_id)
    end
end
