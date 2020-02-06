Use MusicDB
GO
--procedure b)
CREATE PROCEDURE proc_SongInstrument
@SongName varchar(255)
AS 
BEGIN
	SET NOCOUNT ON
	SELECT Ins_Name,Ins_Family FROM Musical_Instrument m JOIN Uses ON m.Ins_ID = Uses.Ins_ID WHERE Uses.Song_ID IN (SELECT (Song_ID) FROM Song WHERE Song_Title = @SongName);
END
GO
--procedure c
CREATE PROCEDURE proc_SongQueryWord
@QueryWord varchar(255)
AS 
BEGIN
	SET NOCOUNT ON
	SELECT * FROM Song WHERE Song_Title LIKE '%'+@QueryWord+'%';
END
GO
--procedure g
CREATE PROCEDURE proc_ArtistSong
@ArtistName varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	SELECT Song.Song_ID, Song_NoteKey,Song_Title, Song_Lyrics,Song_Dancable,Song_Teachable,Song_URL,Song_YearReleased,Song_CopyRight FROM Song JOIN Performs ON Song.Song_ID = Performs.Song_ID join Artist on Performs.Art_ID = Artist.Art_ID WHERE Artist.Art_ID IN (SELECT (Art_ID) FROM Artist WHERE Art_Name = @ArtistName);
END
GO
--procedure l
CREATE PROCEDURE proc_AlbumContainSong
@SongName varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	SELECT distinct(Alb_Name) FROM Album JOIN Contain ON Contain.Alb_ID = Album.Alb_ID 
	JOIN Song ON Contain.Song_ID IN (SELECT Song_ID FROM Song WHERE Song_Title = @SongName)
END
GO
--procedure n
CREATE PROCEDURE proc_SongTeachable
@SongName varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @teach char(1)
	SET @teach = (SELECT top 1 Song_Teachable FROM Song WHERE Song_Title = @SongName)
	IF @teach = '1'
		SELECT top 1 Song_Title, 'Yes' AS Teachable FROM Song WHERE Song_Title = @SongName;
	ELSE IF @teach = '0'
		SELECT top 1 Song_Title, 'No' AS Teachable FROM Song WHERE Song_Title = @SongName;
END
GO
--procedure o
CREATE PROCEDURE proc_SongDancable
@SongName varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @dance char(1)
	SET @dance = (SELECT top 1 Song_Teachable FROM Song WHERE Song_Title = @SongName)
	IF @dance = '1'
		SELECT top 1 Song_Title, 'Yes' AS Dancable FROM Song WHERE Song_Title = @SongName;
	ELSE IF @dance = '0'
		SELECT top 1 Song_Title, 'No' AS Dancable FROM Song WHERE Song_Title = @SongName;
END
GO


--procedure to searchSong
CREATE PROCEDURE proc_Search
@Song_Lyrics varchar(255), @Song_Title varchar(255),
@Song_Sentiment varchar(255), @Song_Instrument varchar(255),
@Song_Writer varchar(255), @Song_Country varchar(255)

as
begin
	set nocount on
	if(@Song_Lyrics is null)
		set @Song_Lyrics = '%'
	if(@Song_Title is null)
		set @Song_Title = '%'
	if(@Song_Sentiment is null)
		set @Song_Sentiment = '%'
	if(@Song_Instrument is null)
		set @Song_Instrument = '%'
	if(@Song_Writer is null)
		set @Song_Writer = '%'
	if(@Song_Country is null)
		set @Song_Country = '%'
	
	select * from Song join Song_Sentiments on Song_Lyrics LIKE '%'+ @Song_Lyrics +'%' and Song_Title LIKE '%'+ @Song_Title +'%'
	and Song_Sentiment LIKE '%' + @Song_Sentiment +'%' and Song.Song_ID IN (SELECT Song_ID FROM Uses JOIN Musical_Instrument ON Uses.Ins_ID IN (SELECT Ins_ID FROM Musical_Instrument WHERE Musical_Instrument.Ins_Name LIKE '%'+@Song_Instrument+'%'))
	and Song.Song_ID IN (SELECT Song.Song_ID FROM Song JOIN Song_Writers ON Song.Song_ID IN (SELECT Song_ID FROM Song_Writers WHERE Song_Writer LIKE '%' + @Song_Writer +'%'))
	and Song.Song_ID IN (SELECT Song.Song_ID FROM Song JOIN Era ON Era.Song_ID = Song.Song_ID JOIN Country ON Era.Cou_ID IN (SELECT Cou_ID FROM Country WHERE Cou_Name LIKE '%'+@Song_Country+'%'))
	
end
GO
--procedure to insert reviews
CREATE PROCEDURE proc_InsertReview
@SongName varchar(255), @MemberName varchar(255),@Comment varchar(255), @rating int, @date date
AS
BEGIN
	SET NOCOUNT ON
	insert into Review values((SELECT CONCAT('Re0000',CAST(SUBSTRING(MAX(Review.Rev_ID),CHARINDEX('Re',MAX(Review.Rev_ID),0)+2,7)AS INT) + 1) FROM Review)
	,@Comment,@rating,@date,(select top 1 Mem_ID from Member where Mem_FullName LIKE '%'+@MemberName+'%'),(select top 1 Song_ID from Song where Song_Title LIKE '%'+@SongName+'%'));
END
GO
--procedure to insert new song
CREATE PROCEDURE proc_InsertSong
    -- Add the parameters for the stored procedure here
    @noteKey char(3),
    @title varchar(255),
    @lyrics varchar(255),
    @dancable char(1),
    @teachable char(1),
    @url varchar(255),
    @yearreleased int,
    @copyright char(50),
    @membername char(30),
    @countryname char(20),
    @albumname char(20)

AS
BEGIN
    SET NOCOUNT ON;
	-- Insert statements for procedure here
    DECLARE @songID char(8), @memID char(8), @couID char(8), @albID char(8);
    SET @songID = (SELECT CONCAT('S000',CAST(SUBSTRING(MAX(Song.Song_ID),CHARINDEX('S',MAX(Song.Song_ID),0)+1,7)AS INT) + 1) FROM Song)
    SET @memID = (SELECT TOP 1 Mem_ID FROM Member WHERE @membername = Mem_FullName)
    SET @couID = (SELECT TOP 1 Cou_ID FROM Country WHERE @countryname = Cou_Name)
    SET @albID = (SELECT TOP 1 Alb_ID FROM Album WHERE @albumname = Alb_Name)
    INSERT INTO MusicDB.dbo.Song
    VALUES (@songID, @noteKey, @title, @lyrics, @dancable, @teachable, @url,
   	 @yearreleased, @copyright, GETDATE(), @memID, @couID, @albID
    )
END
GO

