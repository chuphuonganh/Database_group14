use music;
-- Phần 1: InnerJoin
-- 	1. Truy vấn danh sách album kèm tên bài hát sao cho ALbum đó có ít nhất 10 bài hát có Genre là 'Country'
		SELECT Album.AlbumName,
				Songs.SongName,
                Genres.GenreName
        FROM Album 
        JOIN Songs on Album.AlbumID= Songs.AlbumID
        JOIN Genres on Songs.GenreID = Genres.GenreID
		where Genres.GenreName = 'Country';
        
	--  2.Truy vấn tên người sử dụng có bài hát 'Baby' library;--
		Select u.UserName,
				s.SongName
		from Users u
        join Library lb on lb.UserID = u.UserID
        join library_songs ls on ls.LibraryID = lb.LibraryID
        join songs s on s.SongID = ls.SongID;
        
      --   3. Truy vấn tìm ra danh sách các Artist có người theo dõi là ở 'Chicago'
      select a.ArtistName,
			u.UserName, u.City
		from Artist a
        join ArtistFollow af on af.ArtistID = a.ArtistID
        join Users u on u.UserID = af.UserID
        where u.City = 'Chicago';
        
        -- 4. Truy vấn danh sách bài hát và thể loại do nghệ sĩ có tên 'Taylor Swift' sáng tác
SELECT s.SongName, 
       g.GenreName, 
       a.ArtistName
FROM Songs s
JOIN Genres g ON s.GenreID = g.GenreID
JOIN Album al ON s.AlbumID = al.AlbumID
JOIN Artist a ON al.ArtistID = a.ArtistID
WHERE a.ArtistName = 'Taylor Swift';

-- 5. Truy vấn tìm các Playlist có chứa bài hát tên 'Babylon'
SELECT p.PlaylistName, 
       s.SongName
FROM Playlists p
JOIN Playlist_Songs ps ON p.PlaylistID = ps.PlaylistID
JOIN Songs s ON ps.SongID = s.SongID
WHERE s.SongName = 'Babylon';

-- 6. Truy vấn danh sách người dùng đã đánh giá bài hát 'Paparazzi'
SELECT u.UserName, 
       s.SongName, 
       r.Rating, 
       r.Review
FROM Users u
JOIN Ratings r ON u.UserID = r.UserID
JOIN Songs s ON r.SongID = s.SongID
WHERE s.SongName = 'I Don’t Know Why';

-- 7. Truy vấn danh sách thư viện của người dùng tên 'John' và tổng số bài hát trong từng thư viện
SELECT u.UserName, 
       lb.LibraryName, 
       COUNT(ls.SongID) AS TotalSongs
FROM Users u
JOIN Library lb ON u.UserID = lb.UserID
JOIN Library_Songs ls ON lb.LibraryID = ls.LibraryID
WHERE u.UserName like '%John%' 
GROUP BY u.UserName, lb.LibraryName;

-- 8. Truy vấn danh sách các nghệ sĩ có album phát hành trong năm 2020 và thuộc thể loại 'Pop'
SELECT a.ArtistName, 
       al.AlbumName, 
       g.GenreName
FROM Artist a
JOIN Album al ON a.ArtistID = al.ArtistID
JOIN Songs s ON al.AlbumID = s.AlbumID
JOIN Genres g ON s.GenreID = g.GenreID
WHERE g.GenreName = 'Pop' AND YEAR(al.PublishedDate) = 2020;

-- 9. Truy vấn danh sách bài hát có trong thư viện của người dùng sống ở thành phố 'New York'
SELECT u.UserName, 
       u.City, 
       s.SongName, 
       lb.LibraryName
FROM Users u
JOIN Library lb ON u.UserID = lb.UserID
JOIN Library_Songs ls ON lb.LibraryID = ls.LibraryID
JOIN Songs s ON ls.SongID = s.SongID
WHERE u.City = 'New York';

