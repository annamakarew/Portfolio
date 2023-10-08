-- Lab 7 - INN
-- amakarew
-- Jun 11, 2023

USE `INN`;
-- Query 1
-- Find the most popular room in the hotel. The most popular room is
the room that had seen the largest number of reservations (Note: if there
is a tie for the most popular room status, report all such  rooms).
Report the full name of the room, the room code and the number of reservations.

SELECT r.RoomName, r.RoomCode, COUNT(*) AS NumberOfReservations
FROM rooms r JOIN reservations res ON r.RoomCode = res.Room
GROUP BY r.roomCode
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM reservations
    GROUP BY Room
    ORDER BY COUNT(*) DESC
    LIMIT 1);


USE `INN`;
-- Query 2
-- Find the room (excluding 'Stay all year') that has been occupied the largest number of days based on the reservations
in the database. No need to limit the number of occupied days to 2010. 
Report the room name, room code and the number of days it was occupied.

SELECT r.RoomName, r.RoomCode, SUM(DATEDIFF(res.Checkout, res.CheckIn))
    AS TotalOccupiedDays
FROM rooms r JOIN reservations res ON r.RoomCode = res.Room
WHERE r.RoomName != 'Stay all year'
GROUP BY r.RoomCode
ORDER BY TotalOccupiedDays DESC
LIMIT 1;


USE `INN`;
-- Query 3
--  For each room, report the most expensive reservation. Report the full room
name, dates of stay, last name of the person who made the reservation, daily rate and the total amount paid. Sort the output in descending order by total amount paid.

SELECT r.RoomName, res.CheckIn, res.Checkout, res.LastName, 
    res.Rate as DailyRate, res.total_amount as TotalPaid
FROM (
    SELECT Room, CheckIn, Checkout, LastName, Rate, 
        DATEDIFF(Checkout, CheckIn) * Rate as total_amount
    FROM reservations
) as res
JOIN rooms r ON r.RoomCode = res.Room
WHERE (res.Room, res.total_amount) IN
(SELECT Room, MAX(DATEDIFF(Checkout, CheckIn) * Rate)
FROM reservations
GROUP BY Room
)
ORDER BY TotalPaid DESC;


USE `INN`;
-- Query 4
-- Find the best month (i.e., month with the highest total revenue). Report
the month, the total number of reservations  and the revenue. For the purposes of the query, count the entire revenue of a stay that commenced in one month and ended in another towards the earlier month. (e.g., a September 29 - October 3 stay is counted as September stay for the purpose of revenue computation).

SELECT DATE_FORMAT(STR_TO_DATE(BestMonth, '%m'), '%M') as Month, Revenue,
    TotalReservations
FROM (
    SELECT MONTH(re.CheckIn) as BestMonth,
        SUM(DATEDIFF(re.Checkout, re.CheckIn) * re.Rate) as Revenue,
        COUNT(*) as TotalReservations
    FROM reservations re
    GROUP BY BestMonth
    ORDER BY Revenue DESC
    LIMIT 1) as derivedTable;


USE `INN`;
-- Query 5
-- For each room report whether it is occupied or unoccupied on August 10, 2010.
Report the full name of the room, the room code, and put either 'Occupied'
or 'Empty' depending on whether the room is occupied on that day.
(the room is occupied if there is someone staying the night of  August 10, 2010. It is NOT occupied if there is a checkout on this day, but no check in).  Output in alphabetical order by room code.

Note: this query can be approached either with the use of the CASE ... WHEN clause, or by being somewhat crafty with standard SELECT statements.

SELECT r.RoomName, r.RoomCode,
    CASE WHEN res.CheckIn IS NOT NULL THEN 'Occupied'
    ELSE 'Empty'
    END AS Status
FROM rooms r LEFT JOIN reservations res ON r.RoomCode = res.Room 
    AND res.CheckIn <= '2010-08-10'
    AND (res.Checkout IS NULL OR res.Checkout > '2010-08-10')
ORDER BY r.RoomCode ASC;


