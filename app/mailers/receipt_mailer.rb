class ReceiptMailer < ApplicationMailer
     default from: 'jordanedwardobey@gmail.com'

    def guest_receipt(email)
        @url  = 'http://example.com/login'
        @email = email
        mail(to: @email, subject: 'Thanks for your purchase')
    end

end
