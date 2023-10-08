-- Lab 4 - CSU
-- amakarew
-- May 17, 2023

USE `CSU`;
-- Query 1
-- Report all campuses (full name of campus, year of foundation) that started their work before 1920, sort output in ascending order by the year of foundation.

SELECT Campus, Year
FROM campuses
WHERE Year<1920
ORDER BY Year;


USE `CSU`;
-- Query 2
-- For each year between 2000 and 2004 (inclusive) report the number of students who graduated from San Diego State University
Output the year and the number of degrees granted. Sort output by year.

SELECT degrees.year, degrees.degrees
FROM degrees, campuses
WHERE campuses.Campus='San Diego State University' 
    AND campuses.Id = degrees.CampusId AND degrees.year>=2000 
    AND degrees.year<=2004
ORDER BY Year;


USE `CSU`;
-- Query 3
-- Report undergraduate and graduate
enrollments (as two numbers) in  'Mathematics', 'Engineering' and
'Computer and Info. Sciences'
disciplines for both Polytechnic universities of the CSU system
in 2004 as well as for the newest Polytechnic university, which in our
database is still known as 'Humboldt State University'. 
Output the name of the campus, the discipline and the number of graduate 
and the number of undergraduate students enrolled. Sort output by campus name, and by  discipline for each campus.
SELECT c.Campus, d.Name, e.Gr, e.Ug
FROM discEnr AS e, disciplines AS d, campuses AS c
WHERE e.Year=2004 AND (d.Name='Mathematics' OR d.Name='Engineering'
    OR d.Name='Computer and Info. Sciences') 
    AND d.Id=e.Discipline AND e.CampusId=c.Id
    AND (c.Campus='California Polytechnic State University-San Luis Obispo'
    OR c.Campus='California State Polytechnic University-Pomona'
    OR c.Campus='Humboldt State University')
ORDER BY c.Campus, d.Name;


USE `CSU`;
-- Query 4
-- Find all situations when more than 25% of students graduated from a CSU campus in a given year (for enrollments, use the FTE number) in 1990s. Report the name of the campus, the year when this happened, and the percentage of the campus full-time-equivalent student body that graduated that year. Sort output in chronological order, and in alphabetical order by campus name within a single year.
SELECT campuses.Campus, degrees.year, 
    (degrees.degrees/enrollments.FTE) AS RATIO
FROM enrollments, campuses, degrees
WHERE campuses.Id=enrollments.CampusId AND campuses.Id=degrees.CampusId
    AND degrees.year=enrollments.Year 
    AND degrees.degrees/enrollments.FTE > 0.25 AND degrees.year>=1990
    AND degrees.year<=1999
ORDER BY degrees.year, campuses.Campus;


USE `CSU`;
-- Query 5
-- Find all disciplines and campuses where graduate enrollment
in 2004 was at least four times higher than undergraduate enrollment and (where both graduate and graduate enrollments were non-zero). Report campus names, discipline names, and the undergraduate and graduate enrollments. Sort output by campus name, then by discipline name in alphabetical order.
SELECT c.Campus, d.Name, e.Ug, e.Gr
FROM discEnr AS e, disciplines AS d, campuses AS c
WHERE e.Year=2004
    AND d.Id=e.Discipline AND e.CampusId=c.Id
    AND e.Ug!=0 AND e.Gr!=0 and e.Gr >= 4*e.Ug
ORDER BY c.Campus, d.Name;


USE `CSU`;
-- Query 6
--  Report the total amount of money collected from student
fees (use the full-time equivalent enrollment for computations) at
San Diego State University for each year between 2000 and
2004 inclusively, and the amount of money collected from student
fees per one full-time equivalent faculty. Output the year,
the two computed numbers sorted chronologically by year.

SELECT fees.Year, fees.fee*enrollments.FTE AS 'COLLECTED', 
    fees.fee*enrollments.FTE/faculty.FTE AS 'PER FACULTY'
FROM fees, enrollments, faculty, campuses
WHERE campuses.Campus='San Diego State University' AND fees.Year>=2002
    AND fees.Year<=2004 AND campuses.Id=faculty.CampusId
    AND campuses.Id=fees.CampusId AND campuses.Id=enrollments.CampusId
    AND fees.Year = enrollments.Year AND fees.Year=faculty.Year
ORDER BY Year;


USE `CSU`;
-- Query 7
-- Find all campuses where enrollment in 2003 (use the FTE numbers),
was higher than the 2003 enrollment in 'San Jose State University'. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio.  Sort output in ascending order by student-to-faculty ratio.
SELECT c1.Campus, e1.FTE, faculty.FTE, 
    e1.FTE/faculty.FTE AS ratio
FROM campuses AS c1, campuses AS c2, enrollments as e1, enrollments as e2,
    faculty
WHERE c2.Campus='San Jose State University' AND c2.Id=e2.CampusId
    AND e1.FTE>e2.FTE AND e2.Year=2003 AND e1.Year=2003 AND c1.Id=e1.CampusId
    AND c1.Id=faculty.CampusId AND e1.Year=faculty.Year
ORDER BY ratio;


