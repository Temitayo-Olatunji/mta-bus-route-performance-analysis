
# MTA Bus Route Segment Performance Analysis

## Project Overview

This project examines MTA bus route segment performance using data from January 2025 to July 2026. It explores multiple dimensions of bus operations, including travel time, route distance, trip volume, and average bus speeds.

The analysis investigates how performance varies across different route types, time periods, boroughs, travel directions, and individual route segments to identify operational patterns, performance differences, and potential areas for improvement.

The project follows an end-to-end data analytics workflow, involving data preparation, cleaning, SQL-based analysis, and interactive Power BI visualization to derive meaningful insights from the dataset.

## Project Objectives

- Explore the dataset to understand its structure, contents and key variables.
- Validate the data and address identified data quality issues
- Analyze bus route segment performance using SQL Server.
- Compare performance across route types, hours of the day, boroughs and directions of travel.
- Identify individual segments with notably low recorded average speeds.
- Develop an interactive Power BI dashboard to present the findings
- Document the findings, limitations and potential areas for further investigation.


## Dataset

**Source:** [Data.gov](https://catalog.data.gov/)

**Dataset:** MTA Bus Route Segment Speeds: Beginning 2025.

**Period Covered:** January 2025 – July 2026.
The dataset contains aggregated bus route segment observations across different days of the week, monthly periods, hours, route types, and geographic locations.

## Tools & Technologies

- **Microsoft Excel:** Initial data inspection and preparation.
- **SQL Server 2022 (SSMS):** Data cleaning, transformation, querying, and analysis.
- **Microsoft Power BI:** Data modelling, visualization, and interactive dashboard development.

## Data Preparation & Cleaning

The data preparation process involved:

- Inspecting the raw dataset and assessing data quality.
- Validating column values and data types.
- Creating cleaned and transformed SQL views.
- Addressing inconsistent day-of-week values.
- Handling missing speed values through imputation.
- Checking for duplicate records and validating the resulting dataset.

## Analysis & Visualization

The analysis was presented through five interactive Power BI dashboard pages:

1. **Overview:** High-level performance metrics and overall bus speed patterns.
2. **Time Trend:** Performance variations across months and hours.
3. **Route Performance Trends:** Comparison of performance across route types and segments.
4. **Geographic & Direction:** Analysis of speed variations across boroughs and travel directions.
5. **Segments:** Detailed examination of individual route segment performance.

## Key Findings

- Express buses recorded the highest average speed at approximately 14+ mph.
- Local buses recorded an average speed of approximately 8.53 mph.
- Average speeds were generally lower during the afternoon, particularly between 2 PM and 4 PM.
- Early morning hours, particularly around 3 AM, recorded higher average speeds.
- Manhattan recorded the lowest average speed among the boroughs at approximately 7 mph, while Staten Island recorded approximately 11.7 mph.


## Exploratory Data Analysis (EDA)

The exploratory analysis examined bus speed variations across route types, time periods, boroughs, and individual route segments.

The analysis revealed differences in average travel speeds across service types and geographic areas, as well as temporal patterns in bus performance. Afternoon periods generally recorded lower average speeds, while early morning hours showed relatively higher speeds.

These findings provide an overview of MTA bus segment performance and highlight variations that may warrant further operational investigation.


