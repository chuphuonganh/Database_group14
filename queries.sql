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
-- ---------------------------------------------------------------------
-- PHẦN 4: SUBQUERY IN FROM
-- 1.Tìm người dùng có tổng số bài hát trong thư viện lớn nhất
with temp as(
select sum(l.TotalSongs) as TotalSongs, l.UserID, u.UserName from Library l
join Users u on l.UserID = u.UserID 
group by u.UserID, u.UserName) 
select TotalSongs, UserID, UserName from temp
where TotalSongs = (select max(TotalSongs) from temp);

-- 2. Tính số người dùng trung bình trên mỗi quốc gia 
SELECT Country, AVG(UserCount) AS AvgUsers
FROM (
    SELECT Users.Country, COUNT(Users.UserID) AS UserCount
    FROM Users
    GROUP BY Users.Country
) AS CountryUsers
GROUP BY Country;

-- 3. Tổng số lượng đánh giá mỗi bài hát
SELECT s.SongName, COUNT(subquery.RatingID) AS TotalTurnsRatings
FROM songs s
INNER JOIN (
    SELECT r.RatingID, r.SongID
    FROM ratings r
) AS subquery ON s.SongID = subquery.SongID
GROUP BY s.SongName;

-- 4.Tổng thời lượng bài hát trong album
SELECT a.AlbumName, SUM(subquery.Duration) AS TotalDuration
FROM album a
INNER JOIN (
    SELECT s.AlbumID, s.Duration
    FROM songs s
) AS subquery ON a.AlbumID = subquery.AlbumID
GROUP BY a.AlbumName;

-- 5. nghệ sĩ cùng với số lượng bài hát trong thư viện
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

-- 6. Playlist chứa nhiều bài hát nhất
SELECT *
FROM (
    SELECT p.PlaylistName, COUNT(ps.SongID) AS TotalSongs
    FROM playlists p
    LEFT JOIN playlist_songs ps ON p.PlaylistID = ps.PlaylistID
    GROUP BY p.PlaylistName
) AS PlaylistCounts
ORDER BY TotalSongs DESC
LIMIT 1;

-- 7. Truy vấn danh sách tên bài hát và tên nghệ sĩ cho các bài hát 
-- có ít nhất một đánh giá lớn hơn 3 sao từ người dùng ở 'Milan', 'Italy'
SELECT song_with_ratings.SongName, song_with_ratings.ArtistName
FROM (
    SELECT s.SongName, a.ArtistName, r.Rating
    FROM Songs s
    JOIN Album al ON al.AlbumID = s.AlbumID
    JOIN Artist a ON al.ArtistID = a.ArtistID
    JOIN Ratings r ON s.SongID = r.SongID
    JOIN Users u ON r.UserID = u.UserID
    WHERE u.City = 'Milan' AND r.Rating >= 3 and u.Country = 'Italy'
) AS song_with_ratings;

-- 8.Truy vấn danh sách người dùng đã thêm ít nhất 5 bài hát vào thư viện của mình
SELECT user_with_library.UserName
FROM (
    SELECT u.UserName, COUNT(ls.SongID) AS SongCount
    FROM Users u
    JOIN Library l ON u.UserID = l.UserID
    JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
    GROUP BY u.UserName
) AS user_with_library
WHERE user_with_library.SongCount >= 5;

-- 9. Truy vấn danh sách tên bài hát và album của bài hát có đánh giá cao nhất (5 sao)
SELECT song_with_ratings.SongName, song_with_ratings.AlbumName
FROM (
    SELECT s.SongName, a.AlbumName, r.Rating
    FROM Songs s
    JOIN Album a ON s.AlbumID = a.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = 5
) AS song_with_ratings;

-- 10. Truy vấn danh sách bài hát trong album '25' 
-- được đánh giá 5 sao trở lên
SELECT song_with_ratings.SongName, song_with_ratings.Rating
FROM (
    SELECT s.SongName, r.Rating
    FROM Songs s
    JOIN Album a ON s.AlbumID = a.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE a.AlbumName = '25' AND r.Rating >= 5
) AS song_with_ratings;

-- 11.Truy vấn tên người dùng và số lượng bài hát thuộc thể loại 'Jazz' trong thư viện của họ
SELECT DISTINCT user_library.UserName, user_library.JazzSongCount
FROM (
    SELECT u.UserName, COUNT(ls.SongID) AS JazzSongCount
    FROM Users u
    JOIN Library l ON u.UserID = l.UserID
    JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
    JOIN Songs s ON ls.SongID = s.SongID
    JOIN Genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = 'Jazz'
    GROUP BY u.UserName
) AS user_library;

-- 12. Truy vấn danh sách các nghệ sĩ mà có ít nhất 2 bài hát được đánh giá 5 sao
SELECT artist_with_ratings.ArtistName
FROM (
    SELECT a.ArtistName, COUNT(DISTINCT r.SongID) AS SongCount
    FROM Artist a
    JOIN Album al ON al.ArtistID = a.ArtistID
    JOIN Songs s ON s.AlbumID = al.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = 5
    GROUP BY a.ArtistName
) AS artist_with_ratings
WHERE artist_with_ratings.SongCount >= 2;

