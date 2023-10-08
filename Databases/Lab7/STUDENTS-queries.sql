-- Lab 7 - STUDENTS
-- amakarew
-- Jun 10, 2023

USE `STUDENTS`;
-- Query 1
--  Find the teacher(s) who teach(es) the  smallest number of students. Report the
name of the teacher(s) (first and last) and the number of students in their class.

SELECT t.Last, t.First, COUNT(DISTINCT s.LastName) AS 'num students'
FROM teachers t JOIN list s ON s.classroom = t.classroom
GROUP BY s.classroom
ORDER BY COUNT(DISTINCT s.LastName)
LIMIT 1;


USE `STUDENTS`;
-- Query 2
-- Find the grade/grades with the largest average number of students in the class. Report
the grade(s), and the average number of students in it/them.


SELECT grade, COUNT(LastName)/COUNT(DISTINCT Classroom)
FROM list
GROUP BY grade
HAVING COUNT(LastName) > (
    SELECT AVG(ClassCounts)
    FROM (
        SELECT Classroom, COUNT(LastName) AS ClassCounts
        FROM list
        GROUP BY Classroom
        ) ClassCountTable
    )
ORDER BY grade DESC
LIMIT 1;


USE `STUDENTS`;
-- Query 3
-- Find the grade/grades in which the student(s) with the longest name(s) (fist+last) studies/study.
Report the grade(s) and the name(s) of the student(s). (Use built-in MySQL functions LENGTH()  and CONCAT() to get there).

SELECT grade, FirstName, LastName
FROM list
ORDER BY LENGTH(CONCAT(FirstName, LastName)) DESC
LIMIT 1;


USE `STUDENTS`;
-- Query 4
--  Find all pairs of classrooms with the same number of students in them. Report each pair only once. Report both classrooms and the number of students. Sort output in ascending order by the number of students in the classroom.

SELECT c1.Classroom, c2.Classroom, c2.Students
FROM (
    SELECT Classroom, COUNT(LastName) AS Students
    FROM list
    GROUP BY Classroom
    ) c1,
    (
    SELECT Classroom, COUNT(LastName) AS Students
    FROM list
    GROUP BY Classroom
    ) c2
WHERE c1.Classroom != c2.Classroom AND c1.Students = c2.Students
    AND c1.Classroom < c2.Classroom
ORDER BY c1.Students;


USE `STUDENTS`;
-- Query 5
-- For each grade with more than one classroom, report the last name of the teacher who teachers the classroom with the largest number of students in the grade. Output results in ascending order by the grade.

SELECT *
FROM (
SELECT l1.grade, teachers.last
FROM list, teachers, (
    SELECT grade
    FROM list
    GROUP BY grade
    HAVING COUNT(DISTINCT CLASSROOM) > 1
    ) l1
WHERE l1.grade = list.grade AND list.Classroom = teachers.Classroom
GROUP BY l1.grade, teachers.last
ORDER BY COUNT(DISTINCT LastName) DESC
LIMIT 3) l2
ORDER BY grade;


