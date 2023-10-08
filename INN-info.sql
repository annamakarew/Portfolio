-- Lab 4 - INN
-- amakarew
-- May 17, 2023

USE `INN`;
-- Query 1
-- Find all 'traditional' rooms with a base price above $170 and two beds.
Report room names and codes in alphabetical order by the code.



SELECT RoomCode, RoomName
FROM rooms
WHERE decor='traditional' AND basePrice>170 AND Beds=2
ORDER BY RoomCode;


USE `INN`;
-- Query 2
-- Find all July reservations (i.e.,  all reservations that
both start AND end in July) for the 'Frugal not apropos' room.
For each reservation report the last name of the person who
reserved it,  check-in and check-out dates, the total number of people staying and the total cost of the reservation. Output reservations in chronological order.
SELECT LastName, CheckIn, Checkout, Adults+Kids, Rate*(Checkout-CheckIn)
FROM reservations, rooms
WHERE reservations.Room=rooms.RoomCode AND RoomName='Frugal not apropos' 
    AND CheckIn>='2010-07-01' AND CheckIn<='2010-07-31' 
    AND Checkout>='2010-07-01' AND Checkout<='2010-07-31'
ORDER BY CheckIn;


USE `INN`;
-- Query 3
-- Find all rooms occupied on  September 23, 2010. Report full name of
the room,  the check-in and checkout dates of the reservation.
Sort output in alphabetical order by room name.

SELECT RoomName, CheckIn, Checkout
FROM rooms, reservations
WHERE reservations.Room=rooms.RoomCode AND CheckIn<='2010-09-23' 
    AND Checkout>'2010-09-23'
ORDER BY RoomName;


USE `INN`;
-- Query 4
-- For each stay of BO DURAN in the hotel, 
calculate the total amount of money, they  paid. Report reservation
code, checkin and checkout dates, room name (full) and the total
amount of money the stay cost. Sort output in chronological order
by the day of arrival.  Output check-in and check-out dates in the "Month Day" format (e.g., 'July 19', no need to report year).
SELECT CODE, RoomName, DATE_FORMAT(CheckIn, '%M %e'), 
    DATE_FORMAT(Checkout, '%M %d'), Rate*(Checkout-CheckIn)
FROM reservations, rooms
WHERE LastName='DURAN' AND FirstName='BO' AND reservations.Room=rooms.RoomCode
ORDER BY CheckIn;


USE `INN`;
-- Query 5
-- Find out all modern room reservations that overlapped in time with the stays of FRITZ SPECTOR. Report the full name of the room, the last name of the person placing the reservation, the checkin date and the number of nights. Sort output in chronological order, and in alphabetical order by room name for reservations that started on the same day.
SELECT DISTINCT RoomName, r2.LastName, r2.CheckIn, 
    DATEDIFF(r2.Checkout, r2.CheckIn)
FROM rooms, reservations as r1, reservations as r2
WHERE decor='modern' AND r1.LastName='SPECTOR' AND r1.FirstName='FRITZ'
    AND ((r2.CheckIn>=r1.CheckIn AND r2.CheckIn<r1.Checkout)
    OR (r2.CheckIn<=r1.CheckIn AND r2.Checkout>r1.Checkout))
    AND RoomCode=r2.Room AND r2.LastName!='SPECTOR'
ORDER BY r2.CheckIn, RoomName;


USE `INN`;
-- Query 6
-- Report all reservations in rooms with  beds of type 'Double' that contained four adults.
For each reservation report its code, the full name and the code of the room,
check-in and check out dates. Report reservations in chronological order,
and sorted by the three-letter room code (in alphabetical order) for any reservations that commenced on the same day. Report check-in and check-out dates in the format 'Day Mon' (day followed by the abbreviated month), no year is required.

SELECT CODE, RoomCode, RoomName, DATE_FORMAT(CheckIn, '%e %b'), 
    DATE_FORMAT(Checkout, '%e %b') 
FROM rooms, reservations
WHERE bedType='Double' AND Adults='4' AND Room=RoomCode
ORDER BY CheckIn, RoomName;