-- 13. Truy vấn danh sách người dùng có bài hát yêu thích thuộc thể loại 'Pop' nhưng chưa theo dõi nghệ sĩ nào
SELECT DISTINCT u.UserName
FROM (
    SELECT u.UserID
    FROM Users u
    JOIN Library l ON u.UserID = l.UserID
    JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
    JOIN Songs s ON ls.SongID = s.SongID
    JOIN Genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = 'Pop'
) AS user_with_pop_songs
LEFT JOIN ArtistFollow af ON user_with_pop_songs.UserID = af.UserID
LEFT JOIN Users u ON u.UserID = user_with_pop_songs.UserID
WHERE af.ArtistID IS NULL;

-- 14.Truy vấn danh sách bài hát có ít nhất một bài hát đã 
-- được người dùng ở UK thêm vào thư viện
SELECT song_with_user.SongName
FROM (
    SELECT s.SongName, ls.LibraryID
    FROM Songs s
    JOIN Library_Songs ls ON s.SongID = ls.SongID
    JOIN Library l ON ls.LibraryID = l.LibraryID
    JOIN Users u ON l.UserID = u.UserID
    WHERE u.Country = 'UK'
) AS song_with_user;

-- 15.Tìm thể loại có số lượng bài hát nhiều nhất theo từng ngôn ngữ
SELECT Language, GenreName, TotalSongs
FROM (
    SELECT s.Language, g.GenreName, COUNT(s.SongID) AS TotalSongs,
           RANK() OVER (PARTITION BY s.Language ORDER BY COUNT(s.SongID) DESC) AS rnk
    FROM Songs s
    JOIN Genres g ON s.GenreID = g.GenreID
    GROUP BY s.Language, g.GenreName
) AS GenreLanguageStats
WHERE rnk = 1;

-- -----------------------------------------
-- PHẦN 5: Query using group by and aggregate functions

-- 1 Tổng bài hát, tổng album và tổng ArtistID
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

-- 3. Người dùng follow bao nhiêu nghệ sĩ
SELECT u.UserName, COUNT(DISTINCT af.ArtistID) AS TotalFollowedArtists
FROM users u
LEFT JOIN artistfollow af ON u.UserID = af.UserID
GROUP BY u.UserID;

-- 4. các album được xuất bản sau năm 2015 và có tổng số bài hát lớn hơn 5
SELECT *
FROM album a
WHERE a.PublishedDate > '2015-01-01' AND (
    SELECT COUNT(s.SongID)
    FROM songs s
    WHERE s.AlbumID = a.AlbumID
) > 5;

-- 6. Điểm đánh giá cao nhất mà mỗi bài hát nhận được
SELECT s.SongName, MAX(r.Rating) AS HighestRating
FROM songs s
LEFT JOIN ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;

-- 7. Số lượng bài hát trong mỗi thể loại do từng nghệ sĩ tạo ra
SELECT a.ArtistName, g.GenreName, COUNT(s.SongID) AS TotalSongs
FROM artist a
LEFT JOIN album al on al.ArtistID = a.ArtistID
LEFT JOIN songs s ON al.AlbumID = s.AlbumID
LEFT JOIN genres g ON s.GenreID = g.GenreID
GROUP BY a.ArtistName, g.GenreName;

-- 8.Truy vấn bài hát có đánh giá cao nhất trong mỗi album
	SELECT s.AlbumID, s.SongName, MAX(r.Rating) AS MaxRating
	FROM Songs s
	JOIN Ratings r ON s.SongID = r.SongID
	GROUP BY s.AlbumID, s.SongName;
    
-- 8.Truy vấn các thể loại nhạc được theo dõi nhiều nhất
	SELECT g.GenreName, COUNT(af.UserID) AS FollowCount
	FROM Genres g
	JOIN Songs s ON g.GenreID = s.GenreID
    JOIN Album al on al.AlbumID = s.AlbumID
    JOIN Artist art on art.ArtistID = al.ArtistID
	JOIN ArtistFollow af ON art.ArtistID = af.ArtistID
	GROUP BY g.GenreName
	ORDER BY FollowCount DESC;
    
-- 9. Đếm số lượng Type Shared của tất cả User có Country = "USA"
select count(Type) from 
(select l.Type from Library l
join Users u on l.UserID = u.UserID
where u.Country = 'USA') as temp
group by Type
having Type = 'Shared';

-- 10.Tìm nghệ sĩ có tổng số bài hát lớn nhất trong mỗi quốc gia
select max(total) as totalSong from
(select a.ArtistName, count(s.SongID) as total from Artist a
join Album al on a.ArtistID = al.ArtistID
join songs s on al.AlbumID = s.SongID
group by a.Country, a.ArtistName) as temp ;

-- 11.Tìm bài hát có đánh giá trung bình cao nhất trong mỗi ngôn ngữ
with temp as (
select s.SongName,s.language, avg(Rating) as averageRating  from Ratings r
join songs s on r.SongID  = s.SongID
 group by s.SongName, s.SongID)
 select averageRating, SongName, language from temp
 where (averageRating, language) in (select min(averageRating), language from temp 
 group by language);

-- 12.Tìm năm phát hành có tổng số bài hát lớn nhất 
with temp as (select count(SongID) as totalSongs, year(publishedDate) as year from songs
group by year(publishedDate))
select totalSongs, year from temp
where totalSongs = (select max(totalSongs) from temp);

