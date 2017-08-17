library(dplyr)

#products indexes
products = read.csv("products.csv", header=T, sep=",")

Visible = products %>%
  filter(Product.Visible=="True") %>%
  select(Product.ID, Product.Name, Product.URL, Product.Images, Price)

Visible$Price = as.numeric(as.character(Visible$Price))
barplot(Visible$Price)
max(Visible$Price)
min(Visible$Price)
mean(Visible$Price)
median(Visible$Price)
Visible[1,]$Product.Images
nrow(Visible)
names(Visible) = c("id", "name", "url", "img")
names(Visible)
resultJson = jsonlite::toJSON(Visible, pretty=TRUE)