-- 10. Truy vấn danh sách album có ít nhất 5 bài hát được xuất bản sau năm 2021
SELECT al.AlbumName, 
       a.ArtistName, 
       COUNT(s.SongID) AS TotalSongs
FROM Album al
JOIN Songs s ON al.AlbumID = s.AlbumID
JOIN Artist a ON al.ArtistID = a.ArtistID
WHERE s.PublishedDate > '2021-01-01'
GROUP BY al.AlbumID, al.AlbumName, a.ArtistName
HAVING COUNT(s.SongID) >= 5;

-- Phần 2: Outer Join
		-- 1. Truy vấn tất cả nghệ sĩ và album của họ, bao gồm cả nghệ sĩ chưa có album
SELECT a.ArtistName, 
       al.AlbumName
FROM Artist a
LEFT JOIN Album al ON a.ArtistID = al.ArtistID;

-- 2. Truy vấn tất cả bài hát và đánh giá của chúng, bao gồm cả bài hát chưa được đánh giá
SELECT s.SongName, 
       r.Rating, 
       r.Review
FROM Songs s
LEFT JOIN Ratings r ON s.SongID = r.SongID;

-- 3. Truy vấn danh sách người dùng và bài hát trong thư viện của họ, bao gồm cả người dùng không có bài hát nào
SELECT u.UserName, 
       lb.LibraryName, 
       s.SongName
FROM Users u
LEFT JOIN Library lb ON u.UserID = lb.UserID
LEFT JOIN Library_Songs ls ON lb.LibraryID = ls.LibraryID
LEFT JOIN Songs s ON ls.SongID = s.SongID;

-- 4. Truy vấn danh sách bài hát và các playlist chứa chúng, bao gồm cả bài hát không nằm trong playlist nào
SELECT s.SongName, 
       p.PlaylistName
FROM Songs s
LEFT JOIN Playlist_Songs ps ON s.SongID = ps.SongID
LEFT JOIN Playlists p ON ps.PlaylistID = p.PlaylistID;

-- 5. Truy vấn danh sách album và các thể loại bài hát trong album đó, bao gồm cả album không có bài hát nào
SELECT al.AlbumName, 
       g.GenreName
FROM Album al
LEFT JOIN Songs s ON al.AlbumID = s.AlbumID
LEFT JOIN Genres g ON s.GenreID = g.GenreID

-- 6. Truy vấn tất cả người dùng và nghệ sĩ mà họ theo dõi, bao gồm cả người dùng chưa theo dõi nghệ sĩ nào
SELECT u.UserName, 
       a.ArtistName
FROM Users u
LEFT JOIN ArtistFollow af ON u.UserID = af.UserID
LEFT JOIN Artist a ON af.ArtistID = a.ArtistID;

-- 7. Truy vấn tất cả nghệ sĩ và người dùng theo dõi họ, bao gồm cả nghệ sĩ không có người theo dõi
SELECT a.ArtistName, 
       u.UserName
FROM Artist a
LEFT JOIN ArtistFollow af ON a.ArtistID = af.ArtistID
LEFT JOIN Users u ON af.UserID = u.UserID;

-- 8. Truy vấn danh sách bài hát và thư viện có chứa chúng, bao gồm cả bài hát không nằm trong thư viện nào
SELECT s.SongName, 
       lb.LibraryName
FROM Songs s
LEFT JOIN Library_Songs ls ON s.SongID = ls.SongID
LEFT JOIN Library lb ON ls.LibraryID = lb.LibraryID;

-- 9. Truy vấn danh sách thể loại và bài hát thuộc thể loại đó, bao gồm cả thể loại không có bài hát nào
SELECT g.GenreName, 
       s.SongName
FROM Genres g
LEFT JOIN Songs s ON g.GenreID = s.GenreID;

-- 10. Truy vấn danh sách người dùng và các playlist họ tạo, bao gồm cả người dùng không tạo playlist nào
SELECT u.UserName, 
       p.PlaylistName
