#' Interact with the Coinbase Advanced Trading API
#'
#' This a function that allows to use "GET" or "POST" methods to interact with
#' Coinbase API
#'
#' Added the "query" after it was loaded
#'
#' @param api_key The api key assigned to the Advanced Trading Wallet
#' @param secret_key The secret key assigned to the Advanced Trading Wallet
#' @param method Select whether to send a \code{GET} or \code{POST} request
#' @param reqPath The request path, can omit \code{"/v3/api/brokerage"}
#' @param query The query items to add to the end of the url
#' @param body The body/payload to pass to the API, usually used with method \code{"POST"}
#' @return Returns the content from the API request
#' @export
#'

interact_AT_API_keys <- function(api_key = "",
                                 secret_key= "",
                                 method = c("GET", "POST"),
                                 reqPath,
                                 query = "",
                                 body = ""){

  coinbase_url <- "https://api.coinbase.com"
  base_reqPath <- "/api/v3/brokerage"
  full_reqPath <- paste0(base_reqPath,reqPath)
  # full_url <- paste0(coinbase_url,full_reqPath,query)
  coinbase_fullPath <- paste0(coinbase_url, full_reqPath,query)
  auth <- rcbatapi::authentication_keys(api_key = api_key,
                                        secret_key = secret_key,
                                        method = method,
                                        reqPath = full_reqPath,
                                        body = body)
  if (isTRUE(method == "GET")) {
    coinbase_acct <- httr::content(httr::GET(coinbase_fullPath,
                                             httr::add_headers(
                                               `CB-ACCESS-KEY` = auth[[1]],
                                               `CB-ACCESS-SIGN` = auth[[2]],
                                               `CB-ACCESS-TIMESTAMP` = auth[[3]],
                                               `Content-Type` = "application/json")))
  }
  if (isTRUE(method == "POST")) {
    coinbase_acct <- httr::content(httr::POST(coinbase_fullPath,
                                              body = body,
                                              httr::add_headers(
                                                `CB-ACCESS-KEY` = auth[[1]],
                                                `CB-ACCESS-SIGN` = auth[[2]],
                                                `CB-ACCESS-TIMESTAMP` = auth[[3]],
                                                `Content-Type` = "application/json")))
  }

  coinbase_acct
}
