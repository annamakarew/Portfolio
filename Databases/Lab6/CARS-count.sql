-- Lab 6 - CARS
-- amakarew
-- Jun 1, 2023

USE `CARS`;
-- Query 1
-- For each European car maker (reported by their short name) report the average
mileage per gallon of a car produced by and the corresponding standard deviation (feel free to use STD() for all standard deviations in this lab). 
Sort output in ascending order by the BEST MILEAGE of a car produced by the car maker. Exclude any NULL values.

SELECT carmakers.Maker, AVG(MPG), STD(MPG)
FROM carmakers, countries, continents, makes, models, cardata
WHERE Country = countries.Id AND Continent = continents.Id 
    AND continents.Name = 'europe' AND carmakers.Id = models.Maker 
    AND models.Model = makes.Model AND makes.Id = cardata.Id
GROUP BY carmakers.Maker
HAVING AVG(MPG) IS NOT NULL AND STD(MPG) IS NOT NULL
ORDER BY MAX(MPG);


USE `CARS`;
-- Query 2
-- For each US car maker (reported by their short name),  report the number of 4-cylinder cars that are lighter than 4000 lbs , with 0 to 60 mph acceleration better than 14 seconds. Sort the output in descending order by the number of cars reported.

SELECT carmakers.Maker, COUNT(*)
FROM carmakers, countries, makes, models, cardata
WHERE Country = countries.Id AND countries.Name = 'usa' 
    AND carmakers.Id = models.Maker 
    AND models.Model = makes.Model AND makes.Id = cardata.Id
    AND Cylinders = 4 AND Accelerate < 14
GROUP BY carmakers.Maker
ORDER BY COUNT(*) DESC;


USE `CARS`;
-- Query 3
-- For each year in which honda produced more than 2 models, report the  best, the worst and the average gas mileage of  toyota  (this is NOT a typo!) vehicles produced that year. Report results in chronological order. 
NOTE: Solve this query WITHOUT using NESTED QUERIES/Subqueries!

SELECT dt.Year, MAX(dt.MPG), MIN(dt.MPG), AVG(dt.MPG)
FROM carmakers AS mak, models AS mo, makes AS ma1, makes AS ma2, makes AS ma3,
    cardata AS d1, cardata AS d2, cardata AS d3, carmakers AS makt, 
    models AS mot, makes AS mat, cardata AS dt
WHERE mak.Maker = "honda" AND mak.Id = mo.Maker AND mo.Model = ma1.Model
    AND mo.Model = ma2.Model AND mo.Model = ma3.Model AND ma1.Id != ma2.Id
    AND ma3.Id != ma2.Id AND ma1.Id != ma3.Id AND ma1.Id < ma2.Id
    AND ma2.Id < ma3.Id AND ma1.Id = d1.Id AND ma2.Id = d2.Id 
    AND ma3.Id = d3.Id AND d1.Year = d2.Year AND d2.Year = d3.Year 
    AND makt.Maker = "toyota" AND makt.Id = mot.Maker AND mot.Model = mat.Model
    AND mat.Id = dt.Id AND dt.Year = d1.Year
GROUP BY dt.Year
ORDER BY d1.Year;


USE `CARS`;
-- Query 4
-- For each year from 1975 to 1979 (inclusive) report the number of Japanese 
cars with less than 150 horsepowers.  Sort output in chronological order.

SELECT Year, COUNT(*)
FROM carmakers, countries, makes, models, cardata
WHERE Country = countries.Id AND countries.Name = 'japan' 
    AND carmakers.Id = models.Maker 
    AND models.Model = makes.Model AND makes.Id = cardata.Id
    AND Year >= 1975 AND Year <= 1979 AND Horsepower < 150
GROUP BY Year
ORDER BY Year;