FROM Users u
LEFT JOIN Playlists p ON u.UserID = p.UserID;

-- Phần 3: Subquery in where
-- 1. Truy vấn 1 bài hát thuộc thể loại mà người dùng ở USA đánh giá 5 sao
	SELECT s.SongName
FROM Songs s
JOIN Ratings r ON r.SongID = s.SongID
WHERE r.RatingID IN (
    SELECT r_sub.RatingID
    FROM Ratings r_sub
    JOIN Users u ON u.UserID = r_sub.UserID
    WHERE u.Country  = 'USA' AND r_sub.Rating = 5
);
-- 2. Truy vấn danh sách các bài hát có trong thư viện của người dùng đến từ thành phố 'New York'.
SELECT s.SongName, 
       s.Duration
FROM Songs s
WHERE s.SongID IN (
    SELECT ls.SongID
    FROM Library_Songs ls
    JOIN Library l ON ls.LibraryID = l.LibraryID
    JOIN Users u ON l.UserID = u.UserID
    WHERE u.City = 'New York'
);

-- 3. Truy vấn danh sách tên bài hát thuộc thể loại có ít nhất 1 bài hát trong Album 'Evolve'.

  select s.SongName,
		g.GenreName
	from Songs s 
    join Genres g on g.GenreID = s.GenreID
    where s.SongID IN ( Select s.SongID from Songs s
    join Album al on s.AlbumID = al.AlbumID
    where al.AlbumName = 'Evolve');
    
   --  4. Truy vấn danh sách thư viện có chứa bài hát của nghệ sĩ đến từ quốc gia 'Canada'.
   select lb.LibraryName,
		s.SongName
		from Library lb join Library_songs ls on ls.LibraryID = lb.LibraryID
        join songs s on s.SongID = ls.SongID
        where s.SongID in 
        (select s.SongID from songs 
        join album a on a.AlbumID = s.AlbumID
        join artist art on art.ArtistID = a.ArtistID
        where art.Country = 'Canada');
        
-- 5.Truy vấn danh sách người dùng đã thêm ít nhất 5 bài hát của thể loại 'Pop' vào thư viện của họ.
	SELECT u.UserName
FROM Users u
WHERE u.UserID IN (
    SELECT l.UserID
    FROM Library l
    JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
    JOIN Songs s ON ls.SongID = s.SongID
    JOIN Genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = 'Pop'
    GROUP BY l.UserID
    HAVING COUNT(s.SongID) >= 5
);

-- 6. Truy vấn tên nghệ sĩ có bài hát được đánh giá thấp nhất trong hệ thống (dựa trên cột Rating).
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

-- 7.Truy vấn danh sách bài hát chưa từng được thêm vào bất kỳ playlist nào.
SELECT s.SongName
FROM Songs s
WHERE s.SongID NOT IN (
    SELECT ps.SongID
    FROM Playlist_Songs ps
);

-- 8.Truy vấn danh sách người dùng đã từng đánh giá ít nhất một bài hát của thể loại 'Rock'
SELECT u.UserName
FROM Users u
WHERE u.UserID IN (
    SELECT r.UserID
    FROM Ratings r
    JOIN Songs s ON r.SongID = s.SongID
    JOIN Genres g ON s.GenreID = g.GenreID
    WHERE g.GenreName = 'Rock'
);

-- 9.Truy vấn tên bài hát mà người dùng 'Alex' đã đánh giá 5 sao
SELECT s.SongName
FROM Songs s
WHERE s.SongID IN (
    SELECT r.SongID
    FROM Ratings r
    JOIN Users u ON r.UserID = u.UserID
    WHERE u.City = 'San Francisco' AND r.Rating = 5
);

