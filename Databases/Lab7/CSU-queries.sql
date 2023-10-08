-- Lab 7 - CSU
-- amakarew
-- Jun 11, 2023

USE `CSU`;
-- Query 1
-- Find the campus that granted the largest number of degrees from 1990 to 2004. Report full name of the campus, the county it is located in, and the total number of degrees granted.
SELECT t1.campus, t1.county, SUM(t1.degrees) AS total_degrees
FROM (SELECT a.campus, a.county, b.degrees
    FROM campuses a, degrees b
    WHERE a.id = b.campusid) t1,
    (SELECT b.year, MAX(b.degrees) AS max
    FROM campuses a, degrees b
    WHERE a.id = b.campusid AND b.year BETWEEN 1990 AND 2004
    GROUP BY b.year) t2
WHERE t1.degrees = t2.max
GROUP BY t1.campus, t1.county;


USE `CSU`;
-- Query 2
-- Find the ratio between the largest and the smallest number of degrees granted by a CSU campus over the period of 1990 through 2004 (inclusive). Report just the ratio.
SELECT (
    SELECT MAX(total_degrees) FROM (
        SELECT SUM(degrees) AS total_degrees
        FROM campuses a JOIN degrees b on a.id = b.campusid
        WHERE b.year BETWEEN 1990 AND 2004
        GROUP BY a.id
    ) AS max_degrees) /
    (SELECT MIN(total_degrees) FROM (
        SELECT SUM(degrees) AS total_degrees
        FROM campuses a JOIN degrees b ON a.id = b.campusid
        WHERE b.year BETWEEN 1990 AND 2004
        GROUP BY a.id
    ) AS min_degrees) AS ratio;


USE `CSU`;
-- Query 3
-- For each university report the year it had the best (lowest) student-to-faculty ratio (use FTE values for both). Sort in ascending order by the best ratio. Report the full name of the university, the year, and the ratio.
WITH cte AS (
    SELECT c.Campus, e.Year, e.FTE / f.FTE AS Ratio
    FROM enrollments e JOIN faculty f ON e.CampusId = f.CampusId 
        AND e.Year = f.Year JOIN campuses c ON e.campusId = c.Id
),
cte2 AS (
    SELECT Campus, MIN(Ratio) AS BestRatio
    FROM cte
    GROUP BY Campus
)
SELECT cte.Campus, cte.Year, cte.Ratio AS BestRatio
FROM cte JOIN cte2 ON cte.Campus = cte2.Campus AND cte.Ratio = cte2.BestRatio
ORDER BY BestRatio ASC;


USE `CSU`;
-- Query 4
-- Find the year when the largest number of universities had their best student-to-faculty ratio. Report the year, and the percentage of all CSU campuses that 
had the best student-to-faculty ratio that year. (DO NOT hardcode the number of campuses into the query).
WITH cte AS (
    SELECT c.Campus, e.Year, e.FTE / f.FTE AS Ratio
    FROM enrollments e JOIN faculty f ON e.CampusId = f.CampusId 
        AND e.Year = f.Year JOIN campuses c ON e.CampusId = c.Id
),
cte2 AS (
    SELECT Campus, MIN(Ratio) AS BestRatio
    FROM cte
    GROUP BY Campus
),
cte3 AS (
    SELECT cte.Year, COUNT(*) AS Count
    FROM cte JOIN cte2 ON cte.Campus = cte2.Campus 
        AND cte.Ratio = cte2.BestRatio
    GROUP BY Year
),
cte4 AS (
    SELECT Year, MAX(Count) AS MaxCount
    FROM cte3
    GROUP BY Year
),
cte5 AS (
    SELECT COUNT(*) AS TotalCampuses
    FROM campuses
)
SELECT cte4.Year, (cte4.MaxCount / cte5.TotalCampuses) * 100 AS Percentage
FROM cte4, cte5
WHERE cte4.MaxCount = (SELECT MAX(MaxCount) FROM cte4);


USE `CSU`;
-- Query 5
-- For each campus that did not have any Engineering programs (graduate or undergraduate) in 2004, report average faculty FTE for the 2002 -- 2004 (inclusive) period. Report full campus name and the average faculty FTE, sort output in descending order by the average faculty FTE.
SELECT c.Campus, AVG(f.FTE) AS avg_faculty_fte
FROM faculty f JOIN campuses c ON f.CampusId = c.Id
WHERE f.Year BETWEEN 2002 AND 2004 AND c.Id NOT IN (
    SELECT DISTINCT CampusId
    FROM discEnr de
    JOIN disciplines d ON de.Discipline = d.Id
    WHERE d.Name = 'Engineering' AND de.Year = 2004
)
GROUP BY c.Campus
ORDER BY avg_faculty_fte DESC;


USE `CSU`;
-- Query 6
-- For each campus report whether it existed in 1955. 
Output name of the campus and "existed" or "did not exist". Sort output
in alphabetical order by campus.
SELECT Campus,
    CASE
        WHEN Year <= 1955 THEN 'existed'
        ELSE  'did not exist'
    END AS status
FROM campuses
ORDER BY Campus;


