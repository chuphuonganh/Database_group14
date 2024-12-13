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
		IN Address VARCHAR(100),
		IN City VARCHAR(50),
		IN Country VARCHAR(50)
	)
	BEGIN
		INSERT INTO Users VALUES (UserName, Email, JoinedDate,Address, City, Country);
	END$$
DELIMITER ;
 
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