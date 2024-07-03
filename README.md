# Financial Modeling: using 'Tidyedgar' Package to pull data from EDGAR Database, Analysis, Visualization, Dashboard

## Project Overview
This project showcases the use of the `Tidyedgar` package for financial modeling. The package provides easy access to EDGAR data, making it a powerful tool for financial analysis.

## Project Purpose
The purpose of this project was to:
- Demonstrate how to utilize R programming for financial modeling.
- Showcase the `Tidyedgar` package to pull EDGAR data directly into R Studio.
- Provide examples of how to pull data and perform analysis.
- Use packages like `ggplot2` and `plotly` to visualize outcomes with various examples.
- Create a Shiny app to wrap up the findings and provide an interactive dashboard for future use.

## Installation
To install the required packages, run the following commands in R:

```R
install.packages("tidyedgar")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("shiny")

## Usage
### Data Retrieval
```R
# Example code snippet
df <- yearly_data(years = 2015:2023)
```

## Data Processing & Visualization
```R
# Example code snippet
ggplot(annual_summary, aes(x = year, y = total_assets, color = company_name, group = company_name)) +
  geom_line(size = 1.5) +
  theme_minimal() +
  labs(title = "Total Assets Over Time by Company", x = "Year", y = "Total Assets (USD)")
```

## Interactive Dashboard
```R
# Example code snippet
shinyApp(ui = ui, server = server)
```

## Visualizations
Here are some visualizations from the project:
1. **Total Assets Over Time by Company**:
   ![Total Assets Over Time by Company](./Visual Outputs form the analysis/Total Asset.png)
2. **Asset to Liability Ratio Over Time**:
   ![Asset to Liability Ratio Over Time](./Visual Outputs form the analysis/Asset to Liability Ratio.png)
3. **Net Income by Company Over Time**:
   ![Net Income by Company Over Time](./Visual Outputs form the analysis/Net Income by Company.png)
4. **Average Net Margin Over Time**:
   ![Average Net Margin Over Time](./Visual Outputs form the analysis/Average Net Margin.png)
5. **Total Liabilities Over Time by Company**:
   ![Total Liabilities Over Time by Company](./Visual Outputs form the analysis/Total Liabilities.png)



## Interactive Dashboar

R SHINY APP

## Learn more about this from my
- [PowerPoint Presentation](https://docs.google.com/presentation/d/1KhCNE80N4W3HhX1Dh6JBaslNPAcB6HBz/edit?usp=share_link&ouid=103894204561373706275&rtpof=true&sd=true)
- [LinkedIn Post](link_to_linkedin_post)


