library(tidyedgar)

#########################################################
# Some of the basic functions within 'Tidyedgar'
#########################################################


#. 1. 'get_qdata': 
# Use this function to retrieve data for a specific quarter of a specific year.
# Here retrieving yearly data for "Revenues" for the years 2020 to 2023
quarterly_data <- get_qdata(account = "NetIncomeLoss", years = 2022, quarters = "Q4")

View(quarterly_data)

#___________________________________________________________________


# 2. 'get_ydata'
# Use this function to fetch financial data for full years.
# Here I am Retrieving yearly data for "Revenues" for the years 2020 to 2023
yearly_data <- get_ydata(account = "Revenues", years = 2020:2023)

View(yearly_data)
#___________________________________________________________________

# 3. 'prepare_data'
# This function combines and organizes multiple datasets into one.
#"df" is a dataframe obtained from either get_qdata or get_ydata
# Here the data is prepped without specifying quarterly or yearly, defaults to quarterly
prepared_data <- prepare_data(df = df)
#___________________________________________________________________

# 4. 'retrieve_data'
# Directly fetch specific financial details from the EDGAR database.
# Retrieve financial data for "Revenues", year 2022, and quarter Q1
retrieved_data <- retrieve_data(account = "Revenues", year = 2022, quarter = "Q1")

View(retrieved_data)

# Example: Retrieve Google's operating income for the first quarter of 2021 to perform detailed financial analysis.
google_operating_income_Q1_2021 <- retrieve_data(account = "OperatingIncomeLoss", 
                                                 year = 2021, quarter = "Q1")
print(google_operating_income_Q1_2021)
View(google_operating_income_Q1_2021)

#___________________________________________________________________

# 5. 'safe_max'
# This calculates the max value in a dataset, safely ignoring missing values.
# Example: Determine the highest stock price in a portfolio during a certain period
# And it ignores days when the market was closed or if data is missing to help with our analysis
## Calculate the maximum value from a vector, safely ignoring NA values
max_value <- safe_max(c(NA, 1, 5, 10), na.rm = TRUE)
