# Use of Package rcbatapi

## Introduction

Implements authorization and other functions to trade crypto using  the Coinbase Advanced Trading API.  There is a general function that permits the accessing of API endpoints, as well as functions that assist with the order endpoints.

This package is offered as is without any promise or guarantee of suitability for any given purpose.  Test it out with small values.

The package name represents "R Coinbase Advanced Trade API."

## Setup

1.  Install R (https://cran.r-project.org/)
2.  (Optional) I recommend that you install RStudio (https://posit.co/)
3.  On Windows, is is possible that you may need to install RTools (https://cran.r-project.org/bin/windows/Rtools/). Not needed on macOS and Linux.  I am developing on Linux and have not tested it yet on Windows.
4.  Either
    a.  Install `rcbatapi` package, or
    b.  Copy and initialize the necessary functions.

There are two ways to use the package.

1.  Have a string of function to obtain the desired behavior (demonstration below for market orders).
2.  Add the API key(s) and secret key(s) to the authentication function. This will then allow you to authenticate automatically. But make sure that the function is not shared with anyone else, or you will have given away your secret keys. You can have several wallets, just make sure that each one is properly identified and selected. This will be discussed below (coming soon!)

## Obtain and enter API Keys for Wallet

You will create these (or have created these) on Coinbase Advance Trading API. Make sure that you protect them (especially your secret key). Information can be found at https://help.coinbase.com/en/cloud/api/coinbase/key-creation.

Assign Keys as variables in R

``` r
api_key <- "" # assign the variable api_key in quotes

secret_key <- "" # assign the variable secret_key in quotes

pair <- "BTC-USD" # The Pair that you wish to obtain information about.
```

## Get Pair Information. BTC-USD in this case

You will need to know what are the minimum sizes and dollar amounts that you can trade.

This code will provide that for you.

``` r
(base <- unlist(strsplit(pair, split = "-"))[1]) # The first currency listed (BTC in this example) 

(quote <- unlist(strsplit(pair, split ="-"))[2]) # The last currency listed (USD in this example)
```

## Get Information about the Pair (BTC-USD in this case)

Once you have assigned `api_key`, `secret_key` and `pair`, this code should work.

``` r
(pair_info <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                                             secret_key = secret_key, 
                                             method = "GET", 
                                             reqPath = paste0("/products/",
                                                              pair)))
```

`pair_info` contains a lot of useful information. Some of it is highlighted below

### Maximum Base Currency Precision Digits

The maximum number of digits that can be used in expressing the quantity of Bitcoin quantity to transact.

``` r
(base_increment <- -log10(as.numeric(pair_info$base_increment)))
```

The parenthesis around the expression causes R to print the result.  Otherwise, you would need to type `base_increment` to see the result.

### Maximum Quote Currency Precision Digits

The maximum number of digits that can be used in expressing the dollar quantity. If it is two (2), this means it can be expressed to \$1.00

``` r
(quote_increment <- -log10(as.numeric(pair_info$quote_increment)))
```

### Smallest Base Currency Quantity

The smallest quantity of Bitcoin that can be transacted

``` r
(base_min_size <- pair_info$base_min_size)
```

### Smallest Quote Currency Quantity

The smallest number of USD that can be transacted. At this point is in one (1), which means \$1.00.

``` r
(quote_min_size <- pair_info$quote_min_size)
```

# Get the price of Bitcoin in dollars

``` r
(BTCUSD_price <- as.numeric(pair_info$price))
```

### How to Place a \$1.00 Bitcoin Market Buy Order

Now that we have obtained information about the pairs, we can proceed to place a market order.

``` r
market_buy_payload <- rcbatapi::market_market_ioc_buy(client_order_id ="", 
                                                      product_id = "BTC-USD", 
                                                      quote_size = 1.00, 
                                                      quote_increment = quote_increment)


market_buy <- rcbatapi::interact_AT_API_keys(api_key = api_key, 
                                             secret_key = secret_key, 
                                             method = "POST",
                                             reqPath = "/orders",
                                             body = market_buy_payload)
```

Note that you could also use `product_id = pair` as the second argument to `rcbatapi::market_market_ioc_buy`

If you evaluate the variable `market_buy_payload` after running the first line above, it will provide you with the string that needs to be passed to the API.

### How to Place a \$1.00 Bitcoin Market Sell Order

Using all the same code from above.

``` r
market_sell_payload <- rcbatapi::market_market_ioc_sell(client_order_id = "", 
                                                        product_id ="BTC-USD", 
                                                        base_size = 1/BTCUSD_price, 
                                                        base_increment = base_increment)

market_sell <- rcbatapi::interact_AT_API_keys(api_key = api_key, 
                                             secret_key = secret_key,
                                             method = "POST",
                                             reqPath = "/orders",
                                             body = market_sell_payload)
```

## Obtain Information About Wallet or Account

Initialize your api key and secret key for the wallet in question (that is, put the required numbers in between the quotation marks).

``` r
api_key <- ""
secret_key <- ""
```

The following code will then pull the wallet information and assign this to the `accounts` variable.

```
(accounts <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                               secret_key = secret_key,
                               method = "GET",
                               reqPath = "/accounts"))
```

More information will be posted regarding how to extract and manipulate this information.

# Products

## List Products

``` r
list_products <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                                                secret_key = secret_key,
                                                method = "GET",
                                                reqPath = "/products")
```

## Get Products

Edit the string in `product_id`

``` r
product_id <- "BTC-USD"

reqPath <- paste0("/products/",product_id,"/")
get_product <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                                              secret_key = secret_key,
                                              method = "GET",
                                              reqPath = reqPath)
get_product
```

### Get Product Candles

Chose the desired product, start date ("YYYY-MM-DD"), end date ("YYYY-MM-DD"), and granularity
(ONE_MINUTE, FIVE_MINUTE, FIFTEEN_MINUTE, THIRTY_MINUTE, ONE_HOUR, TWO_HOUR, SIX_HOUR, or ONE_DAY)

Edit the strings in `product_id`, `start`, `end`, and `granularity`.

``` r
product_id <- "BTC-USD"
start <- "2022-01-01 09:10:00 CST"
end <- "2022-01-01 22:05:00 CST"
granularity <- "FIVE_MINUTE"

start_unix <- format(as.numeric(as.POSIXct(start)), digits = 10)
end_unix <- format(as.numeric(as.POSIXct(end)), digits = 10)

reqPath <- paste0("/products/",product_id,"/candles")
query   <- paste0("?start=",start_unix,"&end=",end_unix,"&granularity=",granularity)
# reqPath <- paste0("/products/",product_id,"/candles?granularity=",granularity)
get_product_candles <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                                                      secret_key = secret_key,
                                                      method = "GET",
                                                      reqPath = reqPath,
                                                      query = query)
get_product_candles
```

### Get Market Trades

Edit `product_id` and `limit`.

``` r
product_id <- "BTC-USD"
limit <- 1000

reqPath <- paste0("/products/",product_id,"/ticker")
query   <- paste0("?limit=",limit)
get_market_trades <- rcbatapi::interact_AT_API_keys(api_key = api_key,
                                                      secret_key = secret_key,
                                                      method = "GET",
                                                      reqPath = reqPath)
get_market_trades
```
