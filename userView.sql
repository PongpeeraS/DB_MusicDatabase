Use MusicDB
GO

CREATE VIEW ListSong AS
SELECT Song_ID, Song_NoteKey,Song_Title,Song_Lyrics,
Song_Dancable,Song_Teachable,Song_URL,Song_YearReleased,
Song_Copyright,Song_DatePosted
FROM Song
GO

CREATE VIEW InstrumentOfSong AS
SELECT Song_Title,Ins_Name,Ins_Family
FROM Musical_Instrument m
JOIN Uses ON m.Ins_ID = Uses.Ins_ID 
JOIN Song ON Uses.Song_ID = Song.Song_ID
GO

CREATE VIEW WriterOfSong AS
SELECT Song_Writer,Song_Title FROM Song_Writers 
JOIN Song ON Song_Writers.Song_ID = Song.Song_ID 
GO

CREATE VIEW ArtistOfSong AS
SELECT  Song.Song_Title,Art_Name FROM Performs 
JOIN Song ON Performs.Song_ID = Song.Song_ID 
JOIN Artist ON Performs.Art_ID = Artist.Art_ID 
GO

CREATE VIEW RegionOfSong AS
SELECT Song_Title, Cou_Region FROM Song 
JOIN Cou_Regions ON Song.Cou_ID = Cou_Regions.Cou_ID
GO

CREATE VIEW ArtistPerforms AS
SELECT Art_Name, Song_NoteKey,Song_Title, 
Song_Lyrics,Song_Dancable,Song_Teachable,Song_URL,
Song_YearReleased,Song_CopyRight FROM Song 
JOIN Performs ON Song.Song_ID = Performs.Song_ID 
join Artist on Performs.Art_ID = Artist.Art_ID;
GO

CREATE VIEW SentimentOfSong AS
SELECT Song_Title,Song_Sentiment from Song_Sentiments 
JOIN Song ON Song.Song_ID = Song_Sentiments.Song_ID;
GO

CREATE VIEW EraOfSong AS
SELECT Song.Song_ID,Song_Title,Era_Name,Era_StartYear,Era_EndYear 
FROM Era JOIN Song ON Song.Song_ID = Era.Song_ID;
GO

CREATE VIEW PatternNoteOfSong AS
SELECT Song_ID,Song_Title,Song_NoteKey FROM Song;
GO

CREATE VIEW CeremonyOfSong AS
SELECT Song_Title, Cer_Name FROM Song JOIN Played_in ON Played_in.Song_ID = Song.Song_ID JOIN Ceremony ON Ceremony.Cer_ID = Played_in.Cer_ID
GO

CREATE VIEW AlbumsContainSong AS
SELECT Song.Song_ID,Song_Title,Alb_Name FROM Album 
JOIN Contain ON Contain.Alb_ID = Album.Alb_ID 
JOIN Song ON Contain.Song_ID = Song.Song_ID
GO

CREATE VIEW NumberOfSingerInEachSong AS
SELECT Song_Title,COUNT(Artist.Art_ID)AS TotalArtist 
FROM Performs JOIN Artist ON Performs.Art_ID = Artist.Art_ID 
JOIN Song ON Song.Song_ID = Performs.Song_ID GROUP BY Song_Title
GO

CREATE VIEW SongTeachable AS
SELECT Song_Title,Song_Teachable FROM Song;
GO

CREATE VIEW SongDancable AS
SELECT Song_Title, Song_Dancable FROM Song;
GO

CREATE VIEW CopyRightOfSong AS
SELECT Song_Title,Song_CopyRight FROM Song;
GO

CREATE VIEW GenreOfSong AS
SELECT Song_ID,Alb_Genre,Song_Title FROM Song JOIN Album ON Album.Alb_ID = Song.Alb_ID;
GO

CREATE VIEW PublisherOfSong AS
SELECT Song_Writer,Song_Title FROM Song_Writers JOIN Song ON Song_Writers.Song_ID = Song.Song_ID
GO

CREATE VIEW ReleasedYearOfSong AS
SELECT Song_Title, Song_YearReleased FROM Song
GO

CREATE VIEW PostedDateOfSong AS
SELECT Song_Title, Song_DatePosted FROM Song
GO

CREATE VIEW LyricsOfSong AS
SELECT Song_Title,Song_Lyrics FROM Song
GO

