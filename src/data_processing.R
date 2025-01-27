library(dplyr)
library(caTools)
library(caret)

# A function to preprocess data
processData <- function(data_path, split_ratio = 0.8) {
  
  # Read table
  data_table <- read.csv(data_path)
  
  # Remove year column
  data_table <- data_table %>% dplyr::select(-Year,-Player)
  
  # Normalize data
  processed_data <- predict(preProcess(data_table, method=c("range")), data_table)
  processed_data$pro_bowl <- as.factor(processed_data$pro_bowl)
  
  #Split into test and training
  sample <- sample.split(processed_data$pro_bowl, SplitRatio = split_ratio)
  train <- subset(processed_data, sample == TRUE)
  test <- subset(processed_data, sample == FALSE)
  
  # Return a value
  return(list(train = train, test = test))
}