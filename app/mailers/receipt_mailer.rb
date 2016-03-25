class ReceiptMailer < ApplicationMailer
     default from: 'jordanedwardobey@gmail.com'

    def guest_receipt(email, ticket_count, total)
        @url  = 'http://example.com/login'
        @email = email
        @ticket_count = ticket_count
        @total = total
        mail(to: @email, subject: "Thanks for your purchase")
    end

end
