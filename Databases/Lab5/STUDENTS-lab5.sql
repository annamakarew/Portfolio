-- Lab 5 - STUDENTS
-- amakarew
-- May 23, 2023

USE `STUDENTS`;
-- Query 1
-- Find all pairs of students with the same first name. Report each pair of students
exactly once. Report first and last names of each of the two students, and their grades.


SELECT l1.FirstName, l1.LastName, l1.grade, l2.FirstName, l2.LastName, l2.grade
FROM list as l1, list as l2
WHERE l1.FirstName = l2.FirstName AND l1.LastName != l2.LastName AND 
    l1.LastName < l2.LastName;


USE `STUDENTS`;
-- Query 2
--  Find all fourth-grade students who are NOT taught by GORDON KAWA. Report
their first and last names in alphabetical order by last name.


SELECT FirstName, LastName
FROM list, teachers
WHERE First='GORDON' AND Last ='KAWA' AND teachers.classroom != list.classroom
    AND list.grade=4
ORDER BY LastName;


USE `STUDENTS`;
-- Query 3
-- Report the total number of  first graders and second graders in the school.
SELECT COUNT(*)
FROM list
WHERE grade=1 OR grade=2;


USE `STUDENTS`;
-- Query 4
--  Find the number of classmates of ELTON FULVIO (excluding Elton himself).
SELECT COUNT(l2.FirstName)
FROM list as l1, list as l2
WHERE l1.FirstName = 'ELTON' AND l1.LastName = 'FULVIO' 
    AND l1.classroom = l2.classroom AND l1.FirstName != l2.FirstName;


