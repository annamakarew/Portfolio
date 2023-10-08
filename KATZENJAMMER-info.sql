-- Lab 4 - KATZENJAMMER
-- amakarew
-- May 18, 2023

USE `KATZENJAMMER`;
-- Query 1
-- Report, in order, the tracklist for 'Le Pop'. Output just
the names of the songs in the order in which they occur on the album.

SELECT Songs.Title
FROM Albums, Songs, Tracklists
WHERE Albums.Title='Le Pop' AND Albums.AId=Tracklists.Album 
    AND Tracklists.Song=Songs.SongId
ORDER BY Tracklists.Position;


USE `KATZENJAMMER`;
-- Query 2
-- List the instruments each performer plays on 'To the Sea'.
Output the first name of each performer and the instrument, sort alphabetically
by the first name (and by the name of the instrument for the same person if needed).
SELECT Band.Firstname, Instruments.Instrument
FROM Instruments, Songs, Band
WHERE Songs.Title='To the Sea' AND Songs.SongId=Instruments.Song
    AND Instruments.Bandmate=Band.Id
ORDER BY Band.Firstname, Instruments.Instrument;


USE `KATZENJAMMER`;
-- Query 3
-- List all instruments played by Solveig at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).

SELECT DISTINCT Instruments.Instrument
FROM Band, Instruments
WHERE Band.Firstname='Solveig' AND Band.Id=Instruments.Bandmate
ORDER BY Instruments.Instrument;


USE `KATZENJAMMER`;
-- Query 4
-- Find all songs that featured  toy piano playing (by any of the performers). Report song titles in alphabetical order and the name of the person who played
the harmonica.

SELECT Songs.Title, Band.Firstname
FROM Instruments, Band, Songs
WHERE Instruments.Instrument='toy piano' AND Instruments.Bandmate=Band.Id
    AND Instruments.Song=Songs.SongId
ORDER BY Band.Firstname;


USE `KATZENJAMMER`;
-- Query 5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT DISTINCT Instruments.Instrument
FROM Band, Vocals, Instruments
WHERE Band.Firstname='Turid' AND Band.Id=Vocals.Bandmate 
    AND Vocals.VocalType='lead' AND Vocals.Song=Instruments.Song
    AND Instruments.Bandmate=Vocals.Bandmate
ORDER BY Instruments.Instrument;


USE `KATZENJAMMER`;
-- Query 6
-- Find all songs where the lead vocalist is not positioned center stage.
For each song, report the name, the name of the lead vocalist (first name) and
her position on the stage. Output results in alphabetical order by the song.
(Note: if a song had more than one lead vocalist, you may see multiple rows returned
for that song. This is the expected behavior).
SELECT Songs.Title, Band.Firstname, Performance.StagePosition
FROM Vocals, Performance, Band, Songs
WHERE Vocals.VocalType='lead' AND Vocals.Bandmate=Band.Id 
    AND Vocals.Bandmate=Performance.Bandmate AND Vocals.Song=Performance.Song
    AND Performance.StagePosition!='center' AND Vocals.Song=Songs.SongId
ORDER BY Songs.Title;


USE `KATZENJAMMER`;
-- Query 7
-- Find a song on which Anne-Marit played three different instruments. Report
the name of the song. (The name of the song shall be reported exactly once)

SELECT DISTINCT Songs.Title
FROM Songs, Band, Instruments as i1, Instruments as i2, Instruments as i3
WHERE Band.Firstname='Anne-Marit' AND Band.Id=i1.Bandmate 
    AND Band.Id=i2.Bandmate AND Band.Id=i3.Bandmate AND i1.Song=i2.Song
    AND i2.Song=i3.Song AND i1.Song=i3.Song AND i1.Instrument!=i2.Instrument
    AND i2.Instrument!=i3.Instrument AND i1.Instrument!=i3.Instrument
    AND i1.Song=Songs.SongId;


USE `KATZENJAMMER`;
-- Query 8
-- In the order of columns right - center - back - left, report the positioning
of the band during  'Johnny Blowtorch'. (just one record needs to be returned with four columns containing the first names of the performers who were staged at the specific positions during the song).

SELECT b1.Firstname AS 'right', b2.Firstname AS center, b3.Firstname AS back,
    b4.Firstname AS 'left'
FROM Performance AS p1, Performance AS p2, Performance AS p3, Performance AS p4,
    Band AS b1, Band AS b2, Band AS b3, Band AS b4, Songs
WHERE b1.Id=p1.Bandmate AND Songs.Title='Johnny Blowtorch'
    AND Songs.SongId=p1.Song AND p1.StagePosition='right' AND b2.Id=p2.Bandmate
    AND Songs.SongId=p2.Song AND p2.StagePosition='center' AND b3.Id=p3.Bandmate
    AND Songs.SongId=p3.Song AND p3.StagePosition='back' AND b4.Id=p4.Bandmate
    AND Songs.SongId=p4.Song AND p4.StagePosition='left';


