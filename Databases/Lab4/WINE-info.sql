-- Lab 4 - WINE
-- amakarew
-- May 18, 2023

USE `WINE`;
-- Query 1
-- Find all 2008 Zinfandels produced in Napa Valley (Appellation). Report the name of the wine, the winery it is produced by, and the wine score, sort in descending order by the score.
SELECT Name, Winery, Score
FROM wine
WHERE Vintage=2008 AND Grape='Zinfandel' AND Appellation='Napa Valley'
ORDER BY Score DESC;


USE `WINE`;
-- Query 2
-- List all white grape varieties for which at least one wine
of the 2009 vintage is rated at 90 points or above in the database. 
Each grape variety needs to be reported
once. Sort the output in alphabetical order.
SELECT DISTINCT grapes.Grape
FROM grapes, wine
WHERE grapes.Color = 'White' AND grapes.Grape=wine.Grape AND wine.Vintage=2009
    AND wine.Score>=90
ORDER BY grapes.Grape;


USE `WINE`;
-- Query 3
-- List all Sonoma county appellations for which the database
contains at least one rating for a 'Grenache'.
For each appellation list its name and county. Sort output
in alphabetical order by county, then by appellation name. 
Report each appellation once.

SELECT DISTINCT a.Appellation, a.County
FROM appellations AS a, wine
WHERE a.County='Sonoma' AND a.Appellation=wine.Appellation AND 
    wine.Grape='Grenache'
ORDER BY a.County, a.Appellation;


USE `WINE`;
-- Query 4
--  List all vintage years in which at least one Zinfandel
from Sonoma County (any appellation) scored above  92. Each
year needs to be reported once. Sort in chronological order.

SELECT DISTINCT Vintage
FROM wine, appellations
WHERE wine.Grape='Zinfandel' AND wine.Appellation=appellations.Appellation
    AND appellations.County='Sonoma' AND wine.Score>92
ORDER BY Vintage;


USE `WINE`;
-- Query 5
-- A case of wine is 12 bottles. For each  Altamura (name of
the winery) wine  compute the total revenue assuming that all the wine
sold at the specified price. Report the name of the wine, its vintage
wine score and overall revenue. Sort in descending order by revenue.
Exclude NULL values.
SELECT Name, Vintage, Score, Price*12*Cases AS Revenue
FROM wine
WHERE Winery='Altamura'
ORDER BY Revenue DESC;


USE `WINE`;
-- Query 6
-- Compute the total price of a bottle of Kosta Browne's
'Koplen Vineyard}' 2008 'Pinot Noir', two bottles of
'Darioush''s 2007 'Darius II' 'Cabernet Sauvingnon',
and three bottles of Kistler}'s 'McCrea Vineyard' 2006
'Chardonnay'. Report just the one number.
SELECT w1.Price+(2*w2.Price)+(3*w3.Price)
FROM wine AS w1, wine AS w2, wine AS w3
WHERE w1.Winery='Kosta Browne' AND w1.Name='Koplen Vineyard' 
    AND w1.Vintage=2008 AND w1.Grape='Pinot Noir' AND w2.Winery='Darioush'
    AND w2.Vintage='2007' AND w2.Name='Darius II' 
    AND w2.Grape='Cabernet Sauvingnon' AND w3.Winery='Kistler'
    AND w3.Name='McCrea Vineyard' AND w3.Vintage=2006;


