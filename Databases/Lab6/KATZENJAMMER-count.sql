-- Lab 6 - KATZENJAMMER
-- amakarew
-- Jun 2, 2023

USE `KATZENJAMMER`;
-- Query 1
-- For each performer (use first name) report how many times she sang lead vocals on a song. Sort output in descending order by the number of leads.


SELECT Firstname, Count(*) 
FROM Vocals JOIN Band on Bandmate = Id
WHERE VocalType = 'lead'
GROUP BY Bandmate
ORDER BY COUNT(*) DESC;


USE `KATZENJAMMER`;
-- Query 2
-- Report how many different unique instruments  each performer plays on songs from  'Rockland'. Sort the output by the first name of the performers.


SELECT Firstname, COUNT(DISTINCT Instrument) 
FROM Albums JOIN Tracklists on Album = AId 
    JOIN Songs on SongId = Tracklists.Song 
    JOIN Instruments on SongId = Instruments.Song 
    JOIN Band on Bandmate = Band.Id
WHERE Albums.Title = 'Rockland'
GROUP BY Bandmate
ORDER BY Firstname;


USE `KATZENJAMMER`;
-- Query 3
-- Report the number of times Solveig stood at each stage position when
performing live. Sort output in ascending order of the number of times
she performed in each position.

SELECT StagePosition, COUNT(*)
FROM Performance JOIN Band ON Id = Bandmate
WHERE Firstname = 'Solveig'
GROUP BY StagePosition
ORDER BY COUNT(*);


USE `KATZENJAMMER`;
-- Query 4
-- Report how many times each of the remaining peformers played the bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. Sort output alphabetically by the name of the performer.

SELECT b2.firstname, COUNT(Instruments.Song)
FROM Band AS b1, Performance, Instruments, Band AS b2
WHERE b1.firstname = 'Anne-Marit' AND StagePosition = 'left'
    AND Performance.Bandmate = b1.Id AND Performance.Song = Instruments.Song
    AND Instrument = 'bass balalaika' AND b1.firstname != b2.firstname
    AND b2.Id = Instruments.Bandmate
GROUP BY b2.firstname
ORDER BY b2.firstname;


USE `KATZENJAMMER`;
-- Query 5
-- Report all instruments (in alphabetical order) that were played by all four members of Katzenjammer.

SELECT Instrument
FROM Instruments
GROUP BY Instrument
HAVING COUNT(DISTINCT Bandmate) = 4
ORDER BY Instrument;


USE `KATZENJAMMER`;
-- Query 6
-- For each performer, report the number of times they played more than one instrument on the same song. Sort output in alphabetical order by first name of the  performer. (Yes, you can do it without using nested queries!).

SELECT Firstname, COUNT(DISTINCT i1.Song)
FROM Band, Instruments AS i1, Instruments AS i2
WHERE Id = i1.Bandmate AND Id = i2.Bandmate AND i1.Song = i2.Song
    AND i1.Instrument != i2.Instrument
GROUP BY Firstname
ORDER BY Firstname;


