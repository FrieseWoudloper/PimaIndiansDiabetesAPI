#
# This is a Plumber API. In RStudio 1.2 or newer you can run the API by
# clicking the 'Run API' button above.
#
# In RStudio 1.1 or older, see the Plumber documentation for details
# on running the API.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(xgboost)
library(tidymodels)

model <- readRDS("./data/reg_res.RDS")

#* @apiTitle PimaIndiansDiabetes API

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Retourneer een predictie
#* @param pregnant pregnant
#* @param glucose glucose
#* @param pressure pressure
#* @param triceps triceps
#* @param insulin insulin
#* @param mass mass
#* @param pedigree pedigree
#* @param age age
#* @post /predict
function(pregnant = 6,
         glucose = 148,
         pressure = 72,
         triceps = 35,
         insulin = 0,
         mass = 33.6,
         pedigree = 0.627,
         age = 50){

  pred <- predict(model, new_data = data.frame(pregnant = pregnant,
                                          glucose = glucose,
                                          pressure = pressure,
                                          triceps = triceps,
                                          insulin = insulin,
                                          mass = mass,
                                          pedigree = pedigree,
                                          age = age))
  return(as.character(pred$.pred_class)) 
  
}

