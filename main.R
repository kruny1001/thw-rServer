#source("./orders.R")
source("./orderReport.R")

# plumber.R

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*") # Or whatever
  plumber::forward()
}


#' Echo the parameter that was sent in
#* @preempt cors
#' @get /orders
function(res){
  ordersToday()
}

#' Echo the parameter that was sent in
#* @preempt cors
#' @get /products
#' @serializer unboxedJSON
function(res){
  library(dplyr)
  #products indexes
  products = read.csv("products.csv", header=T, sep=",")
  Visible = products %>%
    filter(Product.Visible=="True") %>%
    select(Product.ID, Product.Name, Product.URL, Product.Images, Price)
  Visible$Price = as.numeric(as.character(Visible$Price))
  Visible$Product.Images = gsub("Product Image URL: ","", Visible$Product.Images)
  names(Visible) = c("id", "name", "url", "img", "price")
  names(Visible)
  list(status="success", output=Visible)
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @png
function(spec){
  myData <- iris
  title <- "All Species"
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  plot(myData$Sepal.Length, myData$Petal.Length,
    main=title, xlab="Sepal Length", ylab="Petal Length")
}


