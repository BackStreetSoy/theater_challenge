class OrderController < ApplicationController
    def index

    end 

    def new
        @num_of_tickets = params[:ticket_count]
        @total_price = @num_of_tickets.to_f * 7.30
        @order = Order.new
    end 

    def create
        if ReceiptMailer.guest_receipt(order_params[:email]).deliver_now
            puts "sent!"
        end 

        redirect_to '/'
    end 

     private 

    def order_params 
        params.require(:customer).permit(:email, :credit_card_number, :card_expiration)
    end
end
