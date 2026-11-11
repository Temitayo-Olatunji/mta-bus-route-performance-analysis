
# MTA Bus Route Segment Performance Analysis

## 1. Project Overview

This project examines MTA bus route segment performance data covering January 2025 to July 2026. The analysis investigates variations in average road speed, road distance, average travel time and bus trip volume across route types, hours of the day, boroughs, directions of travel and individual route segments.

The project follows an end-to-end data analytics workflow, beginning with preliminary data exploration in Microsoft Excel, followed by data validation, preparation and analysis in Microsoft SQL Server, and interactive visualisation in Microsoft Power BI.

The analysis focuses on identifying performance patterns, comparing different operational categories and highlighting individual route segments with notably low average speeds.

The final output is an interactive five-page Power BI dashboard supported by SQL-based data preparation and analysis.

## 2. Project Background

Public bus transportation performance can be examined through several operational measures, including road distance, average travel time, average road speed and bus trip volume.

Examining these measures across different route types, geographical areas, directions of travel and periods of the day provides an opportunity to understand variations in recorded bus segment performance.

This project uses the Metropolitan Transportation Authority (MTA) dataset, which provides aggregated observations of bus route segment performance.

Rather than representing individual bus trips, each record summarises the performance of a particular route segment for a specific hour and day of the week within a given month and year.

Understanding this data structure is important when interpreting the results and making comparisons across different categories.

## 3. Project Aim

To analyse MTA bus route segment performance data and identify patterns and differences in average road speed, travel time, road distance and bus trip volume across route types, times of the day, boroughs, directions of travel and individual route segments.

## 4. Project Objectives

The project was guided by the following objectives:

- Explore the dataset to understand its structure, contents and key variables.
- Validate the data and address identified data quality issues.
- Prepare the dataset for analysis using SQL Server.
- Analyse bus route segment performance using SQL queries.
- Compare performance across route types, hours of the day, boroughs and directions of travel.
- Identify individual segments with notably low recorded average speeds.
- Examine variations in performance across different trip-volume groups.
- Develop an interactive Power BI dashboard to communicate the findings.
- Document the findings, recommendations, limitations and potential areas for further investigation.

## 5. Dataset Description

**Dataset:** MTA Bus Route Segment Speeds: Beginning 2025

