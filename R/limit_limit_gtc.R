#' Function for Limit Good-Til-Cancelled Orders via Advanced Trade API
#'
#' @param client_order_id either assign, or a random number will be assigned automatically
#' @param product_id  What pair to transact
#' @param side "BUY" or "SELL"
#' @param base_size quantity to purchase (in terms of )
#' @param limit_price maximum to receive for sell, minimum to pay for buy (USD)
#' @return A string to pass as payload/body for the limit Good-Til-Cancelled
#' @export

# need to remove the wallet variable.
limit_limit_gtc <- function(client_order_id = "",
                            product_id = c("BTC-USD",
                                           "DOGE-USD",
                                           "ETH-USD",
                                           "LTC-USD"),
                            side = c("BUY","SELL", "buy", "sell",
                                     "B", "b", "S", "s"),
                            base_size = 0,
                            limit_price = 0){

  # set product id default
  #product_id = "BTC-USD"

  # Make sure that order side is properly formatted
  if(side %in% c("buy", "b", "B")){
    side = "BUY"
  } else  if(side %in% c("sell", "s", "S")){
    side = "SELL"
  }

    #                           )
  # Make sure that order size is acceptable amounts
  #
  if(product_id == "BTC-USD"){
    base_size <-  round(base_size, digits = 8)
    if(base_size <  0.000016)
      stop("Error: Base Size: Is Too Small")

  }else if(product_id == "DOGE-USD"){

  }

  if(isTRUE(client_order_id == "")){
    client_order_id <-  rcbatapi::gen_coir()
  }

  paste0('{\"client_order_id\":\"',client_order_id,'\",\"product_id\":\"',product_id,'\",\"side\":\"',side,'\",\"order_configuration\":',
         '{\"limit_limit_gtc\":',
         '{\"base_size\":\"',base_size,'\",\"limit_price\":\"',limit_price,'\",\"post_only\":false}}}}')
}

