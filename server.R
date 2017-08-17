#server
library(plumber)
r <- plumb("./main.R")  # Where 'myfile.R' is the location of the file shown above
r$run(port=8000)