$(document).ready(function(){
    console.log("hello")

    $(".number_of_tickets").change(function(sel){
        value = parseInt(sel.target.value)
        price = 7.30 * value

        console.log(price)

        $(".price").html("<b>price: </b> $" + price + "0")

         $(".purchase_link").attr("href", "/orders/new/"+ value)
    })


});
