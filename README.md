# Virginia COVID-19 Exploratory Analysis Using SQL

## Introduction

The COVID-19 pandemic has significantly impacted our lives in many ways. As the pandemic continues to evolve, tracking and analyzing the data related to it has become increasingly important. In an effort to contribute to this effort, I undertook a project to collect and analyze COVID-19 data from Virginia.

To do this, I retrieved covid-19 data from the [Virginia Opend Data Portal](https://data.virginia.gov/Government/VDH-COVID-19-PublicUseDataset-Cases/bre9-aqqr) which contains data on cases, hospitalizations, and deaths. I then uploaded this data to a PostgreSQL SQL database to prepare the data for analysis.

The ultimate goal of this project was to use the cleaned and prepared data to create a dashboard in Tableau that would allow users to visualize and explore COVID-19 trends in Virginia.


## Approach
To create a meaningful visualization of the COVID-19 data from Virginia, I started by importing the data into a PostgreSQL SQL database. After cleaning and transforming the data, I used SQL to create new columns that represented the daily counts of new cases, new hospitalizations, and new deaths.

To ensure the accuracy of these new columns, I utilized window functions and the 'LAG' function to aggregate over the rolling totals. After completing the data preparation stage, I explored the data in SQL to identify trends and patterns that could be highlighted in the final Tableau dashboard.


## Results
After exploring and analyzing the data using SQL, I created a Tableau dashboard that visualizes the new COVID-19 cases by location and date. The dashboard presents the data in an interactive and easy-to-understand way, allowing users to filter the results by location and date range.

The final dashboard includes various visualizations, including a line chart that displays the daily new cases over time, a map that shows the geographic distribution of the cases, and a table that presents the total new cases by.

Overall, the dashboard provides valuable insights into the spread of COVID-19 in Virginia. An image of the dashboard is provided below. 


<img width="976" alt="image" src="https://user-images.githubusercontent.com/65142541/233910461-b8bc4074-3abb-4634-9d70-ec62c472914a.png">