-- 10.Truy vấn danh sách các nghệ sĩ có bài hát được đánh giá cao nhất và được ít nhất 5 người dùng yêu thích (theo số lượng đánh giá 5 sao).
SELECT a.ArtistName
FROM Artist a
WHERE a.ArtistID IN (
    SELECT al.ArtistID
    FROM Album al
    JOIN songs s on al.AlbumID = s.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = 5
    GROUP BY al.ArtistID
    HAVING COUNT(DISTINCT r.UserID) >= 5
);

-- Phần 4: Subquery in from 
-- 1. Truy vấn danh sách tên bài hát và tên nghệ sĩ cho các bài hát có ít nhất một đánh giá lớn hơn 3 sao từ người dùng ở 'Milan', 'Italy'
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

-- 2.Truy vấn danh sách người dùng đã thêm ít nhất 5 bài hát vào thư viện của mình

SELECT user_with_library.UserName
FROM (
    SELECT u.UserName, COUNT(ls.SongID) AS SongCount
    FROM Users u
    JOIN Library l ON u.UserID = l.UserID
    JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
    GROUP BY u.UserName
) AS user_with_library
WHERE user_with_library.SongCount >= 5;

-- 3.Truy vấn danh sách bài hát dưới 180s mà người dùng "Maria" chưa đánh giá
SELECT s.SongName
FROM Songs s
WHERE s.SongID NOT IN (
    SELECT r.SongID
    FROM Ratings r
    JOIN Users u ON r.UserID = u.UserID
    WHERE u.UserName = 'Maria'
) and s.Duration < 180;

-- 4. Truy vấn danh sách tên bài hát và album của bài hát có đánh giá cao nhất (5 sao)
SELECT song_with_ratings.SongName, song_with_ratings.AlbumName
FROM (
    SELECT s.SongName, a.AlbumName, r.Rating
    FROM Songs s
    JOIN Album a ON s.AlbumID = a.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE r.Rating = 5
) AS song_with_ratings;

-- 5.-- Truy vấn danh sách bài hát trong album 'Starboy' được đánh giá 4 sao trở lên
SELECT song_with_ratings.SongName, song_with_ratings.Rating
FROM (
    SELECT s.SongName, r.Rating
    FROM Songs s
    JOIN Album a ON s.AlbumID = a.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    WHERE a.AlbumName = 'Starboy' AND r.Rating >= 4
) AS song_with_ratings;

-- 6.Truy vấn tên người dùng và số lượng bài hát thuộc thể loại 'Jazz' trong thư viện của họ
SELECT user_library.UserName, user_library.JazzSongCount
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

-- 7. Truy vấn danh sách các nghệ sĩ mà có ít nhất 2 bài hát được đánh giá 5 sao
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

-- 8. Truy vấn danh sách người dùng có bài hát yêu thích thuộc thể loại 'Pop' nhưng chưa theo dõi nghệ sĩ nào
SELECT u.UserName
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

-- 9. Truy vấn danh sách các nghệ sĩ có ít nhất một bài hát trong album có số lượng đánh giá trung bình thấp hơn 3
SELECT artist_with_album.ArtistName
FROM (
    SELECT a.ArtistName, s.AlbumID
   FROM Artist a
    JOIN Album al ON al.ArtistID = a.ArtistID
    JOIN Songs s ON s.AlbumID = al.AlbumID
    JOIN Ratings r ON s.SongID = r.SongID
    GROUP BY a.ArtistName, s.AlbumID
    HAVING AVG(r.Rating) < 3
) AS artist_with_album;

-- 10.Truy vấn danh sách bài hát có ít nhất một bài hát đã được người dùng ở UK thêm vào thư viện

SELECT song_with_user.SongName
FROM (
    SELECT s.SongName, ls.LibraryID
    FROM Songs s
    JOIN Library_Songs ls ON s.SongID = ls.SongID
    JOIN Library l ON ls.LibraryID = l.LibraryID
    JOIN Users u ON l.UserID = u.UserID
    WHERE u.Country = 'UK'
) AS song_with_user;

