#Implement

ordersToday <- function(){
  library(httr)
  library(jsonlite)
  
  body <- list(
    min_date_created="16 Aug 2017 00:00:00 UTC", 
    max_date_created="16 Aug 2017 23:00:00 UTC", 
    limit=250)
  
  r <- httr::POST(
    url= 'http://localhost:3001/api/listOrders',
    body = jsonlite::toJSON(body,auto_unbox=TRUE),
    add_headers ('Content-Type'='application/json'))
  
  json <- httr::content(r, as = "text")
  results <- jsonlite::fromJSON(json)
  nrow(results)
  final = data.frame(
    orderId  = results$id, 
    custId   = results$customer_id,
    status   = results$status,
    total    = results$total_inc_tax,
    products = results$products
  )
  head(final)
  return (final)
}




