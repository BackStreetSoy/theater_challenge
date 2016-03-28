// updates the price of the purchase
// creates a button to purchase tickets ONLY if a value appears, this prevents the purchase of 0 tickets

$(document).ready(function(){


    $(".number_of_tickets").change(function(sel){
        value = parseInt(sel.target.value)
        price = 7.30 * value
        showing_id = $(".purchase_link").attr("href")



        $(".price").html("<b>price: </b> $" + price + "0")

         $(".purchase_link").attr("href", "/orders/new/"+ showing_id + "/" + value)
         $(".purchase_link").html("<button type='button' class='btn btn-primary'>buy tickets</button>")
    })

});
