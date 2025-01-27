# NFL Pro Bowl Data Analysis and Model Evaluation

## Overview
This project aims to analyze NFL player statistics and predict Pro Bowl appearances using classification models. The analysis includes data preprocessing, exploratory data analysis (EDA), and training machine learning models such as Support Vector Machines (SVM), Linear Discriminant Analysis (LDA), and Random Forest (RF).

## Dependencies
The project requires the following R and Python libraries:

### R Libraries:
- `ggplot2`
- `reshape2`
- `tidyr`
- `dplyr`
- `caret`
- `caTools`
- `randomForest`
- `e1071`
- `pROC`

### Python Libraries:
- `pandas`
- `numpy`
- `tqdm`
- `requests`
- `beautifulsoup4`
- `joblib`

Make sure to install these dependencies before running the scripts.

## Data Description
The data used in this analysis includes NFL player statistics from 1994 to 2020 for passing, rushing, and receiving categories. Each dataset contains the following columns:
- **Player**: Player's name
- **Year**: Year of the season
- **Position-Specific Performance Statistics**
- **Pro Bowl**: Binary indicator (1 if the player made the Pro Bowl, 0 otherwise)

## How to Run

### Python Scipt:
1. Navigate to the src folder
2. Run the webscraping script in terminal to scrape data:
   ``` bash
   python webscraper.py
   ```

### R Script:
1. Run the script main.R in the src directory to generate relevant plots and print stats

## Results
The polished results of the data analysis are saved in the `docs` folder. This folder contains:
- **Final_Report.docx**: An in depth view of the data analysis
- **Presentation.pdf**: A surface level view of analysis and results

For unpolished script results:
- **Processed Data**: CSV files for training and testing datasets for passing, rushing, and receiving statistics.
  - `nfl_passing.csv`
  - `nfl_rushing.csv`
  - `nfl_receiving.csv`
- **Plots and Analysis**: The visualizations generated from the exploratory analysis are visible in R

## License
This project is licensed under the MIT License - see the LICENSE file for details.
