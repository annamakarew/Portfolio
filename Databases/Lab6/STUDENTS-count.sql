-- Lab 6 - STUDENTS
-- amakarew
-- May 31, 2023

USE `STUDENTS`;
-- Query 1
--  Report the names of teachers who have two or three
students in their classes. Sort output in alphabetical order
by teacher's last name.

SELECT Last, First
FROM teachers JOIN list ON teachers.classroom = list.classroom
GROUP BY First, Last
HAVING COUNT(*) = 2 or COUNT(*) = 3
ORDER BY Last;


USE `STUDENTS`;
-- Query 2
-- For each grade, report, in a single row, all classrooms this grade is taught in
(classrooms should be in ascending order).
SELECT Grade, group_concat(DISTINCT classroom SEPARATOR ', ') AS AllClassrooms
FROM list
GROUP BY Grade
ORDER BY Grade;


USE `STUDENTS`;
-- Query 3
-- For each kindergarden classroom, report the total number of students. Sort
output in the descending order by the number of students.

SELECT classroom, COUNT(classroom)
FROM list
WHERE grade = 0
GROUP BY classroom
ORDER BY COUNT(classroom) DESC;


USE `STUDENTS`;
-- Query 4
-- For each first grade classroom, report the student (last name) who is the
first (alphabetically) on the class roster. Sort output by classroom.

SELECT classroom, MIN(lastname)
FROM list
WHERE grade = 1
GROUP BY classroom
ORDER BY classroom;


