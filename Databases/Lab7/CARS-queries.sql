-- Lab 7 - CARS
-- amakarew
-- Jun 11, 2023

USE `CARS`;
-- Query 1
-- Report  the most powerful (in terms of horsepowers) vehicle. Report
the name of the  vehicle,  the year it was produced,  and the horsepowers.



SELECT t.make, t.year, t.horsepower
FROM (
    SELECT a.make, b.horsepower, b.year
    FROM makes a, cardata b
    WHERE b.Id = a.Id) t,
    (SELECT MAX(horsepower) AS max
    FROM (
        SELECT horsepower
        FROM makes, cardata
        WHERE cardata.Id = makes.Id) t1
    ) tt
WHERE t.horsepower = tt.max;


USE `CARS`;
-- Query 2
-- Among the vehicles with the best gas mileage, report the one
with the best acceleration. Report full name and the year of
production.


SELECT makes.make, cardata.Year
FROM cardata JOIN makes ON cardata.Id = makes.Id
WHERE cardata.MPG = (
    SELECT MAX(MPG)
    FROM cardata) AND cardata.Accelerate = (SELECT MIN(Accelerate) FROM cardata
        WHERE MPG = (SELECT MAX(MPG) FROM cardata));


USE `CARS`;
-- Query 3
--  For each country report the automaker with the largest number
of cars in the database. Report the name of the country,
the short name of the automaker. Output in alphabetical order by country.
(Note: we are looking for cars in the table where the car data is specified, not just for some models).
SELECT Country, Automaker
FROM (
    SELECT f.Name AS Country,
    (
        SELECT c1.Maker
        FROM cardata a1 JOIN makes b1 ON a1.Id = b1.Id
            JOIN models d1 ON b1.Model = d1.Model
            JOIN carmakers c1 ON d1.Maker = c1.Id
            JOIN countries f1 ON c1.Country = f1.Id
        WHERE f1.Id = f.Id
        GROUP BY c1.Maker
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS Automaker
    FROM countries f
) AS InnerQuery
WHERE Automaker IS NOT NULL
ORDER BY Country ASC;


USE `CARS`;
-- Query 4
-- For each year find the automakers whose models for that year
were (on average) the heaviest. Report the year, the automaker,
the number of  different vehicles the automaker produced that year and the average acceleration (not a typo).
Exclude any automakers that produced only one car in a particular year from
consideration for that year.
Present the output in chronological order.

WITH car_data AS (
    SELECT c.Year, m.Maker, COUNT(*) as num_models, AVG(c.Weight) as avg_weight,
        AVG(c.Accelerate) as avg_acceleration
    FROM cardata c JOIN makes mk ON c.Id = mk.Id 
        JOIN models ml ON mk.Model = ml.Model
        JOIN carmakers m ON ml.Maker = m.Id
    GROUP BY
        c.Year, m.Maker
    HAVING COUNT(*) > 1
)
SELECT cd.Year, cd.Maker, cd.num_models, cd.avg_acceleration
FROM car_data cd
JOIN (
    SELECT Year, MAX(avg_weight) AS max_weight
    FROM car_data
    GROUP BY Year
    ) max_cd ON cd.Year = max_cd.Year AND cd.avg_weight = max_cd.max_weight
    ORDER BY cd.Year;


USE `CARS`;
-- Query 5
-- Find the difference in gas milage between the most fuel-efficient
8-cylinder model and the least fuel-efficient 4-cylinder model. Report
just the number.


SELECT MAX(CASE WHEN a.Cylinders = 8 THEN a.MPG END) - 
    MIN(CASE WHEN a.Cylinders = 4 THEN a.MPG END) AS Difference
FROM cardata a
WHERE a.Cylinders IN (4,8) AND a.MPG IS NOT NULL;


USE `CARS`;
-- Query 6
-- For each year between 1972 and 1976 (inclusively) find if US automakers or all other automakers produced more different cars. Report, in chronological order either  'us' or 'rest of the world' for each year, depending on
whether the US automakers had more different cars produced, or fewer. Report 'tie' in case of a tie\footnote{If you discover that no ties exist in
the years considered, you are allowed not to include the logic for reporting the output 'tie' into your query. But if the ties do exist, this logic must be
there, and the output must be correct.}.

Note: you can use CASE WHEN statements for this query, or try to do this w/o the CASE WHEN.

SELECT cardata.Year,
    case
        when sum(case when countries.name = 'USA' then 1 else 0 end) > 
            sum(case when countries.name != 'USA' then 1 else 0 end) then 'us'
        when sum(case when countries.name = 'USA' then 1 else 0 end) <
            sum(case when countries.name != 'USA' then 1 else 0 end)
            then 'rest of the world'
    end as result
FROM cardata JOIN makes on cardata.id = makes.id 
    JOIN models on makes.model = models.model 
    JOIN carmakers on models.maker = carmakers.id
    JOIN countries on carmakers.country = countries.id
WHERE cardata.year between 1972 and 1976
GROUP BY cardata.year
ORDER BY cardata.year;


