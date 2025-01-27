#Clear workspace
rm(list = ls())
while (dev.cur() > 1) dev.off()

# Load functions
setwd("../src")
source("./data_processing.R")
source("./models.R")
source("./data_analysis.R")
source("./eval.R")

# Data analysis
setwd("../data")
exploratoryAnalysis("nfl_passing.csv","Passing")
exploratoryAnalysis("nfl_rushing.csv","Rushing")
exploratoryAnalysis("nfl_receiving.csv","Receiving")

# Data processing
passing_data <- processData("nfl_passing.csv")
rushing_data <- processData("nfl_rushing.csv")
receiving_data <- processData("nfl_receiving.csv")

# List of data types
data_list <- list(passing_data, rushing_data, receiving_data)
data_types <- c("passing", "rushing", "receiving")

# Train and evaluate the different data types
for (i in 1:length(data_list)) {
  # Get the current data frame and data type
  current_data <- data_list[[i]]
  current_type <- data_types[i]
  
  # Define classification formula
  current_features <- colnames(current_data$train)
  current_formula <- as.formula(paste("pro_bowl ~", 
                                      paste(current_features[3:length(current_features)-1], collapse = " + "))
  )
  
  # Train models
  current_models <- fitModels(current_data$train, current_formula)
  
  # Evaluate models
  print(paste("##############Evaluating", current_type, "Models"))
  evaluateModels(current_data$test, current_models)
}
