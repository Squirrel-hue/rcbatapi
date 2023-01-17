#' Generate Random Hex String of Length n
#'
#' This creates the building blocks to generate unique client_order_ID.
#'
#' @param n the number of consecutive strings to put in a hex string
#' @export

ran_hex_str <- function(n=4){
  a <- (sample(c("a","b","c","e","f", 0:9),n, replace = TRUE))
  sapply(list(a),paste, collapse = "")
}


#' Function to Generate Client Order IDs
#'
#' The function depends on ran_hex_str
#'
#' @export

gen_coir <- function(){
  paste(ran_hex_str(8),ran_hex_str(4),ran_hex_str(4),
        ran_hex_str(4),ran_hex_str(12), sep = "-")
}
