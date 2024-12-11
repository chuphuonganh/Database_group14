CREATE DATABASE IF NOT EXISTS Music;
USE Music;
-- ------------------------INNER JOIN
-- 1 
SELECT a.AlbumName, t.TotalSongs
FROM album a
INNER JOIN (
    SELECT AlbumID, COUNT(SongID) AS TotalSongs
    FROM songs
    GROUP BY AlbumID
) t ON a.AlbumID = t.AlbumID;
-- 2. Danh sách bài hát cùng tên album và nghệ sĩ 
SELECT Songs.SongName, Album.AlbumName, Artist.ArtistName
FROM Songs
INNER JOIN Album ON Songs.AlbumID = Album.AlbumID
INNER JOIN Artist ON Album.ArtistID = Artist.ArtistID;
-- 3. Thông tin bài hát cùng ngôn ngữ và thể loại 
SELECT Songs.SongName, Songs.Language, Genres.GenreName
FROM Songs
INNER JOIN Genres ON Songs.GenreID = Genres.GenreID;
-- 4 Thể loại ở USA có rating cao nhất
SELECT g.GenreName, AVG(r.Rating) AS AvgRating
FROM genres g
INNER JOIN songs s ON g.GenreID = s.GenreID
INNER JOIN ratings r ON s.SongID = r.SongID
INNER JOIN users u ON r.UserID = u.UserID
WHERE u.Country = 'USA' -- Thay bằng quốc gia bạn muốn
GROUP BY g.GenreName
ORDER BY AvgRating DESC
LIMIT 1;
-- 5 Danh sách nghệ sĩ có bài hát thuộc album phát hành gần đây nhất nhưng chưa được đánh giá
SELECT DISTINCT a.ArtistName
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON al.AlbumID = s.AlbumID
WHERE al.PublishedDate = (SELECT MAX(PublishedDate) FROM album)
  AND NOT EXISTS (
    SELECT 1
    FROM ratings r
    WHERE r.SongID = s.SongID
  );
  -- 6. Thống kê số lượng bài hát của mỗi nghệ sĩ được đánh giá trung bình trên 4 theo từng năm phát hành
SELECT a.ArtistName, YEAR(s.PublishedDate) AS ReleaseYear, COUNT(s.SongID) AS TotalHighRatedSongs
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON al.AlbumID = s.AlbumID
INNER JOIN ratings r ON s.SongID = r.SongID
GROUP BY a.ArtistID, YEAR(s.PublishedDate)
HAVING AVG(r.Rating) > 4
ORDER BY ReleaseYear ASC, TotalHighRatedSongs DESC;
-- 7. Lấy danh sách các bài hát và người dùng đã đánh giá chúng.
SELECT s.SongName, u.UserName, r.Rating
FROM songs s
INNER JOIN ratings r ON s.SongID = r.SongID
INNER JOIN users u ON r.UserID = u.UserID;
-- 8. Danh sách các nghệ sĩ mà người dùng theo dõi.
SELECT u.UserName, a.ArtistName
FROM users u
INNER JOIN artistfollow af ON u.UserID = af.UserID
INNER JOIN artist a ON af.ArtistID = a.ArtistID;
-- 9. Lấy tên người dùng và bài hát mà họ thêm vào thư viện.
SELECT l.LibraryID, u.UserName, s.SongName
FROM users u
INNER JOIN library l ON u.UserID = l.UserID
INNER JOIN library_songs ls ON l.LibraryID = ls.LibraryID
INNER JOIN songs s ON ls.SongID = s.SongID;
-- 10 các nghệ sĩ có bài hát với tổng thời lượng lớn hơn 500 phút
SELECT a.ArtistName, SUM(s.Duration) AS TotalDuration
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON al.AlbumID = s.AlbumID
GROUP BY a.ArtistName
HAVING SUM(s.Duration) > 500;

