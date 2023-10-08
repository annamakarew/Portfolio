-- Lab 6 - AIRLINES
-- amakarew
-- Jun 1, 2023

USE `AIRLINES`;
-- Query 1
-- Find all airports with exactly 19 outgoing flights. Report airport code and the
full name of the airport sorted in alphabetical order by the code.


SELECT Code, Name 
FROM airports JOIN flights ON Code = Source
GROUP BY Code, Name
HAVING COUNT(FlightNo) = 19
ORDER BY Code;


USE `AIRLINES`;
-- Query 2
-- Find the number of airports from which airport LTS can be reached with exactly one transfer. (make sure to exclude LTS itself from the count). Report just the number.



SELECT COUNT(DISTINCT f2.Destination)
FROM flights AS f1, flights AS f2
WHERE f1.Source = "LTS" AND f1.Destination = f2.Source 
    AND f2.Destination != f1.Source;


USE `AIRLINES`;
-- Query 3
--  
 Find the number of airports from which airport LTS can be reached with AT MOST  one transfer. (make sure to exclude LTS itself from the count).
Report just the number.



SELECT COUNT(DISTINCT f1.Source)
FROM flights AS f1, flights AS f2
WHERE f2.Destination = "LTS" AND f1.Source != f2.Destination
    AND ((f1.Destination = f2.Source) OR (f1.Source = f2.Source
    AND f1.Destination = f2.Destination));


USE `AIRLINES`;
-- Query 4
-- For each airline report the total number of airports from which it has at least two different outgoing flights. Report the full name of the airline and the number of airports computed.  Report the results sorted by the number of airports in descending order.
SELECT l.Name, COUNT(DISTINCT f.Source) AS 'Number of Airports'
FROM airlines AS l, flights AS f, flights AS f2
WHERE l.Id = f.Airline AND f.Airline = f2.Airline AND f.FlightNo != f2.FlightNo
    AND f.Source = f2.Source
GROUP BY l.Name
ORDER BY `Number of Airports` DESC, l.Name;


