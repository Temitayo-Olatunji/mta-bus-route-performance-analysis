
-- MTA BUS ROUTE SEGMENT PERFORMANCE ANALYSIS
-- Database: MTA Bus Performance
-- Table: dbo.MTA 1

-- OBJECTIVES
-- Evaluate bus route segment peformance to identify differences across 
-- service types, time, geography, direction, monthly periods and trip volume.

-- Dataset Coverage
-- January 2025 - July 2026

-- Key Performance Measures:
-- Road Distance: miles
-- Average Travel Time: minutes
-- Average Road Speed: miles per hour
-- Bus Trip Counts: number of bus trips represented

-- 1. DATA VALIDATION

-- 1.1 Dataset Size

-- Total rows in the dataset
  Select count (*) as no_of_rows
  From [mta 1]
  
-- Total Columns
  Select count (*) as no_of_columns
  From sys.columns
  Where object_id = object_id('dbo.mta 1')

-- Dataset Range
   select 
   min(timestamp) as earliest_timestamp,
   max(timestamp) as latest_timestamp
   from [mta 1]

-- 1.2 Missing Value/Null Checks

  Select  count (*) as Total_rows,
  sum(case when route_id is null then 1 else 0 end),
  sum(case when direction is null then 1 else 0 end),
  sum(case when borough is null then 1 else 0 end),
  sum(case when route_type is null then 1 else 0 end),
  sum(case when road_distance is null then 1 else 0 end),
  sum(case when average_travel_time is null then 1 else 0 end),
  sum(case when average_road_speed is null then 1 else 0 end),
  sum(case when bus_trip_count is null then 1 else 0 end)
  From [mta 1]

-- 1.3 Investigating the Nulls
 
  Select Timestamp, count(*) as null_speed_count
  From [mta 1]      
  Where Average_Road_Speed is null
  Group by Timestamp
  Order by Timestamp

  Select Route_Type, count(*) as null_speed_count
  From [mta 1]      
  Where Average_Road_Speed is null
  Group by Route_Type
  Order by null_speed_count desc

  Select count(*) as null_speed_rows,
  Sum(case when road_distance is null then 1 else 0 end) as null_distance,
  Sum(case when average_travel_time is null then 1 else 0 end) as null_travel_time
  From [mta 1]      
  Where Average_Road_Speed is null
 
  With diff_check as(
  Select
  Road_Distance, Average_Travel_Time, Average_Road_Speed, 
  (Road_Distance/Average_Travel_Time)* 60 as calculated_speed,
  Average_Road_Speed - ((Road_Distance/Average_Travel_Time)* 60) as difference
  From [mta 1]      
  Where Average_Road_Speed is not null)
 
  Select case when abs(difference) < 0.5 then 'under 0.5' else 'over 0.5' end as group_gap, 
  Count(*) as row_count,
  Count (*) * 100/sum(count(*)) over() as percentage
  From diff_check
  Group by case when abs(difference) < 0.5 then 'under 0.5' else 'over 0.5' end

  Select avg(abs(Average_Road_Speed - ((Road_Distance/Average_Travel_Time)* 60)))
  As avg_abs_difference,
  Max(abs(Average_Road_Speed - ((Road_Distance/Average_Travel_Time)* 60)))
  As max_abs_difference
  From [mta 1]      
  Where Average_Road_Speed is not null

-- 1.4  Null Solutions
  Create view mta1_clean as
  Select *, coalesce(average_road_speed, 
  (Road_Distance/Average_Travel_Time)* 60) as speed_clean,
  Case when Average_Road_Speed is null then 1 else 0 end as speed_imputed
  From [mta 1]
  
  Select count(*), sum(speed_imputed) as filled_in
  From mta1_clean

-- 1.5  Duplicate Checks

   Select Route_ID, Direction, Timepoint_Stop_ID, Next_Timepoint_Stop_ID, Timestamp,
   Day_of_Week, Hour_of_Day, count(*) as row_count, route_type, Bus_Trip_Count, Stop_Order
   From [mta 1]
   Group by
   Route_ID, Direction, Timepoint_Stop_ID, Next_Timepoint_Stop_ID, Timestamp,
   Day_of_Week, Hour_of_Day, route_type, Bus_Trip_Count, Stop_Order
   Having count(*) > 1
     
   Select *
   From [mta 1]
   Where Route_ID = 'B1'
   And Direction = 'N'
   And Timepoint_Stop_ID = '300000'
   And Next_Timepoint_Stop_ID = '300012'
   And Day_of_Week = 'Monday'
   And cast(Timestamp as date) = '2025-01-01'
   And Hour_of_Day = '14'

   Select *
   From [mta 1]
   Where Route_ID = 'B14'
   And Direction = 'E'
   And Timepoint_Stop_ID = '301545'
   And Next_Timepoint_Stop_ID = '301551'
   And Day_of_Week = 'Sunday'
   And cast(Timestamp as date) = '2026-06-01'
   And Hour_of_Day = '0'
  
 -- 1.6  Blank Checks (no blanks)
   Select count(Route_ID)
   From [mta 1]
   Where trim(Route_ID) = ''

-- 1.7  Validating Dates

   Select top 40
   Timestamp
   From [mta 1]
   Order by Timestamp desc

-- Checking whether hour of the day is consistent with extracted hour from timestamp
   select 
   Timestamp, DATEPART(hour, Timestamp) as extracted_hour,Hour_of_Day
   from [mta 1]

   select 
   Timestamp, DATEPART(hour, Timestamp) as extracted_hour,Hour_of_Day
   from [mta 1]
   Where DATEPART(hour, Timestamp)<> Hour_of_Day

