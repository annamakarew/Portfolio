-- Lab 4 - CARS
-- amakarew
-- May 17, 2023

USE `CARS`;
-- Query 1
--  Find all pontiacs in the database (pontiac here is a model of the car) released before 1977. For each, report  the name of the car and the year. Sort output by year.

SELECT makes.Make, cardata.Year
FROM makes, cardata
WHERE makes.Model='pontiac' AND cardata.Id=makes.Id AND cardata.Year < 1977
ORDER BY cardata.Year;


USE `CARS`;
-- Query 2
-- Find all cars produced by  Chrysler (the company) in 1976 and 1977.
Report the
name of the car and the year it was produced, sort output in
ascending order by the year, and in alphabetical order within a single year.
SELECT DISTINCT makes.Make, cardata.Year
FROM makes, cardata, carmakers, models
WHERE carmakers.Maker='chrysler' AND models.Maker=carmakers.Id
    AND makes.Model=models.Model AND makes.Id=cardata.Id 
    AND (cardata.Year=1976 OR cardata.Year=1977)
ORDER BY cardata.Year, makes.Make;


USE `CARS`;
-- Query 3
-- Report all French and Swedish automakers. Output the full name of the automaker and
the country of origin sorted alphabetically by the country, and then the full name of the automaker.

SELECT carmakers.FullName, countries.Name
FROM carmakers, countries
WHERE (countries.Name = 'france' or countries.Name = 'sweden') 
    AND countries.Id = carmakers.Country
ORDER BY countries.Name, carmakers.FullName;


USE `CARS`;
-- Query 4
-- Find all non-four cylinder cars produced in 1979 that have
a better fuel economy better than 20 MPG and that accelerate to 60 mph faster
than in 18 seconds. Report the name of the car
and the name of the automaker.


SELECT carmakers.Maker, makes.Make
FROM cardata, makes, models, carmakers
WHERE Cylinders!=4 AND MPG>20 AND Accelerate<18 AND cardata.Year=1979
    AND cardata.Id=makes.Id AND makes.Model=models.Model 
    AND models.Maker=carmakers.Id;


USE `CARS`;
-- Query 5
-- Find all American car makers which produced at least one 
light (weight less than 2000lbs) car between 1977 and 1979
(inclusively). Output the full name of the company and its
home country sorted alphabetically by the company name. Each company should be reported just once.
SELECT DISTINCT carmakers.FullName, countries.Name
FROM carmakers, countries, cardata, makes, models
WHERE cardata.Weight<2000 AND cardata.Year>=1977 AND cardata.Year<=1979
    AND cardata.Id=makes.Id AND makes.Model=models.Model 
    AND models.Maker=carmakers.Id AND carmakers.Country = countries.Id
    AND countries.Name='usa'
ORDER BY carmakers.FullName;


USE `CARS`;
-- Query 6
-- For each Volvo ('volvo') released after 1971, compute the ratio between
the weight of the car and its number of horsepowers. Report the full name
of the car, the year it was produced and the ratio sorted in descending
order by the ratio.
SELECT makes.Make, cardata.Year, cardata.Weight/cardata.Horsepower as ratio
FROM makes, cardata
WHERE cardata.Year>1971 AND cardata.Id=makes.Id AND makes.Model='volvo'
ORDER BY ratio DESC;


