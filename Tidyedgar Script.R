###########################################################
# Package Showcase: "TidyEdgar"
###########################################################

# For the 1st part - Instal 'tidyedgar' from CRAN to access EDGAR data
install.packages("tidyedgar")

 # Alternatively install tidyedgar from GitHub for latest version/developmental
devtools::install_github("gerardgimenezadsuar/tidyedgar")

# Load the necessary libraries 
# Data Manipulation and visualization
library(tidyedgar)
library(ggplot2)
library(dplyr)



# Fetch data from EDGAR database for years 2015 to 2023
df <- yearly_data(years = 2015:2023)

View(df)

# Simulate data retrieval for example. This simulates a dataset of financial metrics.
# Set Seed for reproducibility of the example used here.
set.seed(123)

# Creating a Data frame with years and sample company names as a factorial grid
years <- 2015:2023
companies <- c("Apple Inc", "Google LLC", "Microsoft Corp")

# Assigned a variable for the simulated dataset
df <- expand.grid(year = years, company_name = companies)
# Simulate total assets data for each company and year.
df$total_assets <- round(runif(n = nrow(df), min = 100000, max = 500000), 0)
# Simulate total liabilities data for each company and year.
df$total_liabilities <- round(runif(n = nrow(df), min = 50000, max = 300000), 0)

# Calculate net income as total assets minus total liabilities.
df$net_income <- df$total_assets - df$total_liabilities

# Calculate financial ratios to provide insights into financial health
df <- df %>%
  mutate(asset_to_liability_ratio = total_assets / total_liabilities,
         net_margin = net_income / total_assets)
# Here the mutate function is used to add 2 more columns to the dataset 'df'

# Aggregate data to summarize it at annual level by company.
# Calculating totals and averages of the metrics (used dplyr here)
annual_summary <- df %>%
  group_by(year, company_name) %>%
  summarise(total_assets = sum(total_assets),
            total_liabilities = sum(total_liabilities),
            net_income = sum(net_income),
            avg_asset_to_liability_ratio = mean(asset_to_liability_ratio),
            avg_net_margin = mean(net_margin),
            .groups = 'drop')
#################################################################################

# Visual Output Example: 

# Visualization 1 : Line chart of Total Assets over Time by Company
ggplot(annual_summary, aes(x = year, y = total_assets, color = company_name, group = company_name)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  labs(title = "Total Assets Over Time by Company", x = "Year", y = "Total Assets (USD)")

# Visualization 2 : Bar chart of Average Asset to Liability Ratio over Time
ggplot(annual_summary, aes(x = year, y = avg_asset_to_liability_ratio, fill = company_name)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal() +
  labs(title = "Asset to Liability Ratio Over Time", x = "Year", y = "Ratio")

# Visualization 3 : Colored bar chart of Net Income by Company Over Time
ggplot(annual_summary, aes(x = year, y = net_income, fill = company_name)) +
  geom_col(position = position_dodge()) +
  theme_minimal() +
  labs(title = "Net Income by Company Over Time", x = "Year", y = "Net Income (USD)")

# Visualization 4 : Line chart of Average Net Margin Over Time
ggplot(annual_summary, aes(x = year, y = avg_net_margin, color = company_name, group = company_name)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  labs(title = "Average Net Margin Over Time", x = "Year", y = "Net Margin")

# Visualization 5 : Stacked bar chart of Total Liabilities over Time
ggplot(annual_summary, aes(x = year, y = total_liabilities, fill = company_name)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(title = "Total Liabilities Over Time by Company", x = "Year", y = "Total Liabilities (USD)")

