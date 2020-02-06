Use MusicDB
CREATE INDEX index_Artist on Artist(Art_ID,Art_Name);

CREATE INDEX index_Song on Song(Song_ID,Song_Title);

CREATE INDEX index_Instrument on Musical_Instrument(Ins_ID, Ins_Name)

CREATE INDEX index_Uses on Uses(Song_ID,Ins_ID)

CREATE INDEX index_Perform on Performs(Song_ID, Art_ID)

CREATE INDEX index_Album on Album(Alb_ID,Alb_Name)

CREATE INDEX index_Ceremony on Ceremony(Cer_ID, Cer_Name)


