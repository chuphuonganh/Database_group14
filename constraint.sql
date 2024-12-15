USE music;

-- Thêm ràng buộc FOREIGN KEY cho ArtistID
ALTER TABLE Album
ADD CONSTRAINT fk_artist FOREIGN KEY (ArtistID) 
REFERENCES Artist(ArtistID) 
ON DELETE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho AlbumID
ALTER TABLE Songs
ADD CONSTRAINT fk_album FOREIGN KEY (AlbumID) 
REFERENCES Album(AlbumID) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho GenreID
ALTER TABLE Songs
ADD CONSTRAINT fk_genre FOREIGN KEY (GenreID) 
REFERENCES Genres(GenreID) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho UserID (các lần sử dụng khác nhau)
ALTER TABLE Playlists
ADD CONSTRAINT fk_user FOREIGN KEY (UserID) 
REFERENCES Users(UserID) 
ON DELETE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho PlaylistID
ALTER TABLE Playlist_Songs
ADD CONSTRAINT fk_playlist FOREIGN KEY (PlaylistID) 
REFERENCES Playlists(PlaylistID) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho SongID (các lần sử dụng khác nhau)
ALTER TABLE Playlist_Songs
ADD CONSTRAINT fk_song FOREIGN KEY (SongID) 
REFERENCES Songs(SongID) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- Thêm ràng buộc FOREIGN KEY cho LibraryID
ALTER TABLE Library_Songs
ADD CONSTRAINT fk_library FOREIGN KEY (LibraryID) 
REFERENCES Library(LibraryID) 
ON DELETE CASCADE 
ON UPDATE CASCADE;
