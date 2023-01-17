#' Function for Market Immediate-or-Cancel Order via Advanced Trade API
#'
#' Base currency is the first listed (e.g., \code{BTC} in \code{BTC-USD})
#' Quote currency is the last listed (e.g., \code{USD} in \code{BTC-USD})
#'
#' The documentation appears to be wrong, market orders must be specified in
#' quote currencies
#'
#' @param client_order_id either assign, or the program will assign a random number
#' @param product_id  What pair to transact, e.g. \code{BTC-USD}
#' @param base_size Amount of base currency to receive from order. Required for
#'  \code{SELL} orders.
#' @param base_increment The maximum number of decimal places to which the
#'   \code{base_size} can be expressed
#' @return A string to pass as payload/body for the Market Immediate-or_Cancel
#' order
#' @export


market_market_ioc_sell <- function(client_order_id = "",
                                   product_id = "BTC-USD",
                                   base_size = 1/21000,
                                   base_increment = 8){

  base_size <- round(base_size, digits = base_increment)

  if(isTRUE(client_order_id == "")){
    client_order_id <-  rcbatapi::gen_coir()
  }
  side <- "SELL"
  paste0('{\"client_order_id\":\"',client_order_id,'\",\"product_id\":\"',product_id,'\",\"side\":\"',side,'\",\"order_configuration\":',
         '{\"market_market_ioc\":',
         '{\"base_size\":\"',base_size,'\"}}}')
}