-- -- -- -------- --OUTER JOIN
-- 1. Thông tin thư viện và số lượng bài hát trong thư viện
SELECT Library.LibraryName, COUNT(Songs.SongID) AS SongCount
FROM Library_songs
LEFT OUTER JOIN Songs ON Library_songs.SongID = Songs.SongID
LEFT OUTER JOIN Library ON Library_songs.LibraryID = Library.LibraryID
GROUP BY Library.LibraryName;
-- 2. Danh sách nghệ sĩ và album của họ, kể cả nghệ sĩ chưa phát hành bài hát nào (outer  join)
SELECT Artist.ArtistName, Album.AlbumName
FROM Artist
LEFT OUTER JOIN Album ON Artist.ArtistID = Album.ArtistID;
-- 3. Danh sách playlist và người tạo, kể cả playlist không có người tạo
SELECT Playlists.PlaylistName, Users.UserName
FROM Playlists
LEFT OUTER JOIN Users ON Playlists.UserID = Users.UserID;
-- 4. Danh sách tất cả các nghệ sĩ cùng số lượng bài hát đã phát hành (kể cả nghệ sĩ chưa có bài hát).
SELECT a.ArtistName, COUNT(s.SongID) AS SongCount
FROM artist a
LEFT OUTER JOIN album ab ON ab.ArtistID = a.ArtistID
left outer join songs s on s.albumID = ab.albumID
GROUP BY a.ArtistName;
-- 5. Danh sách thể loại có số bài hát ít nhất kèm tổng điểm đánh giá của các bài hát thuộc thể loại đó.
SELECT g.GenreName, COUNT(s.SongID) AS TotalSongs, COALESCE(SUM(r.Rating), 0) AS TotalRating
FROM genres g
LEFT OUTER JOIN songs s ON g.GenreID = s.GenreID
LEFT OUTER JOIN ratings r ON s.SongID = r.SongID
GROUP BY g.GenreName
HAVING COUNT(s.SongID) <= 5;
-- 6. Danh sách tất cả bài hát và số lượt đánh giá của chúng (bao gồm bài hát chưa được đánh giá).
SELECT s.SongName, COUNT(r.RatingID) AS TotalRatings
FROM songs s
LEFT OUTER JOIN ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;
-- 7. Danh sách tất cả các playlist và điểm đánh giá trung bình của các bài hát trong playlist đó 
SELECT p.PlaylistName, COALESCE(AVG(r.Rating), 0) AS AverageRating
FROM playlists p
LEFT OUTER JOIN playlist_songs ps ON p.PlaylistID = ps.PlaylistID
LEFT OUTER JOIN ratings r ON ps.SongID = r.SongID
GROUP BY p.PlaylistName;
-- 8. Danh sách tất cả các thư viện và số lượng bài hát trong thư viện đó
SELECT l.LibraryName, COUNT(ls.SongID) AS TotalSongs
FROM library l
LEFT OUTER JOIN library_songs ls ON l.LibraryID = ls.LibraryID
GROUP BY l.LibraryName;
-- 9. tất cả bài hát và tổng số người dùng đã thêm bài hát đó vào thư viện
SELECT s.SongName, COUNT(l.UserID) AS TotalUsers
FROM songs s
LEFT OUTER JOIN library_songs ls ON s.SongID = ls.SongID
LEFT OUTER JOIN Library l on l.libraryID = ls.libraryID 
GROUP BY s.SongID, s.SongName;
-- 10 tất cả các nghệ sĩ và số lượng bài hát của họ trong thư viện của người dùng "JaneDoe"
SELECT a.ArtistName, COUNT(s.SongID) AS TotalSongsInLibrary
FROM artist a
LEFT OUTER JOIN  album al on al.ArtistID = a.ArtistID
LEFT OUTER JOIN songs s ON s.AlbumID = al.AlbumID
LEFT OUTER JOIN library_songs ls ON s.SongID = ls.SongID 
left outer join library l on l.UserID = (
    SELECT UserID FROM users WHERE UserName = 'JaneDoe'
)
GROUP BY a.ArtistName;
-- ------------------------- GROUP BY VA HAM TONG HOP
-- 1
SELECT 
    (SELECT COUNT(SongID) FROM songs) AS TotalSongs,
    (SELECT COUNT(AlbumID) FROM album) AS TotalAlbums,
    (SELECT COUNT(ArtistID) FROM artist) AS TotalArtists;
