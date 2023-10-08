-- Lab 7 - WINE
-- amakarew
-- Jun 11, 2023

USE `WINE`;
-- Query 1
-- Find the most popular red grape (i.e., the grape that is used to make the largest number of red wines) in San Luis Obispo County. Report the name of the grape.

SELECT g.Grape
FROM grapes g JOIN wine w ON g.Grape = w.Grape 
    JOIN appellations a ON w.Appellation = a.Appellation
WHERE a.County = 'San Luis Obispo'
GROUP BY g.Grape
HAVING COUNT(w.Grape) = (
    SELECT COUNT(wine.Grape)
    FROM wine JOIN appellations ON wine.Appellation = appellations.Appellation
    WHERE appellations.County = 'San Luis Obispo'
    GROUP BY wine.Grape
    ORDER BY COUNT(wine.Grape) DESC
    LIMIT 1
    );


USE `WINE`;
-- Query 2
-- Report the grape with the largest number of high-ranked wines (wines
ranked 93 or higher).

SELECT g.Grape
FROM grapes g JOIN wine w ON g.Grape = w.Grape
WHERE w.Score >= 93
GROUP BY g.Grape
ORDER BY COUNT(w.WineId) DESC
LIMIT 1;


USE `WINE`;
-- Query 3
-- Find the wine with the 37th largest number of cases produced. Report the winery, the wine (full name) and the number of cases produced. (If there is a tie for the  37th place, return all wines that are tied for it).


Note: DO NOT USE "LIMIT".
-- No attempt


USE `WINE`;
-- Query 4
--  Find if there are any 2008 Zinfandels with a score equal or higher than  than all 2007 Grenaches. Report winery, wine name, appellation, score and price.

-- No attempt


USE `WINE`;
-- Query 5
-- Two California AVAs, Carneros and Dry Creek Valley have a bragging rights contest every year: the AVA that produces the highest-ranked wine among all the wines produced in both AVAs wins. Based on the data in the database, output (as a single tuple) the number of vintage years each AVA has won between 2005 and 2009 (you want the output to look like a score of
a game between the two AVAs. Only the vintage years where one AVA won count - vintages when both AVAs had the same highest score should not be counted).

-- No attempt


USE `WINE`;
-- Query 6
-- For each winemaking area in California (exclude 'N/A' and 'Calfiornia') report how many wineries produce a wine made
with Grenache grapes.  Report the area (in alphabetical order) and the number of wineries. Note: you must have a result for each area.
-- No attempt


