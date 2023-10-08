-- Lab4 - STUDENTS
-- amakarew
-- May 17, 2023

USE `STUDENTS`;
-- Query 1
-- Find all students who study in classroom 112. For each student list
first and last name. Sort the output by the last name of the student in descending order.

SELECT FirstName, LastName FROM list WHERE (classroom=112) ORDER BY LastName
    DESC;


USE `STUDENTS`;
-- Query 2
-- For each classroom report the grade that is taught in it. Report just  the classroom number and the grade number. Sort output by grade in  ascending order.

SELECT DISTINCT classroom, grade FROM list ORDER BY grade, classroom;


USE `STUDENTS`;
-- Query 3
-- Find  find the teacher of JEFFRY FLACHS. Report the teacher's first and last name.
SELECT t.First, t.Last FROM teachers AS t, list AS list 
    WHERE list.FirstName='JEFFRY' and list.LastName='FLACHS' 
    and list.classroom=t.classroom;


USE `STUDENTS`;
-- Query 4
-- Assuming all classrooms in the school are organized in a long row with 101 on one end, 112 on the other end, and neighboring classrooms being different by 1 (for example, neighboring classes for 109 being 108 and 110), report the teachers who teach in the classrooms next door to LORIA ONDERSMA. Report the first and the last name of each teacher, sort output in ascending order by classroom number.

SELECT t1.First, t1.Last
    FROM teachers AS t1, teachers AS t2
    WHERE (t2.First='LORIA' AND t2.Last='ONDERSMA')
    AND (t1.classroom=t2.classroom+1 OR t1.classroom=t2.classroom-1)
    ORDER BY t1.classroom;


USE `STUDENTS`;
-- Query 5
-- Find all students who are in the same grade as LYNNETTE HOESCHEN but have a different teacher (i.e., study in a different classroom). Report results in ascending order by classroom, and students in each classroom in ascending order by their last name.

SELECT l1.FirstName, l1.LastName
    FROM list AS l1, list AS l2
    WHERE l1.grade = l2.grade AND l1.classroom!=l2.classroom
    AND l2.FirstName='LYNNETTE' AND l2.LastName='HOESCHEN'
    ORDER BY l1.classroom, l1.LastName;