-- 2 Tìm album có nhiều bài hát nhất và số lượng bài hát trong đó (Group by - hàm tông hợp)
SELECT a.AlbumName, COUNT(s.SongID) AS TotalSongs
FROM album a
LEFT JOIN songs s ON a.AlbumID = s.AlbumID
GROUP BY a.AlbumID
ORDER BY TotalSongs DESC
LIMIT 1;
-- 3
SELECT g.GenreName, COUNT(s.SongID) AS TotalSongs
FROM genres g
LEFT JOIN songs s ON g.GenreID = s.GenreID
GROUP BY g.GenreName;
-- 4. Người dùng follow bao nhiêu nghệ sĩ
SELECT u.UserName, COUNT(DISTINCT af.ArtistID) AS TotalFollowedArtists
FROM users u
INNER JOIN artistfollow af ON u.UserID = af.UserID
GROUP BY u.UserID;
-- 5. các album được xuất bản sau năm 2015 và có tổng số bài hát lớn hơn 5
SELECT *
FROM album a
WHERE a.PublishedDate > '2015-01-01' AND (
    SELECT COUNT(s.SongID)
    FROM songs s
    WHERE s.AlbumID = a.AlbumID
) > 5;
-- 6. các nghệ sĩ có tổng số lượt theo dõi lớn hơn 2
SELECT a.ArtistName, COUNT(af.FollowID) AS FollowerCount
FROM artist a
INNER JOIN artistfollow af ON a.ArtistID = af.ArtistID
GROUP BY a.ArtistName
HAVING COUNT(af.FollowID) > 2;
-- 7. Điểm đánh giá cao nhất mà mỗi bài hát nhận được
SELECT s.SongName, MAX(r.Rating) AS HighestRating
FROM songs s
LEFT JOIN ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;
-- 8. Số lượng bài hát trong mỗi thể loại do từng nghệ sĩ tạo ra
SELECT a.ArtistName, g.GenreName, COUNT(s.SongID) AS TotalSongs
FROM artist a
LEFT JOIN album al on al.ArtistID = a.ArtistID
LEFT JOIN songs s ON al.AlbumID = s.AlbumID
LEFT JOIN genres g ON s.GenreID = g.GenreID
GROUP BY a.ArtistName, g.GenreName;
-- 9. Tổng điểm đánh giá của các bài hát trong mỗi album
SELECT al.AlbumName, SUM(r.Rating) AS TotalRating
FROM album al
LEFT JOIN songs s ON al.AlbumID = s.AlbumID
LEFT JOIN ratings r ON s.SongID = r.SongID
GROUP BY al.AlbumName;
-- 10. Điểm đánh giá trung bình của bài hát theo từng người dùng
SELECT u.UserName, AVG(r.Rating) AS AverageRating
FROM users u
LEFT JOIN ratings r ON u.UserID = r.UserID
GROUP BY u.UserName;
-- --------------------- Subquery trong FROM
-- 1. Tính số người dùng trung bình trên mỗi quốc gia (Subquery trong FROM)
SELECT Country, AVG(UserCount) AS AvgUsers
FROM (
    SELECT Users.Country, COUNT(Users.UserID) AS UserCount
    FROM Users
    GROUP BY Users.Country
) AS CountryUsers
GROUP BY Country;
-- 2.Tính tổng số bài hát theo từng thể loại âm nhạc
SELECT g.GenreName, SUM(subquery.TotalSongs) AS TotalSongs
FROM genres g
INNER JOIN (
    SELECT s.GenreID, COUNT(s.SongID) AS TotalSongs
    FROM songs s
    GROUP BY s.GenreID
) AS subquery ON g.GenreID = subquery.GenreID
GROUP BY g.GenreName;
-- 3. Tính số lượng người dùng đã đánh giá ít nhất một bài hát
SELECT COUNT(DISTINCT subquery.UserID) AS UsersWithRatings
FROM (
    SELECT r.UserID
    FROM ratings r
    GROUP BY r.UserID
) AS subquery;
-- 4. Tổng số lượng đg mỗi bài hát
SELECT s.SongName, COUNT(subquery.RatingID) AS TotalRatings
FROM songs s
INNER JOIN (
    SELECT r.RatingID, r.SongID
    FROM ratings r
) AS subquery ON s.SongID = subquery.SongID
GROUP BY s.SongName;
-- 5. Tính trung bình điểm đánh giá mỗi bài hát
SELECT s.SongName, AVG(subquery.Rating) AS AverageRating
FROM songs s
INNER JOIN (
    SELECT r.SongID, r.Rating
    FROM ratings r
) AS subquery ON s.SongID = subquery.SongID
GROUP BY s.SongName;
-- 6.Tổng thời lượng bài hát trong album
SELECT a.AlbumName, SUM(subquery.Duration) AS TotalDuration
FROM album a
INNER JOIN (
    SELECT s.AlbumID, s.Duration
    FROM songs s
) AS subquery ON a.AlbumID = subquery.AlbumID
GROUP BY a.AlbumName;
-- 7. nghệ sĩ cùng với số lượng bài hát trong thư viện
SELECT a.ArtistName, COUNT(s.SongID) AS SongCount
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON s.AlbumID = al.AlbumID
GROUP BY a.ArtistName
HAVING COUNT(s.SongID) > (
    SELECT AVG(song_count)
    FROM (
        SELECT COUNT(s.SongID) AS song_count
        FROM songs s
        INNER JOIN album al ON s.AlbumID = al.AlbumID
        GROUP BY al.ArtistID
    ) AS artist_song_counts
);
-- 8. Điểm đánh giá trung bình cao nhất của mỗi người dùng
SELECT UserName, MaxAvgRating
FROM (
    SELECT u.UserName, AVG(r.Rating) AS MaxAvgRating
    FROM users u
    LEFT JOIN ratings r ON u.UserID = r.UserID
    GROUP BY u.UserName
) AS UserRatings;
-- 9. Playlist chứa nhiều bài hát nhất
SELECT *
FROM (
    SELECT p.PlaylistName, COUNT(ps.SongID) AS TotalSongs
    FROM playlists p
    LEFT JOIN playlist_songs ps ON p.PlaylistID = ps.PlaylistID
    GROUP BY p.PlaylistName
) AS PlaylistCounts
ORDER BY TotalSongs DESC
LIMIT 1;
-- 10.playlist chứa đúng 7 bài hát
SELECT p.PlaylistID, p.PlaylistName, COUNT(ps.SongID) AS TotalSongs
FROM playlists p
JOIN playlist_songs ps ON p.PlaylistID = ps.PlaylistID
GROUP BY p.PlaylistID, p.PlaylistName
HAVING COUNT(ps.SongID) = 7;
---------------- Subquery trong WHERE
-- 1. Thông tin bài hát thuộc thể loại 'Pop'
SELECT SongName
FROM Songs
WHERE GenreID IN (SELECT GenreID FROM Genres WHERE GenreName = 'Pop');
-- 2. Danh sách bài hát của nghệ sĩ từ quốc gia 'USA'
SELECT SongName
FROM Songs
WHERE ArtistID IN (SELECT ArtistID FROM Artist WHERE Country = 'USA');
-- 3. Danh sách bài hát không thuộc playlist nào.
SELECT SongName
FROM songs
WHERE SongID NOT IN (
    SELECT SongID
    FROM playlist_songs
);
-- 4. Tìm các bài hát trong album có tổng số bài hát lớn hơn 10 và có số lượt đánh giá trung bình lớn hơn 4
SELECT a.AlbumName, s.SongName
FROM album a
JOIN songs s ON a.AlbumID = s.AlbumID
WHERE (
    SELECT COUNT(s2.SongID)
    FROM songs s2
    WHERE s2.AlbumID = a.AlbumID
) > 10
AND (
    SELECT AVG(r.Rating)
    FROM ratings r
    WHERE r.SongID = s.SongID
) > 4;
-- 5. Tìm các bài hát có số lượt đánh giá trung bình cao hơn 4
SELECT *
FROM songs s
WHERE (
    SELECT AVG(r.Rating)
    FROM ratings r
    WHERE r.SongID = s.SongID
) > 4;
-- 6. các bài hát thuộc album có ít hơn 8 bài hát
SELECT SongID, SongName 
FROM songs 
WHERE AlbumID IN (
    SELECT AlbumID 
    FROM album 
    WHERE NumberOfTracks < 8
);
-- 7. Tìm nghệ sĩ có ít nhất một bài hát thuộc thể loại "Rock"
SELECT ArtistID, ArtistName 
FROM artist 
WHERE ArtistID IN (
    SELECT ArtistID 
    FROM songs 
    WHERE GenreID = (SELECT GenreID FROM genres WHERE GenreName = 'Rock')
);
-- 8. Tìm người dùng chưa tạo bất kỳ playlist nào
SELECT UserID, UserName 
FROM users 
WHERE UserID NOT IN (
    SELECT UserID 
    FROM playlists
);
-- 9.các bài hát trong album có tên bắt đầu bằng 'A'
SELECT *
FROM songs
WHERE AlbumID IN (
    SELECT AlbumID
    FROM album
    WHERE AlbumName LIKE 'A%'
);
-- 10. các playlist chứa bài hát ít nhất 5 phút
SELECT *
FROM playlists
WHERE PlaylistID IN (
    SELECT PlaylistID
    FROM playlist_songs ps
    JOIN songs s ON ps.SongID = s.SongID
    WHERE s.Duration >= 300
);



















