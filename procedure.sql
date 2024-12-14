use music;
-- 1.Dùng câu lệnh Procedures để có tên bài hát, ta có thể truy vấn đến thông tin tác giả của nó
DELIMITER $$
	CREATE PROCEDURE GetArtistByNameOfSong(
		IN SongNameIs VARCHAR(100)
	)
	BEGIN
		SELECT *  FROM Artist a
        join album al on al.ArtistID = a.ArtistID
        join songs s on s.AlbumID = al.AlbumID
        where s.SongName = SongNameIs;
	END$$
DELIMITER ;

CALL GetArtistByNameOfSong('Back to December');

-- 2. Dùng câu lệnh Procedures để thêm một User mới vào hệ thống
DELIMITER $$
CREATE PROCEDURE InsertIntoUsers(
    IN UserName VARCHAR(100),
    IN Email VARCHAR(100),
    
    IN JoinedDate DATETIME,
    IN Member ENUM('NORMAL', 'PREMIUM', 'VIP'),
    IN Address VARCHAR(100),
    IN City VARCHAR(50),
    IN Country VARCHAR(50)
)
BEGIN
    INSERT INTO Users (UserName, Email, JoinedDate,Member, Address, City, Country) 
    VALUES (UserName, Email, JoinedDate, Member, Address, City, Country);
END$$
DELIMITER ;
CALL InsertIntoUsers('Dophinmew', 'mewmew@gmail.com', NOW(),'NORMAL', 'Hoàn Long', 'Hưng Yên', 'Việt Nam');
select * from Users
where UserID = last_insert_id();
--  3. Lấy danh sách bài hát trong 1 album
DELIMITER $$
CREATE PROCEDURE GetSongsByAlbumName(
    IN AlbumNameIs VARCHAR(100)
)
BEGIN
    SELECT s.SongName, s.Duration
    FROM songs s
    JOIN album al ON s.AlbumID = al.AlbumID
    WHERE al.AlbumName = AlbumNameIs;
END $$

DELIMITER ;
CALL GetSongsByAlbumName('BE');
-- 4. Lấy danh sách tất cả các playlists của một người dùng
DELIMITER $$
CREATE PROCEDURE GetPlaylistsByUser(
    IN UserNameIs VARCHAR(100)
)
BEGIN
    SELECT p.PlaylistName, p.CreatedDate
    FROM playlists p
    JOIN users u ON p.UserID = u.UserID
    WHERE u.UserName = UserNameIs;
END$$
DELIMITER ;

-- 5. Thêm một bài hát mới vào playlist
DELIMITER $$
CREATE PROCEDURE AddSongToPlaylist(
    IN PlaylistNameIs VARCHAR(100),
    IN SongIDIs INT
)
BEGIN
    DECLARE PlaylistID INT;
    SELECT PlaylistID INTO PlaylistID
    FROM playlists
    WHERE PlaylistName = PlaylistNameIs;
    
    IF PlaylistID IS NOT NULL THEN
        INSERT INTO playlist_songs (PlaylistID, SongID)
        VALUES (PlaylistID, SongIDIs);
    END IF;
END$$
DELIMITER ;

-- 6. Lấy tất cả bài hát của một thể loại cụ thể
DELIMITER $$
CREATE PROCEDURE GetSongsByGenre(
    IN GenreNameIs VARCHAR(50)
)
BEGIN
    SELECT s.SongName, s.Duration
    FROM songs s
    JOIN genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = GenreNameIs;
END$$
DELIMITER ;

-- 7. Đánh giá một bài hát (thêm rating vào bảng ratings)
DELIMITER $$
CREATE PROCEDURE AddRatingToSong(
    IN UserIDIs INT,
    IN SongIDIs INT,
    IN RatingValue TINYINT,
    IN ReviewText TEXT
)
BEGIN
    INSERT INTO ratings (UserID, SongID, Rating, Review, CreatedDate)
    VALUES (UserIDIs, SongIDIs, RatingValue, ReviewText, NOW());
END$$
DELIMITER ;
CALL AddRatingToSong(134,2,4,NULL);
select * from Ratings
where UserID = 134 and SongID = 2;
-- 8. Lấy danh sách các nghệ sĩ được theo dõi bởi một người dùng
DELIMITER $$
CREATE PROCEDURE GetFollowedArtists(
    IN UserIDIs INT
)
BEGIN
    SELECT a.ArtistName, a.Country, a.Style
    FROM artistfollow af
    JOIN artist a ON af.ArtistID = a.ArtistID
    WHERE af.UserID = UserIDIs;
END$$
DELIMITER ;

CALL GetPlaylistsByUser('Maya Pink');
CALL AddSongToPlaylist('Vocal Harmony Gems', 5);
select * from Playlists
where PlaylistName = 'Vocal Harmony Gems';
CALL GetSongsByGenre('Pop');
CALL GetFollowedArtists(1);
DROP PROCEDURE IF EXISTS InsertIntoUsers;
