library(e1071)
library(MASS)
library(randomForest)

fitModels <- function(train_data, input_formula) {

  ## SVM (radial)
  tune.out <- tune(svm, 
                input_formula, 
                data=train_data, 
                kernel="radial",
                ranges=list(cost=c(0.1,1,10,100,1000),
                            gamma=c(0.5,1,2,3,4)
                            )
                )
  RSVM_model <- tune.out$best.model

  ## LDA
  LDA_model <- lda(input_formula,
                  data=train_data)
  
  ## RandomForest
  tune.out <- tune(randomForest,
           input_formula,
           data=train_data,
           method='class',
           ranges=list(ntree=c(10,100,1000))
          )
  RF_model <- tune.out$best.model
  
  return(list(RSVM = RSVM_model, LDA = LDA_model, RF = RF_model))
}
  
