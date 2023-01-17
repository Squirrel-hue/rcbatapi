# Examples of how to use the package

## Obtain and enter API Keys for Wallet

You will create these (or have created these) on Coinbase Advance Trading API. Make sure that you protect them (especially your secret key).

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

The Maximum Number of digits that can be used in expressing the quantity of Bitcoin quantity to transact.

``` r
base_increment <- -log10(as.numeric(pair_info$base_increment))
```

The maximum number of digits that can be used in expressing the dollar quantity. If it is two (2), this means it can be expressed to \$1.00

``` r
quote_increment <- -log10(as.numeric(pair_info$quote_increment))
```

The smallest quantity of Bitcoin that can be transacted

``` r
base_min_size <- pair_info$base_min_size
```

The smallest quantity of Bitcoin that can be transacted. At this point is in one (1), which means \$1.00.

``` r
quote_min_size <- pair_info$quote_min_size
```

# Get the price of Bitcoin in dollars

``` r
BTCUSD_price <- as.numeric(pair_info$price)
```

### How to Place a $1.00 Bitcoin Market Order

Now that we have obtained information about the pairs, we can proceed to place a market order.

``` r
market_buy_payload <- rcbatapi::market_market_ioc_buy(client_order_id ="", 
                                                      product_id = "BTC-USD", 
                                                      quote_size = 1.00, 
                                                      quote_increment = quote_increment)


market_buy <- interact_AT_API_keys(api_key = api_key, 
                                    secret_key = secret_key, 
                                    method = "POST", 
                                    reqPath = "/orders",
                                    body = market_buy_payload)
```

Note that you could also use `product_id = pair` as the second argument to `rcbatapi::market_market_ioc_buy`

If you evaluate the variable `market_buy_payload` after running the first line above, it will provide you with the string that needs to be passed to the API.

### How to sell \$1.00 worth of Bitcoin

Using all the same code from above.

``` r
market_sell_payload <- rcbatapi::market_market_ioc_sell(client_order_id = "", 
                                                        product_id ="BTC-USD", 
                                                        base_size = 1/BTCUSD_price, 
                                                        base_increment = base_increment)

market_sell <- interact_AT_API_keys(api_key = api_key, 
                                    secret_key = secret_key,
                                    method = "POST",
                                    reqPath = "/orders",
                                    body = market_sell_payload)
```
