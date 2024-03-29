#' Authentication Process for Coinbase Advanced Trading API
#'
#' In this version of the \code{authentication} function, the api key(s) and the
#'  secret key(s) for a wallet are stored internally.
#'
#' Note: Will need to edit this to add the appropriate api_key(s) and
#' secret_key(s) for the relevant wallet(s), preferably using a package like
#' keyring. Otherwise, it will not work.
#'
#' @param wallet Select the wallet (and permissions)
#' @param method Select whether to send a \code{GET} or \code{POST} request
#' @param reqPath The request path, omit \code{"/v3/api/brokerage"}
#' @param body The body/payload to pass to the API, usually used with method
#'  \code{"POST"}
#' @export

authentication_int <- function(wallet = c("ADA", "ATOM", "BTC", "DOGE",
                                          "ETH", "LTC", "USD"),
                           method = c("GET", "POST"),
                           reqPath,
                           body = ""){

  if(isTRUE(wallet == "BTC")){
    # The best way is to handle this with `keyring` or some other manager
    # Add all wallets that you wish you to manage with the authentication
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "USD")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "DOGE")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "ETH")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "LTC")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "ATOM")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }else if(isTRUE(wallet == "ADA")){
    api_key <- "" # need API Key
    secret_key <- keyring::key_get(service = wallet,
                                   username = api_key)
  }
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

#' Authentication Process for Coinbase Advanced Trading API
#'
#' This is identical to the function \code{authentication_int}
#'
#' Note: Will need to edit this to add the appropriate api_key(s) and
#' secret_key(s) for the relevant wallet(s)
#'
#' @param wallet Select the wallet (and permissions)
#' @param method Select whether to send a \code{GET} or \code{POST} request
#' @param reqPath The request path, omit \code{"/v3/api/brokerage"}
#' @param body The body/payload to pass to the API, usually used with method
#'  \code{"POST"}
#' @export

authentication <- function(wallet = c("BTC","USD", "DOGE"),
                           method = c("GET", "POST"),
                           reqPath,
                           body = ""){


  authentication_int(wallet = wallet,
                     method = method,
                     reqPath = reqPath,
                     body = body)
}
