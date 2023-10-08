-- Lab 6 - WINE
-- amakarew
-- Jun 2, 2023

USE `WINE`;
-- Query 1
-- For each wine score value above 88, report average price, the cheapest price
and the most expensive price for a bottle of wine 
with that score (for all vintage years combined), the total number of wines with
that score and the total number of cases produced. Sort by the wine score.


SELECT Score, AVG(Price), MIN(Price), MAX(Price), COUNT(*), SUM(Cases)
FROM wine w
WHERE Score > 88
GROUP BY Score
ORDER BY Score;


USE `WINE`;
-- Query 2
-- For each red grape varietal for which there are more than 10 wines in the database, report the highest price of a case of wine. Report in descending order of the case price.
SELECT grapes.Grape, MAX(PRICE)*12 AS caseprice
FROM grapes JOIN wine ON grapes.Grape = wine.Grape
WHERE Color = 'Red'
GROUP BY grapes.Grape
HAVING COUNT(*) > 10
ORDER BY caseprice DESC;


USE `WINE`;
-- Query 3
-- Report the list of wineries that produced Zinfandel wines from Sonoma Valley grapes and the names of the Sonoma Valley Zinfandel wines they produce; use one row for each winery, report each unique name of wine exactly once, sort output in alphabetical order by winery name.

SELECT Winery, GROUP_CONCAT(DISTINCT Name SEPARATOR ", ")
FROM wine
WHERE Grape = 'Zinfandel' AND Appellation = 'Sonoma Valley'
GROUP BY Winery
ORDER BY Winery;


USE `WINE`;
-- Query 4
-- For each county in the database, report the score of the highest ranked
2009 red wine. Exclude wines that do not have a county of origin ('N/A').
Sort output in descending order by the best score.

SELECT County, MAX(Score)
FROM appellations JOIN wine ON appellations.Appellation = wine.Appellation
    JOIN grapes ON grapes.Grape = wine.Grape
WHERE Vintage = 2009 AND County != 'N/A' AND Color = 'Red'
GROUP BY County
ORDER BY MAX(Score) DESC;


