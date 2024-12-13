USE Music;
-- ---------------------------------------------------
-- PHẦN 1: INNER JOIN
-- 1.Lấy danh sách các bài hát cùng với tên nghệ sĩ của chúng
SELECT s.SongName, a.ArtistName
FROM Songs s
INNER JOIN Album al ON s.AlbumID = al.AlbumID
INNER JOIN Artist a ON al.ArtistID = a.ArtistID;

-- 2. Thông tin bài hát cùng ngôn ngữ và thể loại 
SELECT Songs.SongName, Songs.Language, Genres.GenreName
FROM Songs
INNER JOIN Genres ON Songs.GenreID = Genres.GenreID;

-- 3.Tìm bài hát cụ thể trong từng Playlists
select p.PlaylistID, s.SongName from Playlists p
join Playlist_Songs ps on p.PlaylistID = ps.PlaylistID
join Songs s on ps.SongID = s.SongID;

-- 4. tìm những users không có Playlists nào
select u.UserID, u.UserName from Users u
where u.UserID not in (
select u2.UserID from Users u2
join Playlists p on u2.UserID = p.UserID);

-- 5. Liệt kê tên ca sĩ và followers của họ
select u.UserID, u.UserName, a.ArtistID, a.ArtistName from artistfollow ar
join Users u on ar.UserID = u.UserID
join Artist a on ar.ArtistID = a.ArtistID;

-- 6. Truy vấn danh sách album kèm tên bài hát sao cho ALbum đó có ít nhất 10 bài hát có Genre là 'Country'
SELECT Album.AlbumName,
	   Songs.SongName,
		Genres.GenreName
FROM Album 
JOIN Songs on Album.AlbumID= Songs.AlbumID
JOIN Genres on Songs.GenreID = Genres.GenreID
where Genres.GenreName = 'Country';

-- 7. Truy vấn danh sách người dùng đã đánh giá bài hát 'She'
SELECT u.UserName, 
       s.SongName, 
       r.Rating, 
       r.Review
FROM Users u
JOIN Ratings r ON u.UserID = r.UserID
JOIN Songs s ON r.SongID = s.SongID
WHERE s.SongName = 'She';

-- 8. Truy vấn danh sách thư viện của người dùng tên 'Davis' và tổng số bài hát trong từng thư viện
SELECT u.UserName, 
       lb.LibraryName, 
       COUNT(ls.SongID) AS TotalSongs
FROM Users u
JOIN Library lb ON u.UserID = lb.UserID
JOIN Library_Songs ls ON lb.LibraryID = ls.LibraryID
WHERE u.UserName like '%Davis%' 
GROUP BY u.UserName, lb.LibraryName;

-- 10. Truy vấn danh sách bài hát có trong thư viện của người dùng sống ở thành phố 'London'
SELECT u.UserName, 
       u.City, 
       s.SongName, 
       lb.LibraryName
FROM Users u
JOIN Library lb ON u.UserID = lb.UserID
JOIN Library_Songs ls ON lb.LibraryID = ls.LibraryID
JOIN Songs s ON ls.SongID = s.SongID
WHERE u.City = 'London';

-- 11. Truy vấn danh sách album có ít nhất 5 bài hát được xuất bản sau năm 2021
SELECT al.AlbumName, 
       a.ArtistName, 
       COUNT(s.SongID) AS TotalSongs
FROM Album al
JOIN Songs s ON al.AlbumID = s.AlbumID
JOIN Artist a ON al.ArtistID = a.ArtistID
WHERE s.PublishedDate > '2021-01-01'
GROUP BY al.AlbumID, al.AlbumName, a.ArtistName
HAVING COUNT(s.SongID) >= 5;

-- 12.Thể loại ở USA có rating cao nhất
SELECT g.GenreName, AVG(r.Rating) AS AvgRating
FROM genres g
INNER JOIN songs s ON g.GenreID = s.GenreID
INNER JOIN ratings r ON s.SongID = r.SongID
INNER JOIN users u ON r.UserID = u.UserID
WHERE u.Country = 'USA' -- Thay bằng quốc gia bạn muốn
GROUP BY g.GenreName
ORDER BY AvgRating DESC
LIMIT 1;

-- 13. Danh sách nghệ sĩ có bài hát thuộc album phát hành gần đây nhất nhưng chưa được đánh giá
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

  -- 14. Thống kê số lượng bài hát của mỗi nghệ sĩ được đánh giá trung bình trên 4 theo từng năm phát hành
SELECT a.ArtistName, YEAR(s.PublishedDate) AS ReleaseYear, COUNT(s.SongID) AS TotalHighRatedSongs
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON al.AlbumID = s.AlbumID
INNER JOIN ratings r ON s.SongID = r.SongID
GROUP BY a.ArtistID, YEAR(s.PublishedDate)
HAVING AVG(r.Rating) > 4
ORDER BY ReleaseYear ASC, TotalHighRatedSongs DESC;

-- 15. các nghệ sĩ có bài hát với tổng thời lượng lớn hơn 500 phút
SELECT a.ArtistName, SUM(s.Duration) AS TotalDuration
FROM artist a
INNER JOIN album al ON a.ArtistID = al.ArtistID
INNER JOIN songs s ON al.AlbumID = s.AlbumID
GROUP BY a.ArtistName
HAVING SUM(s.Duration) > 500;

-- ---------------------------------------- 
-- PHẦN 2: OUTER JOIN
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

