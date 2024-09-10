SELECT * FROM road_accident;

-- create Month, Year, Day using Accident Date
SELECT Accident_Date
FROM road_accident;

-- create Acc_date column for accident date
ALTER TABLE road_accident
ADD Acc_date DATE;

-- Accident_Date column has date and time. so take only date from Accident_Date and insert in Acc_date column
UPDATE road_accident
SET Acc_date = CAST(Accident_Date AS DATE);

SELECT Acc_date 
FROM road_accident;
-- -------------------------------------------------------------------------------------------------------------------------
-- create column for month, day(number), Time and year separately

ALTER TABLE road_accident
ADD YEAR int;

ALTER TABLE road_accident
ADD Month VARCHAR(50);

ALTER TABLE road_accident
ADD Acc_Day int; -- in number


ALTER TABLE road_accident
ADD day_name VARCHAR(50); -- in char

-- Time
ALTER TABLE road_accident
ADD acc_time TIME;


-- drop
ALTER TABLE road_accident
DROP COLUMN Day;

--

UPDATE road_accident
SET YEAR = YEAR(Accident_Date);

UPDATE road_accident
SET Acc_Day = DAY(Accident_Date);

-- Time

UPDATE road_accident
SET acc_time = CAST(Time AS TIME);

-- In year, 1 means 'january'
UPDATE road_accident
SET MONTH =  CASE
	 WHEN MONTH(Accident_Date) = 1 THEN 'January'
    WHEN MONTH(Accident_Date) = 2 THEN 'February'
    WHEN MONTH(Accident_Date) = 3 THEN 'March'
    WHEN MONTH(Accident_Date) = 4 THEN 'April'
    WHEN MONTH(Accident_Date) = 5 THEN 'May'
    WHEN MONTH(Accident_Date) = 6 THEN 'June'
    WHEN MONTH(Accident_Date) = 7 THEN 'July'
    WHEN MONTH(Accident_Date) = 8 THEN 'August'
    WHEN MONTH(Accident_Date) = 9 THEN 'September'
    WHEN MONTH(Accident_Date) = 10 THEN 'October'
    WHEN MONTH(Accident_Date) = 11 THEN 'November'
    WHEN MONTH(Accident_Date) = 12 THEN 'December'
END;

-- To update day_name like 'Sunday'
UPDATE road_accident
SET day_name = DATENAME(WEEKDAY, Accident_Date);

-- -------------------------------------------------------------------------------------
-- To Find Total Casualties

SELECT * FROM road_accident;

SELECT SUM(Number_of_casualties) as TotalCasualties
FROM road_accident;

-- Group data by Accident_severity (serious, slight, Fatal)

SELECT Accident_Severity
FROM road_accident
WHERE Accident_Severity = 'Fetal';

UPDATE road_accident
set Accident_Severity = 'Fatal'
WHERE Accident_Severity = 'Fetal';

-- Total casualties by Accident_Severity
SELECT Accident_Severity, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Accident_Severity
ORDER BY TotalCasualties;


-- casualties by vehicle
ALTER TABLE road_accident
ADD Grouped_Vehicle VARCHAR(100); 

UPDATE road_accident
SET Grouped_Vehicle = Vehicle_Type;

UPDATE road_accident
SET Grouped_Vehicle = 'Car'
WHERE Grouped_Vehicle = 'Taxi/Private hire car';

UPDATE road_accident
SET Grouped_Vehicle = 'Bus'
WHERE Grouped_Vehicle = 'Bus or coach (17 or more pass seats)' 
OR Grouped_Vehicle = 'Minibus (8 - 16 passenger seats)';

UPDATE road_accident
SET Grouped_Vehicle = 'Van'
WHERE Grouped_Vehicle = 'Goods over 3.5t. and under 7.5t' 
OR Grouped_Vehicle = 'Goods 7.5 tonnes mgw and over'
OR Grouped_Vehicle = 'Van / Goods 3.5 tonnes mgw or under';

UPDATE road_accident
SET Grouped_Vehicle = 'Bike'
WHERE Grouped_Vehicle = 'Motorcycle 50cc and under' 
OR Grouped_Vehicle = 'Motorcycle over 500cc'
OR Grouped_Vehicle = 'Motorcycle over 125cc and up to 500cc'
OR Grouped_Vehicle = 'Motorcycle 125cc and under';

UPDATE road_accident
SET Grouped_Vehicle = 'Others'
WHERE Grouped_Vehicle = 'Other vehicle' 
OR Grouped_Vehicle = 'Pedal cycle'
OR Grouped_Vehicle = 'Ridden horse';



SELECT Vehicle_Type, SUM(Number_of_Casualties)
FROM road_accident
GROUP BY Vehicle_Type;


SELECT Grouped_Vehicle, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Grouped_Vehicle
ORDER BY TotalCasualties;

-- percentage of fatal, serious, slight severity

SELECT SUM(Number_of_Casualties) AS TotalCasualties
FROM road_accident; 

SELECT Accident_Severity, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Accident_Severity
ORDER BY TotalCasualties;


SELECT Accident_Severity,SUM(Number_of_Casualties) TotalCasualties, 
CAST(SUM(Number_of_Casualties) * 100 / (SELECT SUM(Number_of_Casualties) FROM road_accident)AS DECIMAL(10,2)) AS Percentage
FROM road_accident
GROUP BY Accident_Severity
ORDER BY Percentage;

-- percentage for vehicle type
SELECT Grouped_Vehicle, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Grouped_Vehicle
ORDER BY TotalCasualties;

SELECT Grouped_Vehicle, SUM(Number_of_Casualties) As TotalCasualties,
CAST(SUM(Number_of_Casualties) * 100 / (SELECT SUM(Number_of_Casualties) FROM road_accident)AS DECIMAL(10,1)) AS Percentage
FROM road_accident
GROUP BY Grouped_Vehicle
ORDER BY TotalCasualties;

-- casualties by road type
SELECT * FROM road_accident;

SELECT Road_Type, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Road_Type;


-- casualties by road surface

ALTER TABLE road_accident
ADD Grouped_road_surface VARCHAR(100);

UPDATE road_accident
SET Grouped_road_surface = Road_Surface_Conditions;

UPDATE road_accident
SET Grouped_road_surface = 'Wet'
WHERE Grouped_road_surface = 'Wet or damp'
OR Grouped_road_surface = 'Flood over 3cm. deep';

UPDATE road_accident
SET Grouped_road_surface = 'Snow/Ice'
WHERE Grouped_road_surface = 'Snow'
OR Grouped_road_surface = 'Frost or ice';


SELECT Grouped_road_surface, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Grouped_road_surface;

-- casualties by day / night
ALTER TABLE road_accident
ADD Grouped_light_conditions VARCHAR(100);

UPDATE road_accident
SET Grouped_light_conditions = Light_Conditions;

UPDATE road_accident
SET Grouped_light_conditions = 'Night'
WHERE Grouped_light_conditions = 'Darkness - lights lit'
OR Grouped_light_conditions = 'Darkness - lights unlit'
OR Grouped_light_conditions = 'Darkness - lighting unknown'
OR Grouped_light_conditions = 'Darkness - no lighting';

SELECT Grouped_light_conditions, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Grouped_light_conditions;

SELECT * FROM road_accident;
-- casualties by area (rural / urban)

SELECT Urban_or_Rural_Area, SUM(Number_of_Casualties) As TotalCasualties
FROM road_accident
GROUP BY Urban_or_Rural_Area;

