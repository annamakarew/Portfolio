-- Lab 5 - CSU
-- amakarew
-- May 25, 2023

USE `CSU`;
-- Query 1
-- Report the average  of degrees granted  by California Polytechnic State University-San Luis Obispo in the period between 1995 and 2000 (inclusively).

SELECT AVG(degrees)
FROM degrees, campuses
WHERE degrees.year >= 1995 AND degrees.year <= 2000 AND CampusId = Id
    AND Campus = 'California Polytechnic State University-San Luis Obispo';


USE `CSU`;
-- Query 2
-- Find the largest, the smallest and the average fee on a CSU campus in  2002.


SELECT MIN(fee) AS SMALLEST, AVG(fee) AS AVERAGE, MAX(fee) AS LARGEST
FROM fees
WHERE Year = 2002;


USE `CSU`;
-- Query 3
-- Report the average student to faculty (use student FTE to faculty FTE ratio) ratio in 2004 among the campuses where 2004 enrollment (FTE numbers) was greater than 15000.

SELECT AVG(enrollments.FTE/faculty.FTE)
FROM faculty, enrollments
WHERE faculty.Year=2004 AND enrollments.Year=2004 AND enrollments.FTE > 15000
    AND enrollments.CampusId = faculty.CampusId;


USE `CSU`;
-- Query 4
--  Report all years in which either there were more than 17000 students (NOT FTEs) on California Polytechnic State University-San Luis Obispo campus, or California Polytechnic State University-San Luis Obispo graduated (gave degrees) to more than 3500 students. Report years in chronological order, with each year reported once.


SELECT enrollments.Year
FROM enrollments, campuses
WHERE (Enrolled > 17000 AND CampusId = Id 
    AND Campus = 'California Polytechnic State University-San Luis Obispo')
UNION
SELECT degrees.Year
FROM degrees, campuses
WHERE degrees > 3500 AND CampusId = Id
    AND Campus = 'California Polytechnic State University-San Luis Obispo'
ORDER BY Year;


