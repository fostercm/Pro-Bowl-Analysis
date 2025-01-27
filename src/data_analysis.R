library(ggplot2)
library(reshape2)
library(tidyr)
library(dplyr)

# Function to generate data analysis plots
exploratoryAnalysis <- function(data_path, data_type) {
  
  # Read data and drop player names
  data <- read.csv(data_path)
  data <- data %>% dplyr::select(-Player)
  
  # Simple data overview
  print(summary(data))
  
  # Pro bowl class distribution
  pb_distribution <- ggplot(data, 
         aes(x = pro_bowl)) +
         geom_bar(fill = "steelblue") +
         labs(title = paste(data_type, "Pro Bowl Distribution"), x = "Pro Bowl", y = "Count")
  print(pb_distribution)
  
  # Transform the data into long format for faceting
  long_data <- data %>% pivot_longer(cols = -pro_bowl, names_to = "Feature", values_to = "Value")
  
  # Plot feature distributions
  feature_distributions <- ggplot(long_data, aes(x = Value)) +
    geom_histogram(bins = 30, fill = "lightblue", color = "black") +
    facet_wrap(~ Feature, scales = "free", ncol = 3) +
    labs(title = paste(data_type, "Feature Distributions"), x = "Value", y = "Count") +
    theme_minimal()
  print(feature_distributions)
  
  # Get correlation matrix
  corr_matrix <- cor(data[, sapply(data, is.numeric)], use = "complete.obs")
  melted_corr <- melt(corr_matrix)
  
  # Plot feature correlations
  correlations <- ggplot(melted_corr, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 0, limit = c(-1, 1)) +
    labs(title = paste(data_type, "Correlation Heatmap"), x = "", y = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(correlations)
}