-- 1.8  Validating Categorical Data (showing unique)

   Select distinct(Direction)
   From [mta 1]

   Select distinct(Borough)
   From [mta 1]

   Select distinct(Route_Type)
   From [mta 1]

   Select distinct(Day_of_Week)
   From [mta 1]

-- 1.9  Validating Numeric Data

   Select Road_Distance
   From [mta 1]
   Where Road_Distance <= 0

   Select Average_Travel_Time
   From [mta 1]
   Where Average_Travel_Time <= 0

   Select Average_Road_Speed
   From [mta 1]
   Where Average_Road_Speed <= 0

   Select count(Bus_Trip_Count)
   From [mta 1]
   Where (Bus_Trip_Count)<= 0

   Select 
   max(Road_Distance) as max_dis,
   max(Average_Road_Speed) as max_speed
   From [mta 1]

-- 1.10  Data Grain Validation
   select Route_ID, Direction, Route_Type, Timepoint_Stop_ID, 
   Next_Timepoint_Stop_ID, Timestamp, Day_of_Week, Hour_of_Day,
   Count(*) as row_count
   From [mta 1]
   Group by
   Route_ID, Direction, Route_Type, Timepoint_Stop_ID, 
   Next_Timepoint_Stop_ID, Timestamp, Day_of_Week, Hour_of_Day
   Having count(*) > 1
   Order by row_count desc

-- 2.0  OVERALL DESCRIPTIVE ANALYSIS

   With stats as (
   Select 
   Min(average_road_speed) as min_average_road_speed,
   Max(average_road_speed) as max_average_road_speed, 
   Avg(average_road_speed) as avg_average_road_speed,

   Min(average_travel_time) as min_average_travel_time,
   Max(average_travel_time) as max_average_travel_time, 
   Avg(average_travel_time) as avg_average_travel_time,

   Min(road_distance) as min_road_distance,
   Max(road_distance) as max_road_distance, 
   Avg(road_distance) as avg_road_distance,

   Min(bus_trip_count) as min_bus_trip_count,
   Max(bus_trip_count) as max_bus_trip_count, 
   Avg(bus_trip_count) as avg_bus_trip_count
   From [mta 1]),
 
   Median as (
   Select distinct 
   Percentile_cont(0.5)within group(order by average_road_speed) 
   Over() as median_average_road_speed,

   Percentile_cont(0.5)within group(order by average_travel_time) 
   Over() as median_average_travel_time,

   Percentile_cont(0.5)within group(order by road_distance) 
   Over() as median_road_distance,

   Percentile_cont(0.5)within group(order by bus_trip_count) 
   Over() as median_bus_trip_count
   From [mta 1])

   Select 
  'Average_road_speed' AS measure,
  s.min_average_road_speed as min_value,
  s.max_average_road_speed as max_value,
  s.avg_average_road_speed as avg_value,
  m.median_average_road_speed as median_value
  From stats s
  Cross join median m

  Union all
  Select  'Average_travel_time', 
  s.min_average_travel_time,
  s.max_average_travel_time,
  s.avg_average_travel_time,
  m.median_average_travel_time

  From stats s
  Cross join median m

  Union all
  Select  'Road_distance',
  s.min_Road_distance,
  s.max_Road_distance,
  s.avg_Road_distance,
  m.median_Road_distance

  From stats s
  Cross join median m

  Union all
  Select  'Bus_trip_count',
  s.min_bus_trip_count,
  s.max_bus_trip_count,
  s.avg_bus_trip_count,
  m.median_bus_trip_count

  From stats s
  Cross join median m

  Select top 20
  Road_Distance, Average_Road_Speed, Average_Travel_Time, Bus_Trip_Count
  From [mta 1]
  Order by Road_Distance desc

-- 3.0  ROUTE TYPE PERFORMANCE

  Select route_type, avg(road_distance) as avg_road_distance, avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(average_travel_time)/avg(road_distance) as avg_travel_time_per_mile,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by Route_Type

-- 4.0  TIME OF DAY PERFORMANCE

  Select Hour_of_Day, avg(road_distance) as avg_road_distance, avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by Hour_of_Day 
  Order by  Hour_of_Day asc

-- 5.0  BOROUGH PERFORMANCE 

  Select Borough, avg(road_distance) as avg_road_distance, avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by Borough 
  Order by avg(Average_Road_Speed) desc

-- 6.0  DIRECTION PERFORMANCE

  Select Direction, avg(road_distance) as avg_road_distance, avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by Direction 
  Order by avg(Average_Road_Speed) desc

-- 7.0  MONTHLY PERFORMANCE

  Select Month(timestamp) as month,year(timestamp) as year, avg(road_distance) as avg_road_distance,
  Avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by Month(timestamp),year(timestamp) 
  Order by Month(timestamp),year(timestamp) asc

-- 8.0  BUS TRIP VOLUME

  Select case
  When Bus_Trip_Count between 1 and 5 then '1-5 trips'
  When Bus_Trip_Count between 6 and 10 then '6-10 trips'
  When Bus_Trip_Count between 11 and 20 then '11-20 trips'
  When Bus_Trip_Count between 21 and 40 then '21-40 trips'
  Else '41+ trips'
  End as trip_volume_range,

  Avg(road_distance) as avg_road_distance,
  Avg(Average_Road_Speed) as avg_road_speed, 
  Avg(Average_Travel_Time) as  avg_travel_time,
  Avg(Bus_Trip_Count) as avg_bus_trip_count, count(*) as row_count
  From [mta 1]
  Group by 
  Case
  When Bus_Trip_Count between 1 and 5 then '1-5 trips'
  When Bus_Trip_Count between 6 and 10 then '6-10 trips'
  When Bus_Trip_Count between 11 and 20 then '11-20 trips'
  When Bus_Trip_Count between 21 and 40 then '21-40 trips'
  Else '41+ trips'
  End 
  Order by min(bus_trip_count)
