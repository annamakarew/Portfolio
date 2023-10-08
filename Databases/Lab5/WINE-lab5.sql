-- Lab 5 - WINE
-- amakarew
-- May 25, 2023

USE `WINE`;
-- Query 1
-- List all 2006 vintage wines from Napa (any appellation within
the county) whose total revenue exceeds that of the 2006  'Appelation
Series' (There is a typo there. Let it be for now.)  Paso Robles Zinfandel from 'Rosenblum' winery. For each wine report grape, winery and name, score and revenue.  Sort by revenue in descending order



SELECT w1.Grape, w1.Winery, w1.Name, w1.Score, w1.Price*12*w1.Cases AS rev
FROM wine as w1, wine as w2, appellations
WHERE w1.Vintage = 2006 AND w1.Appellation = appellations.Appellation
    AND County = 'Napa' AND w1.Price*12*w1.Cases > w2.Price*12*w2.Cases
    AND w2.Vintage = 2006 AND w2.Name = 'Appelation Series' 
    AND w2.Winery = 'Rosenblum' AND w2.Grape ='Zinfandel'
ORDER BY rev DESC;


USE `WINE`;
-- Query 2
-- Find the average score of a Sonoma Valley Zinfandel.



SELECT AVG(Score)
FROM wine
WHERE Appellation = 'Sonoma Valley' AND Grape = 'Zinfandel';


USE `WINE`;
-- Query 3
-- Find the total revenue from all 2009 Sauvignon Blanc wines with a score of 89 or higher.
SELECT SUM(Price*12*Cases)
FROM wine
WHERE Vintage = 2009 AND Grape = 'Sauvignon Blanc' AND Score >= 89;


USE `WINE`;
-- Query 4
-- Find the average number of cases of a Zinfandel produced from  grapes sourced from the Central Coast.

SELECT AVG(Cases)
FROM appellations, wine
WHERE Area = 'Central Coast' AND appellations.Appellation = wine.Appellation
    AND Grape = 'Zinfandel';


USE `WINE`;
-- Query 5
-- Report the overall number of different red wines produced in
Russian River Valley during the year when this AVA had a wine with a score of 98.


SELECT COUNT(*)
FROM wine as w1, wine as w2, grapes
WHERE Color = 'Red' and grapes.Grape = w1.Grape
    AND w1.Appellation = 'Russian River Valley' 
    AND w2.Appellation = 'Russian River Valley' AND w2.Score = 98
    AND w2.Vintage = w1.Vintage;


