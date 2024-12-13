USE Music;
-- 1.Liệt kê tên nghệ sĩ và số lượng Album bao gồm cả những người không có Album nào
select a.ArtistName, a.ArtistID, count(al.AlbumID) as NumberOfAlbums from Artist a
left join Album al on a.ArtistID = al.ArtistID
group by a.ArtistName, a.ArtistID;

-- 2.Liệt kê tất cả Users và số lượng Library họ đã tạo bao gồm cả những người không có Library nào
select u.UserName, u.UserID, count(l.UserID) as NumberOfLibrarys from Users u
left join Library l on u.UserID = l.UserID
group by u.UserName, u.UserID;

-- 3. Danh sách tất cả bài hát và đánh giá cao nhất của chúng (bao gồm cả bài hát chưa được đánh giá) 
SELECT s.SongName, MAX(r.Rating) AS MaxRating
FROM Songs s
LEFT OUTER JOIN Ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;

-- 4. Danh sách tất cả các playlist và điểm đánh giá trung bình của các bài hát trong playlist đó 
SELECT p.PlaylistName, COALESCE(AVG(r.Rating), 0) AS AverageRating
FROM playlists p
LEFT OUTER JOIN playlist_songs ps ON p.PlaylistID = ps.PlaylistID
LEFT OUTER JOIN ratings r ON ps.SongID = r.SongID
GROUP BY p.PlaylistName;

-- 5.Tìm nghệ sĩ không có bài hát nào được người dùng PREMIUM đánh giá
select a.ArtistName, count(r.SongID) as NumberSongs, count(u.Member) as NumberMembersP from Artist a
left join Album al on a.ArtistID = al.ArtistID
left join songs s on al.AlbumID = s.AlbumID
left join Ratings r on s.SongID = r.SongID
left join Users u on r.UserID = u.UserID and u.Member = 'PREMIUM'
group by a.ArtistName
having count(r.SongID) = 0 or count(u.Member) = 0; 

-- 6. Truy vấn tất cả người dùng và nghệ sĩ mà họ theo dõi, bao gồm cả người dùng chưa theo dõi nghệ sĩ nào
SELECT u.UserName, 
       a.ArtistName
FROM Users u
LEFT JOIN ArtistFollow af ON u.UserID = af.UserID
LEFT JOIN Artist a ON af.ArtistID = a.ArtistID;

-- 7. Truy vấn tất cả bài hát và đánh giá của chúng, bao gồm cả bài hát chưa được đánh giá
SELECT s.SongName, 
       r.Rating, 
       r.Review
FROM Songs s
LEFT JOIN Ratings r ON s.SongID = r.SongID;

-- 8. Truy vấn danh sách người dùng và các playlist họ tạo, bao gồm cả người dùng không tạo playlist nào
SELECT u.UserName, 
       p.PlaylistName
FROM Users u
LEFT JOIN Playlists p ON u.UserID = p.UserID;

-- 9. Truy vấn danh sách thể loại và bài hát thuộc thể loại đó, bao gồm cả thể loại không có bài hát nào
SELECT g.GenreName, 
       s.SongName
FROM Genres g
LEFT JOIN Songs s ON g.GenreID = s.GenreID;

-- 10. Truy vấn tất cả nghệ sĩ và người dùng theo dõi họ, bao gồm cả nghệ sĩ không có người theo dõi
SELECT a.ArtistName, 
       u.UserName
FROM Artist a
LEFT JOIN ArtistFollow af ON a.ArtistID = af.ArtistID
LEFT JOIN Users u ON af.UserID = u.UserID;


-- 11. Danh sách tất cả các nghệ sĩ cùng số lượng bài hát đã phát hành (kể cả nghệ sĩ chưa có bài hát).
SELECT a.ArtistName, COUNT(s.SongID) AS SongCount
FROM artist a
LEFT OUTER JOIN album ab ON ab.ArtistID = a.ArtistID
left outer join songs s on s.albumID = ab.albumID
GROUP BY a.ArtistName;

-- 12. Danh sách thể loại có số bài hát ít nhất kèm tổng điểm đánh giá của các bài hát thuộc thể loại đó.
SELECT g.GenreName, COUNT(s.SongID) AS TotalSongs, COALESCE(SUM(r.Rating), 0) AS TotalRating
FROM genres g
LEFT OUTER JOIN songs s ON g.GenreID = s.GenreID
LEFT OUTER JOIN ratings r ON s.SongID = r.SongID
GROUP BY g.GenreName
HAVING COUNT(s.SongID) <= 5;

-- 13. Danh sách tất cả bài hát và số lượt đánh giá của chúng (bao gồm bài hát chưa được đánh giá).

SELECT s.SongName, COUNT(r.RatingID) AS TotalRatings
FROM songs s
LEFT OUTER JOIN ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;

-- 14. tất cả bài hát và tổng số người dùng đã thêm bài hát đó vào thư viện
SELECT s.SongName, COUNT(l.UserID) AS TotalUsers
FROM songs s
LEFT OUTER JOIN library_songs ls ON s.SongID = ls.SongID
LEFT OUTER JOIN Library l on l.libraryID = ls.libraryID 
GROUP BY s.SongID, s.SongName;