-- --------------------------------------------------------------
-- PHẦN 3: SUBQUERY IN WHERE
-- 1. Tìm các nghệ sĩ có ít nhất một bài hát được đánh giá 
select ArtistName from Artist
where ArtistID in (
select al.ArtistID from Album al
left join songs s on al.AlbumID = s.AlbumID
left join Ratings r on s.SongID = r.SongID);
 
-- 2.Tìm các bài hát không thuộc thể loại nào đang phổ biến (có trên 50 bài hát)
SELECT SongName
FROM Songs
WHERE GenreID NOT IN (
    SELECT GenreID
    FROM Songs
    GROUP BY GenreID
    HAVING COUNT(SongID) > 50
);

-- 3. Tìm các playlist chỉ chứa bài hát có ngôn ngữ là tiếng Anh
select PlaylistName from Playlists
where PlaylistID not in (
select PlaylistID from Playlist_Songs ps
join songs s on ps.SongID = s.SongID
where s.Language != 'English');

-- 4.Tìm nghệ sĩ có bài hát lâu đời nhất
select ArtistName from Artist
where ArtistID = (
select al.ArtistID from songs s
join Album al on s.AlbumID = al.AlbumID
order by s.PublishedDate ASC
limit 1);

-- 5.Tìm người dùng chỉ theo dõi nghệ sĩ từ một quốc gia duy nhất
SELECT UserName
FROM Users
WHERE UserID IN (
    SELECT af.UserID
    FROM ArtistFollow af
    JOIN Artist a ON af.ArtistID = a.ArtistID
    GROUP BY af.UserID
    HAVING COUNT(DISTINCT a.Country) = 1
);

-- 6.Tìm tất cả nghệ sĩ có songs nằm trong thể loại "Rock"
select ArtistName from Artist
where ArtistID in (
select al.ArtistID from Album al
join songs s on al.AlbumID = s.AlbumID
join Genres g on s.GenreID = g.GenreID
where g.GenreName = 'Rock');

-- 7.Tìm các bài hát có tổng điểm đánh giá thấp hơn điểm trung bình của tất cả các bài hát
select SongName from Songs
where SongID in (select SongID from Ratings
    group by SongID
    having sum(Rating) < (select avg(sum_Rating) from (
            select sum(Rating) as sum_Rating from Ratings
            group by SongID) as Sub
    )
);

-- 8.Tìm người dùng đã từng đánh giá bài hát thuộc thể loại "Pop"
select UserName from Users
where exists(select s.SongID from Songs s
join Genres g on s.GenreID = g.GenreID
where g.GenreName = 'Pop' and s.SongID in (
select r.SongID from Ratings r
where r.UserID = Users.UserID)); 


-- 9.Truy vấn danh sách người dùng đã từng đánh giá ít nhất một bài hát của thể loại 'Rock'
SELECT u.UserName
FROM Users u
WHERE u.UserID IN (
    SELECT r.UserID
    FROM Ratings r
    JOIN Songs s ON r.SongID = s.SongID
    JOIN Genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = 'Rock'
);

-- 10.Truy vấn tên bài hát mà người dùng có chứa 'Davis' đã đánh giá 2 sao
SELECT s.SongName
FROM Songs s
WHERE s.SongID IN (
    SELECT r.SongID
    FROM Ratings r
    JOIN Users u ON r.UserID = u.UserID
    WHERE u.UserName like '%Davis%' AND r.Rating =2 
);

-- 11.Truy vấn danh sách các nghệ sĩ có bài hát được đánh giá cao nhất và được ít nhất 3 người dùng yêu thích (theo số lượng đánh giá 5 sao).
SELECT a.ArtistName
FROM Artist a
WHERE a.ArtistID IN (
    SELECT al.ArtistID
    FROM Album al
    JOIN songs s on al.AlbumID = s.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = 5
    GROUP BY al.ArtistID
    HAVING COUNT(DISTINCT r.UserID) >= 3
);

-- 12. Truy vấn danh sách tên bài hát thuộc thể loại có ít nhất 1 bài hát trong Album 'Evolve'.
  select s.SongName,
		g.GenreName
	from Songs s 
    join Genres g on g.GenreID = s.GenreID
    where s.SongID IN ( Select s.SongID from Songs s
    join Album al on s.AlbumID = al.AlbumID
    where al.AlbumName = 'Evolve');
    
--  13. Truy vấn danh sách thư viện có chứa bài hát của nghệ sĩ đến từ quốc gia 'Canada'.
   select lb.LibraryName,
		s.SongName
		from Library lb join Library_songs ls on ls.LibraryID = lb.LibraryID
        join songs s on s.SongID = ls.SongID
        where s.SongID in 
        (select s.SongID from songs 
        join album a on a.AlbumID = s.AlbumID
        join artist art on art.ArtistID = a.ArtistID
        where art.Country = 'Canada');
        
-- 14. Truy vấn tên nghệ sĩ có bài hát được đánh giá thấp nhất trong hệ thống (dựa trên cột Rating).
SELECT a.ArtistName
FROM Artist a
WHERE a.ArtistID IN (
    SELECT al.ArtistID
    FROM Album al join Songs s on s.AlbumID = al.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = (
        SELECT MIN(r_sub.Rating)
        FROM Ratings r_sub
    ));

-- 15.các bài hát trong album có tên bắt đầu bằng 'A'
SELECT *
FROM songs
WHERE AlbumID IN (
    SELECT AlbumID
    FROM album
    WHERE AlbumName LIKE 'A%'
);

