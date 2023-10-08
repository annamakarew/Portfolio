-- Lab 4 MARATHON
-- amakarew
-- May 18, 2023

USE `MARATHON`;
-- Query 1
-- Report the time, pace, name,  and the overall place of  all runners from LITTLE FERRY, NJ, sort output in order of finish.

SELECT Place, RunTime, FirstName, LastName, TIME_FORMAT(Pace, '%i:%s')
FROM marathon
WHERE Town='LITTLE FERRY' AND State='NJ'
ORDER BY Place;


USE `MARATHON`;
-- Query 2
-- Report names (first, last),  times, overall places as well as places in their sex-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.

SELECT FirstName, LastName, Place, RunTime, GroupPlace
FROM marathon
WHERE Sex='F' AND Town='Qunicy' AND State='MA'
ORDER BY Place;


USE `MARATHON`;
-- Query 3
-- Find the results for all 27-year old female runners from Rhode Island
(RI). For each runner, output name (first, last), town, their place in the race and their place in their sex-age category, and the running time. Sort by time.

SELECT FirstName, LastName, Town, Place, GroupPlace, RunTime
FROM marathon
WHERE Sex='F' AND Age=27 AND State='RI'
ORDER BY RunTime;


USE `MARATHON`;
-- Query 4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.  (Note: without restrictions on what SQL functionality
to use, this query can be implemented in a number of valid ways. Your task
is to implement it using the SQL SELECT features allowed in this lab).


SELECT DISTINCT m1.BibNumber
FROM marathon as m1, marathon as m2
WHERE m1.BibNumber=m2.BibNumber AND m1.FirstName!=m2.FirstName
ORDER BY m1.BibNumber;


USE `MARATHON`;
-- Query 5
-- List all runners who took first place and second place in their respective
age/sex groups. For each age group,  output name (first, last) and age
for both the winner and the runner up (in a single row).
Order the output by gender, then by age group.
SELECT m1.Sex, m1.AgeGroup, m1.FirstName, m1.LastName, m1.Age, m2.FirstName,
    m2.LastName, m2.Age
FROM marathon AS m1, marathon as m2
WHERE m1.Sex=m2.Sex AND m1.AgeGroup=m2.AgeGroup AND m1.GroupPlace=1
    AND m2.GroupPlace=2
ORDER BY m1.Sex, m1.AgeGroup;