**Source:** [Data.gov](https://catalog.data.gov/)

**Format:** CSV

The dataset contains information relating to bus route segments, including road distance, average travel time, average road speed, bus trip counts, route classifications, geographic information and time-related attributes.

The original CSV file was initially inspected in Microsoft Excel before being imported into SQL Server for further validation, preparation and analysis.

### 5.2 Data Coverage

The analysis covers January 2025 to July 2026, as represented in the dataset.

The final month, July 2026, was treated with caution because it may contain only a partial month's observations.

### 5.3 Dataset Structure and Grain

The working dataset contains:

- **Rows:** 1,048,575
- **Columns:** 24
- **Observation type:** Aggregated bus route segment performance.

Each row represents the recorded performance of a particular route segment for a specific hour and day of the week within a given month and year.

The Bus Trip Count field indicates the number of trips represented by each aggregated observation.

Consequently, individual rows should not be interpreted as separate bus trips or as observations for every individual calendar date.

This distinction informed the approach to duplicate checking, aggregation and interpretation throughout the project.

### 5.4 Key Variables

The following variables were particularly relevant to the analysis:

| Variable | Description |
|---|---|
| Timestamp | Monthly time-period field associated with the aggregated observations. |
| Day of the Week | Day-of-week category associated with the observation. |
| Hour of the Day | Hour associated with the observation, represented on a 24-hour scale. |
| Route ID | Identifier for the bus route. |
| Route Type | Classification of the route, such as Local, Express, Limited, SBS or School. |
| Borough | Geographic borough category associated with the observation. |
| Direction | Direction of travel: north, south, east or west. |
| Stop Order | Sequence of a segment within a route. |
| Time Point Stop ID | Identifier for the starting time-point stop. |
| Time Point Stop Name | Name of the starting time-point stop. |
| Next Time Point Stop ID | Identifier for the next time-point stop. |
| Next Time Point Stop Name | Name of the next time-point stop. |
| Road Distance | Recorded segment distance in miles. |
| Average Travel Time | Average recorded segment travel time in minutes. |
| Average Road Speed | Recorded average segment speed in miles per hour. |
| Bus Trip Count | Number of bus trips represented by the aggregated observation. |
| Geographic Coordinates | Latitude and longitude associated with the segment's time-point stops. |

Other fields provide additional route, stop and geographic reference information.

### 5.5 Performance Measures

Four principal measures were used throughout the analysis:

**Road Distance (miles)**

Describes the length of the recorded bus route segment.

**Average Travel Time (minutes)**

Represents the average recorded time associated with travelling along the segment.

**Average Road Speed (miles per hour)**

Represents the recorded average speed for the segment.

**Bus Trip Count**

Indicates the number of trips represented by an aggregated observation.

These measures were considered together rather than in isolation. For example, a longer segment may have a higher average travel time simply because it covers a greater distance. Similarly, a higher average speed does not automatically indicate better overall service performance.

---

## 6. Tools and Technologies

The following tools were used throughout the project:

| Tool | Application |
|---|---|
| Microsoft Excel | Preliminary data exploration and inspection of the original CSV dataset. |
| Microsoft SQL Server 2022 | Data validation, cleaning, transformation, analytical queries and creation of a cleaned SQL view. |
| Microsoft Power BI | Data modelling, visualisation, dashboard development and interactive reporting. |
| Microsoft Word | Project documentation and reporting. |

---

## 7. Data Preparation and Validation

### 7.1 Initial Data Exploration

The dataset was initially opened in Microsoft Excel for preliminary exploration.

This stage involved examining:

- Dataset structure and column names.
- Data types and recorded values.
- Available route classifications.
- Geographic and time-related attributes.
- Main numerical performance measures.

The initial exploration helped establish the variables and dimensions relevant to the analysis before the dataset was imported into SQL Server.

### 7.2 Data Validation in SQL Server

SQL Server was used to conduct more systematic data quality checks.

The validation process focused on:

- Categorical consistency.
- Numerical ranges and invalid values.
- Time-related field consistency.
- Missing values.
- Exact duplicate records.
- Relationships between road distance, average travel time and average road speed.

### 7.3 Categorical Validation

Categorical fields were examined to identify missing or unexpected values.

The checks covered route types, boroughs, directions and route identifiers.

The route types identified included:

- Local
- Express
- Limited
- Select Bus Service (SBS)
- School
- School Limited

The borough field also contained an `Other` category. This category was retained because its presence alone did not establish that the associated records were invalid.

### 7.4 Numerical Range Validation

The numerical performance fields were checked for negative values, zero values and values outside the observed ranges.

The checks covered:

- Road Distance.
- Average Travel Time.
- Average Road Speed.
- Bus Trip Count.

The observed maximum road distance was approximately 15.4 miles, while the maximum recorded average road speed was 39.9 mph.

No negative or zero values were identified in the numerical performance fields examined.

### 7.5 Time-Related Validation

The Timestamp and Hour of the Day fields were examined for consistency.

The hour component of the Timestamp field was compared with the recorded Hour of the Day values.

No mismatches were identified.

The Day of the Week field was treated separately because the dataset contains aggregated observations associated with day-of-week categories and monthly periods, rather than separate observations for every calendar date.

### 7.6 Duplicate and Data Grain Checks

The dataset was checked for exact duplicate records.

**Result: No exact duplicate records were identified.**

Repeated combinations of selected fields were also investigated.

However, repeated combinations were not automatically treated as duplicates because multiple aggregated observations can legitimately share identifying attributes while differing in performance measures or other fields.

The dataset's grain was therefore considered before determining whether records should be retained or removed.

### 7.7 Missing Values and Treatment

During data validation, 172 missing values were identified in the Average Road Speed field.

No other missing values were identified in the columns examined.

The corresponding Road Distance and Average Travel Time values were available for all 172 records.

To retain these observations for analysis, the missing average speed values were calculated using the relationship between distance and travel time.

**Calculation:**

`Calculated Average Road Speed = (Road Distance / Average Travel Time) × 60`

The calculation converts travel time from minutes to hours, allowing the resulting speed to be expressed in miles per hour.

Two additional fields were incorporated into the cleaned dataset:

- `Speed Clean`: Provided the average road speed values used in the final analysis, including calculated replacements.
- `Speed Imputed`: Identified records where the original average road speed was missing and a calculated replacement was used.

This approach retained the affected observations while distinguishing calculated values from originally recorded speeds.

### 7.8 Validation of Performance Measures

The relationship between road distance, average travel time and average road speed was examined to assess the consistency of the recorded measures.

The calculated speed was compared with the recorded Average Road Speed using the same formula:

`Calculated Speed (mph) = (Road Distance / Average Travel Time) × 60`

Approximately 99% of the assessed records had an absolute difference of less than 0.5 mph between the recorded and calculated speeds.

This indicated a strong degree of consistency among the three performance measures for most of the records examined.

The comparison was used as a validation check and did not establish that every individual value was error-free.

### 7.9 Creation of the Cleaned SQL View

A SQL view named `MTA_Clean` was created to provide a consistent dataset for subsequent analysis.

The view retained the original dataset columns and incorporated two additional fields:

- `Speed Clean`
- `Speed Imputed`

The cleaned speed field provided the values used in the final analysis, while the imputation flag identified records with calculated replacement values.

The cleaned view was subsequently used as the data source for the Power BI dashboard.

---

## 8. Exploratory Data Analysis (EDA)

### 8.1 Analytical Approach

Exploratory Data Analysis was conducted to understand the characteristics of the dataset, identify performance patterns and compare results across relevant categories and time periods.

SQL Server was used to calculate descriptive statistics and aggregated performance measures across:

- Route types.
- Hours of the day.
- Monthly periods.
- Boroughs.
- Directions of travel.
- Individual route segments.
- Bus trip-volume groups.

The results informed the development of the Power BI dashboard.

The analysis is descriptive. Differences between groups are reported as observed patterns and are not interpreted as proof of causation.

### 8.2 Overview Analysis

The Overview dashboard provides a summary of the dataset and its principal performance measures.

The page presents the following key performance indicators:

- Average Travel Time.
- Total Records.
- Average Road Distance.
- Total Bus Trips.
- Average Road Speed.

It also includes visualisations showing:

- Average road speed by route type.
- Average road speed by hour of the day.
- Total bus trips by month.

Route type, date and borough slicers allow users to filter the results and examine performance from different perspectives.

### 8.3 Time and Trend Analysis

The Time & Trend analysis investigated variations in average road speed, average road distance and average travel time across hours of the day and monthly periods.

#### Hourly Performance

Average road speed was highest during the early hours of the morning, reaching approximately 12 mph around 3 a.m.

Speeds generally declined as the day progressed, reaching approximately 7.97–7.93 mph between 2 p.m. and 4 p.m., before beginning to recover later in the evening.

Average travel time also varied throughout the day.

Between 8 a.m. and 9 a.m., average travel time declined from approximately 10.30 minutes to 9.92 minutes.

It subsequently increased from approximately 9.95 minutes at 10 a.m. to its highest observed hourly value of approximately 11.62 minutes at 4 p.m.

Travel time then declined to:

- 11.35 minutes at 5 p.m.
- 10.48 minutes at 6 p.m.
- 9.63 minutes at 7 p.m.

It continued declining towards approximately 7.91 minutes later in the evening.

The afternoon increase in travel time, alongside lower average road speeds, indicates slower recorded segment performance during parts of this period.

Average road distance remained relatively stable throughout the day, suggesting that the changes in travel time were not accompanied by similarly large changes in average segment distance.

Although traffic conditions may contribute to these variations, the available dataset does not establish their cause.

#### Monthly Performance

Between January 2025 and July 2026:

- Average road distance remained relatively stable at approximately 1.4–1.5 miles.
- Average road speed fluctuated between approximately 9.0 and 9.4 mph.
- Average travel time ranged from approximately 9.2 to 9.8 minutes.

Although the measures fluctuated across individual months, the analysis did not reveal a clear, sustained upward or downward trend.

The monthly averages were therefore relatively stable overall, despite smaller month-to-month variations.

### 8.4 Route Type Analysis

The Route Type analysis compared performance across six route categories:

- Local
- Limited
- Express
- Select Bus Service (SBS)
- School
- School Limited

The comparison considered average road speed, road distance, average travel time and bus trip volume.

#### Key Observations

**Express Routes**

Express routes recorded the highest average road speed and the longest average road distance among the route types.

However, they also recorded relatively high average travel times. This demonstrates why speed and travel time should be considered alongside segment distance.

**Local Routes**

Local routes accounted for the largest share of recorded bus trips, making them an important category within the dataset.

Their average road distance was relatively short, while their average speed was lower than that of Express routes.

**School and School Limited Routes**

These categories had substantially fewer observations than the major route categories.

Their averages should therefore be interpreted cautiously because they are based on a smaller volume of recorded data.

Overall, route type was associated with differences in speed, distance, travel time and trip volume.

### 8.5 Geographic and Directional Analysis

The Geographic & Direction dashboard examined differences in average road speed, road distance and travel time across boroughs and directions of travel.

#### Borough-Level Performance

The average road speeds recorded across the borough categories were:

| Borough | Average Road Speed |
|---|---:|
| Manhattan | 7.1 mph |
| Brooklyn | 8.1 mph |
| Bronx | 9.7 mph |
| Queens | 10.1 mph |
| Staten Island | 11.7 mph |
| Other | 17.7 mph |

Manhattan recorded the lowest average road speed among the named boroughs, while Staten Island recorded the highest.

The `Other` category recorded the highest average speed, alongside:

- Average road distance: approximately 5.2 miles.
- Average travel time: approximately 18.5 minutes.

Because this category does not identify a specific borough, its results should be considered separately from the named boroughs.

The longer average segment distance also provides important context when interpreting its travel time and speed.

The observed differences may reflect variations in road conditions, traffic patterns and route characteristics, although the dataset does not establish which factors explain them.

#### Directional Performance

Average road speeds across the four directions were relatively similar, falling within an approximate range of 9.1–9.7 mph.

The analysis identified the following differences:

- **Northbound:** Highest average speed and longest average road distance.
- **Southbound:** Highest average travel time.
- **Eastbound:** Shortest average road distance and lowest average speed.
- **Westbound:** Lowest average travel time.

These results show that direction of travel was associated with variations in the recorded performance measures, although the differences in average speed were modest.

### 8.6 Individual Segment Analysis

The Segment Table dashboard examined individual route segments to identify those with notably low average road speeds.

The slowest recorded segment in the analysis connected:

**Queens Borough Bridge exit → 2nd Ave/E 61 St**

Its recorded performance measures were:

| Measure | Value |
|---|---:|
| Average Road Speed | 2.99 mph |
| Average Road Distance | 0.09 miles |
| Bus Trips | 11,745 |

The segment recorded a notably low average speed despite the substantial number of trips represented in the data.

However, the result does not establish the reason for the low speed. Further investigation would be required to determine whether traffic conditions, road layout or other operational circumstances contributed to the observed performance.

The analysis of the ten slowest segments also showed that most were shorter than one mile and distributed across different boroughs.

This suggests that the low-speed observations were not limited to a single geographic area within the selected segments.

**Segment Table Filtering**

Forty-five records with blank start-stop names were excluded from the segment-level presentation to ensure that the displayed results could be associated with identifiable segment names.

This filtering applied only to the segment-level presentation. It does not mean these records were removed from the entire dataset or the other analyses.

### 8.7 Trip Volume Analysis

The trip volume analysis examined how recorded performance measures varied across different bus trip-count groups.

Observations were grouped into the following categories:

- 1–5 trips.
- 6–10 trips.
- 11–20 trips.
- 21–40 trips.
- 41 or more trips.

Average road speed, average road distance and average travel time were compared across these groups.

The analysis showed that:

- Lower trip-count groups generally had longer average road distances and relatively high average road speeds.
- The 21–40 trip group recorded the highest average travel time.
- The relationship between trip volume and the performance measures was not consistent across all categories.

These results indicate that higher trip counts did not correspond to a uniform increase or decrease in average speed, distance or travel time.

The comparisons are descriptive and do not establish that trip volume caused the observed differences.

---

## 9. Power BI Dashboard Development

An interactive five-page dashboard was developed in Microsoft Power BI to communicate the results of the analysis.

The dashboard was structured to allow users to explore performance at different levels, from overall indicators to individual route segments.

### Dashboard Pages

**Page 1: Overview**

Presents the main performance indicators and selected comparisons across route types, hours of the day and monthly bus trip volumes.

**Page 2: Time & Trend**

Examines hourly and monthly variations in average road speed, average road distance and average travel time.

**Page 3: Route Type**

Compares performance measures across Local, Limited, Express, SBS, School and School Limited routes.

**Page 4: Geographic & Direction**

Examines differences across boroughs and directions of travel.

**Page 5: Segment Table**

Provides a detailed segment-level view, allowing identification and comparison of individual segments with notably low average road speeds.

The dashboard also incorporates interactive filters, including route type, date and borough, to support further exploration of the data.

---

## 10. Key Findings

The analysis identified several differences in bus route segment performance across time, route types, geographic areas and individual segments.

The principal findings were:

1. **Hourly performance variations:** Average road speeds were generally lower during parts of the afternoon, while average travel time reached its highest observed hourly value of approximately 11.62 minutes at 4 p.m.

2. **Differences across route types:** Express routes recorded higher average speeds and longer average distances, while School routes recorded the lowest average speed. Local routes accounted for the largest volume of recorded trips.

3. **Geographic differences:** Average road speeds varied across boroughs, with Manhattan recording the lowest average among the named boroughs and Staten Island recording a higher average.

4. **Directional performance:** Average speeds across the four directions were relatively similar, although differences were observed in average distance and travel time.

5. **Individual segment performance:** Some individual segments recorded particularly low average speeds, demonstrating that broader averages can conceal substantial variation between specific locations.

6. **Monthly performance:** Monthly averages remained relatively stable throughout the study period, with no clear sustained upward or downward trend in the principal performance measures.

7. **Trip volume:** Comparisons across trip-count groups showed no consistent relationship between trip volume and all performance measures.

Taken together, these findings demonstrate the importance of considering multiple performance measures and levels of analysis rather than relying on a single overall average.

---

## 11. Recommendations

Based on the findings, the following recommendations are proposed:

### 11.1 Investigate Periods of Lower Average Speed

The afternoon decline in average road speed, alongside the increase in average travel time, warrants further investigation.

Additional traffic and operational data could help determine the factors contributing to the observed pattern.

### 11.2 Examine Individual Low-Speed Segments

Segments with notably low average speeds could be investigated further to understand whether their performance is associated with road conditions, traffic patterns or other operational factors.

The segment-level analysis provides a starting point for identifying locations that may require closer examination.

### 11.3 Evaluate Performance Using Multiple Measures

Average road speed should not be used as the sole measure of route performance.

Road distance, average travel time and bus trip volume should also be considered because route types and individual segments differ in their characteristics.

### 11.4 Review Geographic Differences in Greater Detail

The observed variation in average road speed across boroughs provides a basis for more detailed investigation.

Further analysis incorporating traffic conditions, road characteristics and route composition could help explain these differences.

### 11.5 Interpret Low-Volume Categories Cautiously

The School and School Limited categories had substantially fewer recorded observations than the major route categories.

Their results should be considered in the context of the available data before drawing broader conclusions about their performance.

### 11.6 Continue Monitoring Performance Over Time

The monthly analysis did not reveal a clear, sustained trend in the principal performance measures.

Continued monitoring could help establish whether the observed patterns remain stable or whether more substantial changes emerge in future reporting periods.

---

## 12. Limitations of the Analysis

The analysis was subject to the following limitations:

### 12.1 Aggregated Data

The dataset contains aggregated route segment observations rather than individual bus-trip records.

Consequently, the analysis describes average performance within the available groups and does not represent the experience of every individual bus trip.

### 12.2 Limited Explanation of Causes

The dataset contains performance measures such as average road speed, road distance and average travel time, but does not establish the reasons behind the observed differences.

Factors such as traffic congestion and road conditions may be relevant, but additional data would be required to investigate their influence.

### 12.3 Differences in Data Volume

The number of observations and trips varied across route types and trip-count groups.

Categories with fewer observations, particularly School and School Limited, provide a less comprehensive basis for comparison than categories with larger data volumes.

### 12.4 Undefined Geographic Category

The `Other` borough category recorded notably different averages from the named boroughs.

Because its geographic composition is not clearly identified, its results cannot be directly interpreted as representing a specific borough.

### 12.5 Exclusion of Records from the Segment Table

Forty-five records with blank start-stop names were excluded from the segment-level presentation to allow the displayed results to be associated with identifiable segment names.

These records were not necessarily excluded from the other analyses.

### 12.6 Scope of the Analysis

The project focused on descriptive analysis and comparisons using the available variables.

It did not establish causal relationships or investigate every factor that may influence bus route segment performance.

---

## 13. Conclusion

This project analysed MTA bus route segment performance data covering January 2025 to July 2026 using Microsoft Excel, Microsoft SQL Server and Microsoft Power BI.

Excel was used for preliminary data exploration, SQL Server supported data validation, preparation and analysis, and Power BI was used to develop an interactive dashboard presenting the findings.

The analysis identified variations in average road speed, road distance and travel time across hours of the day, route types, boroughs, directions of travel and individual route segments.

It also highlighted the importance of considering multiple performance measures together, as differences in average speed alone did not provide a complete picture of route segment performance.

The project demonstrates how data preparation, SQL-based analysis and interactive visualisation can be combined to examine a large dataset and communicate findings in a structured way.

Although the available data did not establish the causes of the observed differences, the results identified patterns and individual segments that could be investigated further using additional traffic and operational information.

---

## 14. Project Files

The repository will contain the supporting materials used throughout the project:

- SQL scripts used for data validation, cleaning and analysis.
- Power BI dashboard file and screenshots.
- Supporting project documentation.
- Dataset source information.

---

## 15. References

**Dataset:** MTA Bus Route Segment Speeds: Beginning 2025.

**Source:** Data.gov / Metropolitan Transportation Authority (MTA).






