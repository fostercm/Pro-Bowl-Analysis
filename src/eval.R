# Load necessary libraries
library(caret)
library(ggplot2)
library(pROC)
library(randomForest)
library(e1071)
library(dplyr)

# Define a helper function for confusion matrix
get_confusion_matrix <- function(model, predictors, target) {
  # Get predictions
  predictions <- predict(model, predictors)
  
  # LDA model returns a list with predictions, so we need to access the 'class' component
  if ("lda" %in% class(model)) {
    predictions <- predictions$class
  }
  
  # Turn predictions into a factor
  predictions <- factor(predictions, levels = levels(target))
  
  # Get confusion matrix
  confusion <- confusionMatrix(predictions, target)
  return(confusion)
}

# Define the eval function
evaluateModels <- function(data, models) {
  # Split the data into features (X) and target (Y)
  predictors <- data %>% dplyr::select(-pro_bowl)
  target <- data$pro_bowl
  
  # Loop through each model and generate plots
  model_names <- names(models)
  for (model_name in model_names) {
    model <- models[[model_name]]
    
    # Confusion Matrix
    confusion <- get_confusion_matrix(model, predictors, target)
    print(paste("Confusion Matrix for", model_name))
    print(confusion$table)
    print(confusion$byClass)
  }
}
