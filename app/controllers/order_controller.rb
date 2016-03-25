class OrderController < ApplicationController
    def index

    end 

    def new
        @num_of_tickets = params[:ticket_count]
        @total_price = @num_of_tickets.to_f * 7.30
        @valid_check = params[:valid]
        @expired = params[:expired]
        @showing_id = params[:showing_id]
    end 

    def create
        card_type = order_params[:credit_card_type]
        card_num  = order_params[:credit_card_number]
        card_exp_day = order_params[:card_expiration][8..9].to_i
        card_exp_month = order_params[:card_expiration][5..6].to_i
        card_exp_year = order_params[:card_expiration][0..3].to_i

        number_of_tickets = order_params[:ticket_count]
        email = order_params[:email]
        total = order_params[:total]

        @showing = Showing.find(order_params[:showing_id])
        @movie = @showing.movie
        @expired = Customer.card_expired?(card_exp_day, card_exp_month, card_exp_year)

        #encapsulate this into a helper
        if card_type == "Visa"
            @valid_check = Customer.valid_visa?(card_num)
        elsif card_type == "Mastercard"
            @valid_check = Customer.valid_mastercard?(card_num)
        elsif card_type == "Amex"
            @valid_check = Customer.valid_amex?(card_num)
        elsif card_type == "Discover"
            @valid_check = Customer.valid_discover?(card_num)
        end 

        #encapsulate this into a helper
        if @valid_check == true && @expired == false && Order.create!(number_tickets_bought: number_of_tickets, total_price: total, movie: @movie)

            i = 0 

            number_of_tickets.to_i.times do 
                @showing.tickets[i].destroy
                i += 1
            end 

            ReceiptMailer.guest_receipt(email, number_of_tickets, total).deliver_now!

            redirect_to '/'
        else 

            redirect_to controller: 'order', action: 'new', movie_id: @movie.id,  ticket_count: order_params[:ticket_count], valid: @valid_check, expired: @expired
        end 
    end 

     private 

    def order_params 
        params.require(:order).permit(:email, :credit_card_number, :card_expiration, :credit_card_type, :total, :ticket_count, :showing_id)
    end
end
