-- Lab 5- KATZENJAMMER
-- amakarew
-- May 25, 2023

USE `KATZENJAMMER`;
-- Query 1
-- Find the number of times each band member played bass balalaika on Katzenjammer songs. Report the result as four separate rows, each consisting of the name of one musician, and the number of times she played bass balalaika.   (REMINDER: you are NOT allowed to use GROUP BY for this)



SELECT Firstname, COUNT(*)
FROM Band, Instruments
WHERE Instrument = 'bass balalaika' AND Bandmate = Id AND Firstname = 'Solveig'
UNION
SELECT Firstname, COUNT(*)
FROM Band, Instruments
WHERE Instrument = 'bass balalaika' AND Bandmate = Id AND Firstname = 'Marianne'
UNION
SELECT Firstname, COUNT(*)
FROM Band, Instruments
WHERE Instrument = 'bass balalaika' AND Bandmate = Id AND Firstname = 'Anne-Marit'
UNION
SELECT Firstname, COUNT(*)
FROM Band, Instruments
WHERE Instrument = 'bass balalaika' AND Bandmate = Id AND Firstname = 'Turid';


USE `KATZENJAMMER`;
-- Query 2
-- Find the number of times Solveig was positioned center stage while
Turid sang lead.

SELECT COUNT(*)
FROM Performance as p1, Band as b1, Band as b2, Vocals
WHERE b1.Firstname = 'Solveig' AND b2.Firstname = 'Turid' 
    AND p1.StagePosition = 'center' AND p1.Bandmate = b1.Id
    AND b2.Id = Vocals.Bandmate AND VocalType = 'lead'
    AND Vocals.Song = p1.Song;


USE `KATZENJAMMER`;
-- Query 3
-- Find the number of times Anne-Marit played banjo, sang lead, and was positioned center stage.

SELECT COUNT(*)
FROM Band, Instruments, Vocals, Performance
WHERE Firstname = 'Anne-Marit' AND Instrument = 'banjo' 
    AND Id = Instruments.Bandmate AND Id = Vocals.Bandmate
    AND Instruments.Song = Vocals.Song AND VocalType = 'lead'
    AND Performance.StagePosition = 'center' AND Id = Performance.Bandmate
    AND Performance.Song = Instruments.Song AND Performance.Song = Vocals.Song;


USE `KATZENJAMMER`;
-- Query 4
-- Find the total number of different instruments Turid played on Katzenjammer songs.


SELECT COUNT(DISTINCT Instrument)
FROM Band, Instruments
WHERE Firstname = 'Turid' AND Id = Bandmate;


USE `KATZENJAMMER`;
-- Query 5
-- List all the instruments that both Solveig and Turid played on (possibly different) Katzenjammer songs.

SELECT DISTINCT i1.Instrument
FROM Instruments as i1, Instruments as i2, Band as b1, Band as b2
WHERE b1.Firstname = 'Solveig' AND b1.Id = i1.Bandmate 
    AND b2.Firstname = 'Turid' AND b2.Id = i2.Bandmate 
    AND i1.Instrument = i2.Instrument
ORDER BY i1.Instrument;


USE `KATZENJAMMER`;
-- Query 6
-- Find how many songs DID NOT feature a guitar.

(Note: you CAN and MUST do this without using nested queries)


SELECT (COUNT(DISTINCT SongId) - COUNT(DISTINCT Song))
FROM Instruments, Songs
WHERE Instrument = 'guitar';


USE `KATZENJAMMER`;
-- Query 7
--  Find on how many songs at least two performers played the same instrument.

SELECT COUNT(DISTINCT i1.Song)
FROM Instruments as i1, Instruments as i2
WHERE i1.Instrument = i2.Instrument AND i1.Song = i2.Song 
    AND i1.Bandmate != i2.Bandmate;


