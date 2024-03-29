% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/authentication_int.R
\name{authentication_int}
\alias{authentication_int}
\title{Authentication Process for Coinbase Advanced Trading API}
\usage{
authentication_int(
  wallet = c("ADA", "ATOM", "BTC", "DOGE", "ETH", "LTC", "USD"),
  method = c("GET", "POST"),
  reqPath,
  body = ""
)
}
\arguments{
\item{wallet}{Select the wallet (and permissions)}

\item{method}{Select whether to send a \code{GET} or \code{POST} request}

\item{reqPath}{The request path, omit \code{"/v3/api/brokerage"}}

\item{body}{The body/payload to pass to the API, usually used with method
\code{"POST"}}
}
\description{
In this version of the \code{authentication} function, the api key(s) and the
 secret key(s) for a wallet are stored internally.
}
\details{
Note: Will need to edit this to add the appropriate api_key(s) and
secret_key(s) for the relevant wallet(s), preferably using a package like
keyring. Otherwise, it will not work.
}
