#' Authentication Process for Coinbase Advanced Trading
#'
#' In this version of the \code{authentication} function, the api key(s) and the
#' secret key(s) for a wallet are supplied as arguments to the function.
#'
#' @param api_key The api key assigned to the Advanced Trading Wallet
#' @param secret_key The secret key assigned to the Advanced Trading Wallet
#' @param method Select whether to send a \code{GET} or \code{POST} request
#' @param reqPath The request path, can omit \code{"/v3/api/brokerage"}
#' @param body The body/payload to pass to the API, usually used with method
#'  \code{"POST"}
#' @return The api_key, the cb_signature, and the timestamp to pass to the api.
#' @export

authentication_keys <- function(api_key = "",
                                secret_key = "",
                                method = c("GET", "POST"),
                                reqPath,
                                body = ""){

  timestamp <- format(as.numeric(Sys.time()), digits = 10)
  if (isTRUE(method == "GET")) {
    message <- paste0(timestamp, method, reqPath)
  }  else if (isTRUE(method == "POST")) {
    message <- paste0(timestamp,
                      method,
                      reqPath,
                      body)
  }
  #  key <- base64enc::base64decode(secret_key)
  cb_signature <- digest::hmac(key = secret_key,
                               object = message,
                               algo = "sha256")
  # cb_signature <- base64enc::base64encode(cb_signature)
  return(list(api_key, cb_signature, timestamp))
}
