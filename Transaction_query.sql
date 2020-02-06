Use MusicDB
--a)List the details of songs--
SELECT * FROM Song

--b)List the details of all instruments that are used in a song
--suppose would like to search instruments of song 'Kiss Kiss'
EXEC proc_SongInstrument @SongName = 'Kiss Kiss'

--c)List songs that contain the query word (e.g. return songs that contain the word “love” in title)
EXEC proc_SongQueryWord @QueryWord = 'love'

--d)Identify song writers of songs in order
SELECT Song_Writer,Song_Title FROM Song_Writers JOIN Song ON Song_Writers.Song_ID = Song.Song_ID ORDER BY Song_Writer

--e)Identify who is an artist of a song
SELECT Song.Song_Title,Art_Name FROM Performs JOIN Song ON Performs.Song_ID = Song.Song_ID JOIN Artist ON Performs.Art_ID = Artist.Art_ID ORDER BY Song_Title;

--f)Indentify region of the songs (i.e. created in what region)
SELECT Song_Title, Cou_Region FROM Song JOIN Cou_Regions ON Song.Cou_ID = Cou_Regions.Cou_ID

--g)Identify songs that are performed by an artist
EXEC proc_ArtistSong @ArtistName = 'Paulo Coelo'

--h)Identify the sentiment of a song
SELECT Song_Title,Song_Sentiment from Song_Sentiments JOIN Song ON Song.Song_ID = Song_Sentiments.Song_ID

--i)Identify era of songs order by song title
SELECT Song.Song_ID,Song_Title,Era_Name,Era_StartYear,Era_EndYear FROM Era JOIN Song ON Song.Song_ID = Era.Song_ID ORDER BY Song_ID;

--j)Indentify pattern of notes that songs use
SELECT Song_ID,Song_Title,Song_NoteKey FROM Song;

--k)Indentify ceremony of songs
SELECT Song_Title, Cer_Name FROM Song JOIN Played_in ON Played_in.Song_ID = Song.Song_ID JOIN Ceremony ON Ceremony.Cer_ID = Played_in.Cer_ID

--l)Identify albums that contain a song
EXEC proc_AlbumContainSong @SongName = 'lemon'

--m)Identify total number of singers
SELECT Song_Title,COUNT(Artist.Art_ID)AS TotalArtist FROM Performs JOIN Artist ON Performs.Art_ID = Artist.Art_ID JOIN Song ON Song.Song_ID = Performs.Song_ID GROUP BY Song_Title;

--n)Identify whether song is teachable or not
EXEC proc_SongTeachable @SongName = 'Lemon'

--o)Identify whether song is danceable or not
EXEC proc_SongDancable @SongName = 'Kiss Kiss'

--q)Identify what kind of copyright of songs
SELECT Song_Title,Song_CopyRight FROM Song Order by Song_CopyRight

--r)Identify genre of songs (eg. Jazz)
SELECT Song_ID,Alb_Genre,Song_Title FROM Song JOIN Album ON Album.Alb_ID = Song.Alb_ID

--s)Identify publisher of songs
SELECT Song_Writer,Song_Title FROM Song_Writers JOIN Song ON Song_Writers.Song_ID = Song.Song_ID Order by Song_Writer

--t)Identify released date of songs
SELECT Song_Title, Song_YearReleased FROM Song Order by Song_YearReleased

--u)Identify posted date of songs(post in system)
SELECT Song_Title, Song_DatePosted FROM Song

--v)Identify lyrics of songs
SELECT Song_Title,Song_Lyrics FROM Song

--Search Song with full inputs
EXEC proc_Search @Song_Lyrics = 'get' ,@Song_Title = 'I' , @Song_Sentiment = 'cheerful' ,@Song_Instrument = 'chakhe', @Song_Writer = 'Vera Ward', @Song_Country = 'Thailand'
--Search Song with missing some inputs
EXEC proc_Search @Song_Lyrics = null  ,@Song_Title = null , @Song_Sentiment = 'cheerful' ,@Song_Instrument = null, @Song_Writer = null, @Song_Country = null

--Insert Review
EXEC proc_InsertReview @SongName = 'Lemon', @MemberName = 'Freya' ,@Comment = 'Nice song!', @rating = 5, @date = '1993-12-21'

--Insert new song
EXEC proc_InsertSong
    @noteKey = 6,
    @title = 'I want to break free',
    @lyrics = 'I get on with life as a doctor, I''m a kind and generous kinda person.',
    @dancable = 1,
    @teachable = 1,
    @url = '134.132.99.199',
    @yearreleased = 1986,
    @copyright = 'Purchasing',
    @membername = 'Freya Smith',
    @countryname = 'Thailand',
    @albumname = 'Tennessee Williams'