-- Phần 5. Sử dụng GROUP BY và các Hàm tổng hợp (Aggrerate Function)
-- 1. Truy vấn số lượng bài hát thuộc thể loại 'Pop' trong mỗi album
		SELECT a.AlbumName, COUNT(s.SongID) AS SongCount
		FROM Album a
		JOIN Songs s ON a.AlbumID = s.AlbumID
		JOIN Genres g ON s.GenreID = g.GenreID
		WHERE g.GenreName = 'Pop'
		GROUP BY a.AlbumName;
        
-- 2. Truy vấn trung bình đánh giá của mỗi bài hát trong thư viện của người dùng
	SELECT s.SongName, AVG(r.Rating) AS AverageRating
	FROM Songs s
	JOIN Ratings r ON s.SongID = r.SongID
	JOIN Library_Songs ls ON s.SongID = ls.SongID
	JOIN Library l ON ls.LibraryID = l.LibraryID
	WHERE l.UserID = 4
	GROUP BY s.SongName;
    
-- 3.Truy vấn tổng số lượt theo dõi của mỗi nghệ sĩ

	SELECT a.ArtistName, COUNT(af.UserID) AS FollowerCount
	FROM Artist a
	JOIN ArtistFollow af ON a.ArtistID = af.ArtistID
	GROUP BY a.ArtistName;
    
-- 4.Truy vấn bài hát có đánh giá cao nhất trong mỗi album
	SELECT s.AlbumID, s.SongName, MAX(r.Rating) AS MaxRating
	FROM Songs s
	JOIN Ratings r ON s.SongID = r.SongID
	GROUP BY s.AlbumID, s.SongName;
    
-- 5.Truy vấn tổng số bài hát theo thể loại 'Rock' trong mỗi album
	SELECT a.AlbumName, g.GenreName, COUNT(s.SongID) AS SongCount
	FROM Album a
	JOIN Songs s ON a.AlbumID = s.AlbumID
	JOIN Genres g ON s.GenreID = g.GenreID
	WHERE g.GenreName = 'Rock'
	GROUP BY a.AlbumName, g.GenreName;
    
-- 6. Truy vấn số lượng bài hát của mỗi nghệ sĩ theo thể loại

	SELECT a.ArtistName, g.GenreName, COUNT(s.SongID) AS SongCount
	FROM Artist a
    JOIN Album al ON al.ArtistID = a.ArtistID
    JOIN Songs s ON s.AlbumID = al.AlbumID
	JOIN Genres g ON s.GenreID = g.GenreID
	GROUP BY a.ArtistName, g.GenreName;
    
-- 7.Truy vấn tổng số bài hát mà mỗi người dùng đã thêm vào thư viện
	SELECT u.UserName, COUNT(ls.SongID) AS SongCount
	FROM Users u
	JOIN Library l ON u.UserID = l.UserID
	JOIN Library_Songs ls ON l.LibraryID = ls.LibraryID
	GROUP BY u.UserName;
    
-- 8.Truy vấn tổng số đánh giá của mỗi thể loại nhạc
	SELECT g.GenreName, COUNT(r.RatingID) AS RatingCount
	FROM Genres g
	JOIN Songs s ON g.GenreID = s.GenreID
	JOIN Ratings r ON s.SongID = r.SongID
	GROUP BY g.GenreName;

-- 9.Truy vấn số lượng người dùng trong mỗi thành phố
	SELECT u.City, COUNT(u.UserID) AS UserCount
	FROM Users u
	GROUP BY u.City;
    
-- 10.Truy vấn các thể loại nhạc được theo dõi nhiều nhất
	SELECT g.GenreName, COUNT(af.UserID) AS FollowCount
	FROM Genres g
	JOIN Songs s ON g.GenreID = s.GenreID
    JOIN Album al on al.AlbumID = s.AlbumID
    JOIN Artist art on art.ArtistID = al.ArtistID
	JOIN ArtistFollow af ON art.ArtistID = af.ArtistID
	GROUP BY g.GenreName
	ORDER BY FollowCount DESC;


        
        