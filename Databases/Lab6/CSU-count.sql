-- Lab 6 - CSU
-- amakarew
-- Jun 1, 2023

USE `CSU`;
-- Query 1
--  For each campus that averaged more than $2300 in fees between 2000 and 2004 (inclusive),  report the average FTE undergraduate enrollment over those years. Sort output in descending order of average enrollment.

SELECT Campus, AVG(FTE)
FROM campuses JOIN degrees ON degrees.CampusId = Id 
    JOIN fees ON fees.CampusId = Id AND degrees.Year = fees.Year
    JOIN enrollments ON enrollments.CampusId = Id 
    AND enrollments.Year = fees.Year AND degrees.Year = enrollments.Year
WHERE degrees.Year >= 2000 AND degrees.Year <= 2004
GROUP BY Campus
HAVING SUM(fee) / COUNT(*) > 2300
ORDER BY AVG(FTE) DESC;


USE `CSU`;
-- Query 2
--  For each campus for which data exists for more than 60 years, report the average, the maximum and the minimum enrollment (for all years), and the standard deviation. Sort your output in descending order by average enrollment.



SELECT Campus, MIN(Enrolled), AVG(Enrolled), MAX(Enrolled), STD(Enrolled)
FROM campuses JOIN enrollments ON CampusId = Id
GROUP BY Campus
HAVING COUNT(enrollments.Year) > 60
ORDER BY AVG(Enrolled) DESC;


USE `CSU`;
-- Query 3
--  For each campus in LA and Orange counties
compute the overall revenue received from students starting the year 2001 (i.e., in the 21st century).
Use "warm body" enrollment numbers (not FTEs) for your computations\footnote{The number you 
compute technically is not quite the full revenue, but it's a good approximation.}. Sort output
in descending order by the revenue.

SELECT Campus, SUM(fee*Enrolled)
FROM campuses JOIN degrees ON degrees.CampusId = Id 
    JOIN fees ON fees.CampusId = Id AND degrees.Year = fees.Year
    JOIN enrollments ON enrollments.CampusId = Id 
    AND enrollments.Year = fees.Year AND degrees.Year = enrollments.Year
WHERE (County = 'Los Angeles' OR County = 'Orange') 
    AND degrees.year >= 2001
GROUP BY Campus
ORDER BY SUM(fee*Enrolled) DESC;


USE `CSU`;
-- Query 4
-- For each campus that had more than 20000 enrolled students in 2004
report the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name
of the campus. (This query should exclude campuses that had no graduate enrollment at all).

SELECT Campus, COUNT(Discipline)
FROM campuses JOIN enrollments ON enrollments.CampusId = Id
    JOIN discEnr ON discEnr.CampusId = Id
WHERE enrollments.year = 2004 and Enrolled > 20000 AND Gr > 0
GROUP BY Campus
ORDER BY Campus;


