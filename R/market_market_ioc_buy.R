#' Function for Market Immediate-or-Cancel Order via Advanced Trade API
#'
#' Remember,
#' Base currency is the first listed (e.g., \code{BTC} in \code{BTC-USD})
#' Quote currency is the last listed (e.g., \code{USD} in \code{BTC-USD})
#'
#' @param client_order_id either assign, or the program will assign a random
#'    number
#' @param product_id  What pair to transact, e.g. \code{BTC-USD}
#' @param quote_size Amount of quote currency to spend on order. Required for
#' \code{BUY} orders.
#' @param quote_increment The maximum number of decimal places to which the
#'   \code{quote_size} can be expressed
#' @return A string to pass as payload/body for the Market Immediate-or_Cancel
#' order
#' @export

market_market_ioc_buy <- function(client_order_id = "",
                                  product_id = "BTC-USD",
                                  quote_size = 0,
                                  quote_increment = 2){

  quote_size <-  round(quote_size, digits = quote_increment)

  if(isTRUE(client_order_id == "")){
    client_order_id <-  rcbatapi::gen_coir()
  }
  side <- "BUY"
  payload <- paste0('{\"client_order_id\":\"',client_order_id,'\",\"product_id\":\"',product_id,'\",\"side\":\"',side,'\",\"order_configuration\":',
         '{\"market_market_ioc\":',
         '{\"quote_size\":\"',quote_size,'\"}}}')


}

