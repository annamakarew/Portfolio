-- Lab 4 - AIRLINES
-- amakarew
-- May 18, 2023

USE `AIRLINES`;
-- Query 1
-- Find all airlines that have at least one flight out of  the Akutan (KQA) airport. Report the full name and the abbreviation of each airline. Report each name
only once. Sort the airlines in alphabetical order.

SELECT DISTINCT airlines.Name, airlines.Abbr
FROM airlines, flights
WHERE flights.Source='KQA' AND flights.Airline=airlines.Id
ORDER BY airlines.Name;


USE `AIRLINES`;
-- Query 2
-- Find all destinations served from the KQA airport
by Delta. Report flight number, airport code and the
full name of the airport. Sort in ascending order by flight number.

SELECT flights.FlightNo, flights.Destination, airports.Name
FROM airports, flights, airlines
WHERE flights.Source='KQA' AND airlines.Name='Delta Airlines' 
    AND airlines.Id=flights.Airline AND flights.Destination=airports.Code
ORDER BY flights.FlightNo;


USE `AIRLINES`;
-- Query 3
-- Find all other destinations that are accessible from
KQA on only Delta flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations,
and full names of the airports sorted in alphabetical order by the airport code.

SELECT f1.FlightNo, f2.FlightNo, f2.Destination, airports.Name
FROM flights AS f1, flights AS f2, airports, airlines
WHERE f1.Source='KQA' AND airlines.Name='Delta Airlines' 
    AND airlines.Id=f1.Airline AND f1.Destination=f2.Source 
    AND airlines.Id=f2.Airline AND f2.Destination=airports.Code
    AND f2.Destination!='KQA'
ORDER BY airports.Name;


USE `AIRLINES`;
-- Query 4
-- Report all pairs of airports served by both Delta and JetBlue.
Each pair must be reported exactly once (if a pair X,Y is reported, than a pair Y,X is redundant and should not be reported). For each airport, report
its code and its full name.

Note: while my query reports pairs in a specific order (first airport-second airport), the query that results in reporting the same pairs in any order will be considered correct. Use "Show Expected Result" to ensure that you are reporting the same pairs.
SELECT a1.Name, a1.Code, a2.Name, a2.Code
FROM airports as a1, airports as a2, airlines as l1, airlines as l2, 
    flights as f1, flights as f2
WHERE l1.Name='Delta Airlines' AND l2.Name='JetBlue Airways'
    AND f1.Source=f2.Source AND f1.Destination=f2.Destination
    AND f1.Airline=l1.Id AND f2.Airline=l2.Id 
    AND f1.Source=a1.Code AND f2.Destination=a2.Code AND a1.Code<a2.Code;


USE `AIRLINES`;
-- Query 5
-- Find all airports served by ALL five of the airlines listed below: Delta,
Frontier,  USAir, UAL, and Southwest. Report just
the airport codes, sorted in alpahebetical order.

SELECT DISTINCT f1.Source
FROM flights AS f1, flights AS f2, flights AS f3, flights AS f4, flights AS f5,
    airlines AS a1, airlines AS a2, airlines AS a3, airlines AS a4,
    airlines AS a5
WHERE a1.Abbr='Delta' AND a2.Abbr='Frontier' AND a3.Abbr='USAir' 
    AND a4.Abbr='UAL' AND a5.Abbr='Southwest'AND f1.Airline=a1.Id
    AND f2.Airline=a2.Id AND f3.Airline=a3.Id AND f4.Airline=a4.Id
    AND f5.Airline=a5.Id AND f1.Source=f2.Source AND f2.Source=f3.Source
    AND f3.Source=f4.Source AND f4.Source=f5.Source
ORDER BY f1.Source;


USE `AIRLINES`;
-- Query 6
-- Find all airports that are served by at least three  Delta flights.
Report just the three-letter codes of the airports --- each code excactly once,
in alphabetical order.

SELECT DISTINCT f1.Source
FROM flights AS f1, flights AS f2, flights AS f3, airlines
WHERE airlines.Abbr='Delta' AND airlines.Id=f1.Airline AND f1.Source=f2.Source
    AND f2.Source=f3.Source AND f1.Destination!=f2.Destination
    AND f2.Destination!=f3.Destination AND f1.Destination!=f3.Destination
    AND airlines.Id=f2.Airline AND airlines.Id=f3.Airline
ORDER BY f1.Source;


