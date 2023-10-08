-- Lab5 - CARS
-- amakarew
-- May 25, 2023

USE `CARS`;
-- Query 1
-- Find all cars made after 1980 with gas mileage better than the 1982 honda civic. Report full name of the car, year it was made and the name of the manufacturer. Sort output in descending order by gas mileage.

SELECT m2.Make, c2.Year, carmakers.Maker
FROM cardata as c1, cardata as c2, carmakers, models, makes as m1, makes as m2
WHERE c2.Year > 1980 AND m1.Make = 'honda civic' AND m1.Id = c1.Id
    AND c1.Year = 1982 AND c2.MPG > c1.MPG AND c2.Id = m2.Id 
    AND m2.model = models.Model AND models.Maker = carmakers.Id
ORDER BY c2.MPG DESC;


USE `CARS`;
-- Query 2
--  Find the average, maximum and minimum horsepower for 4-cylinder
vehicles manufactured by French automakers between 1971 and 1976 inclusively.

SELECT AVG(Horsepower), MAX(Horsepower), MIN(Horsepower)
FROM cardata, makes, models, carmakers, countries
WHERE Cylinders = 4 AND Year >= 1971 AND Year <= 1976 AND cardata.Id = makes.Id
    AND makes.model = models.Model AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id and countries.Name = 'france';


USE `CARS`;
-- Query 3
-- Find how many cars produced in 1971 had better acceleration than a 1972
volvo 145e (sw). Report just the number.

SELECT COUNT(*)
FROM cardata as c1, cardata as c2, makes
WHERE c1.Year = 1971 AND c2.Year = 1972 AND c1.Accelerate < c2.Accelerate
    AND c2.Id = makes.Id AND makes.Make  = 'volvo 145e (sw)';


USE `CARS`;
-- Query 4
--  Find how many different car manufacturers produced a vehicle heavier
than 5000 lbs.

SELECT COUNT(carmakers.Maker)
FROM cardata, makes, models, carmakers
WHERE Weight > 5000 AND cardata.Id = makes.Id AND makes.Model = models.Model
    AND models.Maker = carmakers.Id;


