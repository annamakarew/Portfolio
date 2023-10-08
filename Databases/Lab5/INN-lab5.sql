-- Lab 5 - INN
-- amakarew
-- May 25, 2023

USE `INN`;
-- Query 1
-- Find all rooms that were occupied on all three of the following 
dates:  February 16, 2010, July 12, 2010 and  October 20, 2010. Report just the full name of the room and the room code. Sort output in alphabetical order by room name.

SELECT DISTINCT RoomCode, RoomName
FROM rooms, reservations as r1, reservations as r2, reservations as r3
WHERE r1.CheckIn <= '2010-02-16' AND r1.Checkout >='2010-02-16'
    AND r2.CheckIn <= '2010-07-12' AND r2.Checkout >= '2010-07-12'
    AND r3.CheckIn <= '2010-10-20' AND r3.Checkout >= '2010-10-20'
    AND r1.Room = RoomCode AND r2.Room = RoomCode AND r3.Room = RoomCode
ORDER BY RoomName;


USE `INN`;
-- Query 2
-- Find the total number of seven-night stays in rooms with modern decor.

SELECT COUNT(*)
FROM reservations, rooms
WHERE TIMESTAMPDIFF(DAY, CheckIn, Checkout) = 7 AND decor = 'modern' 
    AND Room = RoomCode;


USE `INN`;
-- Query 3
-- Find the number of  August reservations (both check-in and checkout dates are in August) where two adults are staying with  two children. 


SELECT COUNT(*)
FROM reservations
WHERE MONTH(CheckIn) = 8 AND MONTH(Checkout) = 8 AND Adults = 2 AND Kids = 2;


USE `INN`;
-- Query 4
-- Find the average number of nights of stay in the 'Interim but salutary' room for all reservations that commenced May 1, 2010 or later and ended before August 31, 2010.

SELECT AVG(DATEDIFF(Checkout, CheckIn))
FROM reservations, rooms
WHERE RoomName = 'Interim but salutary' AND RoomCode = Room 
    AND CheckIn >= '2010-05-01' AND Checkout < '2010-08-31';


USE `INN`;
-- Query 5
-- Find how many different durations of stay for trips that commenced and ended in July of 2010 were in 'Interim but salutary' room.


SELECT COUNT(*)
FROM reservations, rooms
WHERE RoomName = 'Interim but salutary' AND RoomCode = Room 
    AND CheckIn >= '2010-07-01' AND Checkout <= '2010-07-31';


