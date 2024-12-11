use Music;
-- INNER JOIN

-- 1.Lấy danh sách các bài hát cùng với tên nghệ sĩ của chúng
SELECT s.SongName, a.ArtistName
FROM Songs s
INNER JOIN Album al ON s.AlbumID = al.AlbumID
INNER JOIN Artist a ON al.ArtistID = a.ArtistID;

-- 2.Tìm thông tin người dùng và thư viện của họ
select l.UserID,u.UserName, l.LibraryID from Library l
join users u on l.UserID = u.UserID;

-- 3.Liệt kê các bài hát và thể loại của chúng
SELECT s.SongName, g.GenreName
FROM Songs s
INNER JOIN Genres g ON s.GenreID = g.GenreID;

-- 4.Lấy danh sách các album và tên nghệ sĩ tương ứng
select al.AlbumName, a.ArtistName from Album al
join  Artist a on al.ArtistID = a.ArtistID;

-- 5.Liệt kê các nghệ sĩ có songs thuộc thể loại nhất định
select a.ArtistID, a.ArtistName, s.SongName from Artist a
join Album al on a.ArtistID = al.ArtistID
join songs s on al.AlbumID = s.AlbumID;  

-- 6.Tìm bài hát cụ thể trong từng Playlists
select p.PlaylistID, s.SongName from Playlists p
join Playlist_Songs ps on p.PlaylistID = ps.PlaylistID
join Songs s on ps.SongID = s.SongID;
-- 7 tìm những ca sĩ không có Album nào
select a.ArtistID from Artist a
where a.ArtistID not in (
select a2.ArtistID from Artist a2
join Album al on a2.ArtistID = al.ArtistID);
-- 8 tìm những users không có Playlists nào
select u.UserID from Users u
where u.UserID not in (
select u2.UserID from Users u2
join Playlists p on u2.UserID = p.UserID);
-- 9 Liệt kê tên Album và bài hát
select al.AlbumID,  s.SongName from Album al
join songs s on al.AlbumID = s.SongID;
-- 10 Liệt kê tên ca sĩ và followers của họ
select u.UserID, u.UserName, a.ArtistID, a.ArtistName from artistfollow ar
join Users u on ar.UserID = u.UserID
join Artist a on ar.ArtistID = a.ArtistID;

-- ---------------------------------------------------------------------------------------------------
-- OUTER JOIN
-- 1.Liệt kê tên nghệ sĩ và số lượng Album bao gồm cả những người không có Album nào
select a.ArtistName, a.ArtistID, count(al.AlbumID) as NumberOfAlbums from Artist a
left join Album al on a.ArtistID = al.ArtistID
group by a.ArtistName, a.ArtistID;

-- 2.Liệt kê tất cả Users và số lượng Library họ đã tạo bao gồm cả những người không có Library nào
select u.UserName, u.UserID, count(l.UserID) as NumberOfLibrarys from Users u
left join Library l on u.UserID = l.UserID
group by u.UserName, u.UserID;

-- 3.Liệt kê tất cả Users và số lượng Playlists họ đã tạo bao gồm cả những người không có Playlist nào
select u.UserName, u.UserID, count(p.UserID) as NumberOfPlaylists from Users u
left join Playlists p on u.UserID = p.UserID
group by u.UserName, u.UserID;

-- 4.Tìm tất cả người dùng và số bài hát trong thư viện của họ (bao gồm cả người dùng không có bài hát nào)
SELECT s.SongName, g.GenreName
FROM Songs s
LEFT JOIN Genres g ON s.GenreID = g.GenreID;

-- 5. Tên Artist đi cùng với AlbumName
SELECT a.ArtistName, al.AlbumName
FROM Artist a
LEFT JOIN Album al ON a.ArtistID = al.ArtistID;

-- 6. Tên User đi cùng với tên Playlist
SELECT u.UserName, p.PlaylistName
FROM Users u
LEFT JOIN Library l on u.UserID = l.UserID;

-- 7. Danh sách tất cả bài hát và đánh giá cao nhất của chúng (bao gồm cả bài hát chưa được đánh giá) 
SELECT s.SongName, MAX(r.Rating) AS MaxRating
FROM Songs s
LEFT OUTER JOIN Ratings r ON s.SongID = r.SongID
GROUP BY s.SongName;
-- select * from Ratings;

-- 8.Tìm nghệ sĩ không có bài hát nào được người dùng PREMIUM đánh giá
select a.ArtistName, count(r.SongID), count(u.Member) from Artist a
left join Album al on a.ArtistID = al.ArtistID
left join songs s on al.AlbumID = s.AlbumID
left join Ratings r on s.SongID = r.SongID
left join Users u on r.UserID = u.UserID and u.Member = 'PREMIUM'
group by a.ArtistName
having count(r.SongID) = 0 or count(u.Member) = 0; 

-- 9.Tìm tất cả các thể loại và tổng số bài hát thuộc mỗi thể loại (bao gồm thể loại không có bài hát nào)
select g.GenreName, count(g.GenreID) as totalSongs from Genres g
left join songs s on g.GenreID = s.GenreID
group by g.GenreName;

-- 10.Tìm người dùng không theo dõi nghệ sĩ nào
select u.UserID, u.UserName from Users u
left join artistfollow ar on u.UserID = ar.UserID
where ar.UserID is null;

-- ------------------------------------------------------------------------------------------------------------------
-- USE SUBQUERY IN WHERE
-- 1. Tìm các nghệ sĩ có ít nhất một bài hát được đánh giá 
select  * from Ratings;
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

-- 6 Tìm tất cả bài hát được xuất bản sau album có ngày phát hành sớm nhất
select SongName from Songs
where PublishedDate > (select min(PublishedDate) from Album);

-- 7.Tìm tất cả nghệ sĩ có songs nằm trong thể loại "Rock"
select ArtistName from Artist
where ArtistID in (
select al.ArtistID from Album al
join songs s on al.AlbumID = s.AlbumID
join Genres g on s.GenreID = g.GenreID
where g.GenreName = 'Rock');

-- 8.Tìm các bài hát có tổng điểm đánh giá thấp hơn điểm trung bình của tất cả các bài hát
select SongName from Songs
where SongID in (select SongID from Ratings
    group by SongID
    having sum(Rating) < (select avg(sum_Rating) from (
            select sum(Rating) as sum_Rating from Ratings
            group by SongID) as Sub
    )
);

-- 9.Tìm người dùng đã từng đánh giá bài hát thuộc thể loại "Pop"
select UserName from Users
where exists(select s.SongID from Songs s
join Genres g on s.GenreID = g.GenreID
where g.GenreName = 'Pop' and s.SongID in (
select r.SongID from Ratings r
where r.UserID = Users.UserID)); 

-- 10. Tìm các nghệ sĩ không có bài hát nào trong album được xuất bản gần đây nhất
select ArtistName from Artist
where ArtistID not in (
select al.ArtistID from Album al
where al.PublishedDate = (select max(PublishedDate) from Album));
-- ----------------------------------------------------------------------------------------------------------------
-- USE SUBQUERY IN FROM
-- 1.Tìm người dùng có tổng số bài hát trong thư viện lớn nhất
with temp as(
select sum(TotalSongs) as TotalSongs, UserID from Library
group by UserID) 
select TotalSongs, UserID from temp
where TotalSongs = (select max(TotalSongs) from temp);

-- 2.Tính tên thư viện có số bài hát nhiều nhất theo loại thư viện, lọc ra những người có tổng > 100 
with temp as(
select sum(TotalSongs) as NumberSongs, Type , LibraryName from Library
group by LibraryID)
select NumberSongs, Type, LibraryName from temp
where (NumberSongs, Type) in (select max(NumberSongs), Type from temp group by Type);

-- 3.Tìm số lượng bài hát theo từng thể loại 
select GenreName, numberOfSongs from (
select g.GenreName, count(s.SongID) as numberOfSongs from Genres g
left join songs s on g.GenreID = s.GenreID
group by g.GenreName) as temp;

-- 4.Tìm người dùng theo dõi nhiều nghệ sĩ nhất
select UserName, numberOfArtists from
(select u.UserName, count(ar.ArtistID) as numberOfArtists from artistfollow ar
join Users u on ar.UserID = u.UserID
group by u.UserName, u.UserID) as temp;

-- 5.Tính tổng bài hát trong Playlist của từng loại thành viên
select Member, numberOfSongsInPlaylists from 
(select u.Member, count(s.SongID) as numberOfSongsInPlaylists from Users u
join Playlists p on  u.UserID = p.UserID
join Playlist_Songs ps on p.PlaylistID = ps.PlaylistID
join songs s on ps.SongID = s.SongID
group by u.Member) as temp;

-- 6.Tìm số bài hát có đánh giá cao nhất của từng playlist
select PlaylistName, maxRating
from (
select p.PlaylistName, max(r.Rating) as maxRating from Playlists p
join Playlist_Songs ps on p.PlaylistID = ps.PlaylistID
join Ratings r on ps.SongID = r.SongID
group by p.PlaylistName ) as temp;

-- 7.Tìm thể loại có số lượng bài hát nhiều nhất theo từng ngôn ngữ
SELECT Language, GenreName, TotalSongs
FROM (
    SELECT s.Language, g.GenreName, COUNT(s.SongID) AS TotalSongs,
           RANK() OVER (PARTITION BY s.Language ORDER BY COUNT(s.SongID) DESC) AS rnk
    FROM Songs s
    JOIN Genres g ON s.GenreID = g.GenreID
    GROUP BY s.Language, g.GenreName
) AS GenreLanguageStats
WHERE rnk = 1;
-- 8.Tìm người dùng có tổng số bài hát thuộc thể loại "Pop" cao nhất trong thư viện
select UserName, TotalPopSongs
from (select u.Username, count(ls.SongID) as TotalPopSongs from Users u
join Library l on u.UserID = l.UserID
join Library_Songs ls on l.LibraryID = ls.LibraryID
join songs s on ls.SongID = s.SongID
join Genres g on s.GenreID = g.GenreID
where g.GenreName = 'Pop'
group by u.UserName) as temp
order by TotalPopSongs desc
limit 1;

-- 9.Tìm nghệ sĩ được theo dõi bởi nhiều thành viên VIP nhất
select ArtistName, TotalVipFollows
from (select  a.ArtistName, count(ar.UserID) as TotalVipFollows from Artist a
join artistfollow ar on a.ArtistID = ar.ArtistID
join Users u on ar.UserID = u.UserID
where u.Member = 'VIP'
group by a.ArtistName)
as temp
order by TotalVipFollows desc
limit 1;

-- 10. Tìm các bài hát có tổng điểm đánh giá thuộc top 3 trong từng ngôn ngữ
SELECT Language, SongName, TotalRating
FROM (
    SELECT s.Language, s.SongName, SUM(r.Rating) AS TotalRating,
           RANK() OVER (PARTITION BY s.Language ORDER BY SUM(r.Rating) DESC) AS rnk
    FROM Songs s
    JOIN Ratings r ON s.SongID = r.SongID
    GROUP BY s.Language, s.SongName
) AS SongRatings
WHERE rnk <= 3;
-- --------------------------------------------------------------------------------------------------------------------
-- Query using group by and aggregate functions

-- 1.Số bài hát trong mỗi Playlist
select PlaylistID, count(SongID) as totalSongs from Playlist_Songs
group by PlaylistID;

-- 2. Số Playlists của mỗi người dùng
select u.UserName, count(p.PlaylistID) as totalPlaylists from Users u
left join Playlists p on u.UserID = p.UserID
group by u.UserName;  

-- 3. Số lượng followers của mỗi Artists
select a.ArtistName, count(ar.UserID) as followers from Artist a
left join artistfollow ar on a.ArtistID = ar.ArtistID
group  by a.ArtistName, a.ArtistID;

-- 4. Tổng số lượng thành viên theo loại của Member User
select Member, count(Member) as NumberOfTypeMembers from Users
group by Member;

-- 5. Đếm số lượng Type Library theo nhóm
select Type, Count(Type) as NumberOfTypeLibrary from Library
group by Type;

-- 6. Đếm số lượng Type Shared của tất cả User có Country = "USA"
select count(Type) from 
(select l.Type from Library l
join Users u on l.UserID = u.UserID
where u.Country = 'USA') as temp
group by Type
having Type = 'Shared';

-- 7.Tìm nghệ sĩ có tổng số bài hát lớn nhất trong mỗi quốc gia
select max(total) as totalSong from
(select a.ArtistName, count(s.SongID) as total from Artist a
join Album al on a.ArtistID = al.ArtistID
join songs s on al.AlbumID = s.SongID
group by a.Country, a.ArtistName) as temp ;

-- 8.Tìm playlist có tổng thời lượng bài hát cao nhất
select p.PlaylistName, sum(s.duration) as totalDuration  from Playlists p
join Playlist_Songs ps on p.PlaylistID = ps.PlaylistID
join songs s on ps.SongID = s.SongID
group by p.PlaylistName;

-- 9.Tìm bài hát có đánh giá trung bình cao nhất trong mỗi ngôn ngữ
with temp as (
select s.SongName,s.language, avg(Rating) as averageRating  from Ratings r
join songs s on r.SongID  = s.SongID
 group by s.SongName, s.SongID)
 select averageRating, SongName, language from temp
 where (averageRating, language) in (select min(averageRating), language from temp 
 group by language);
 
-- 10.Tìm năm phát hành có tổng số bài hát lớn nhất 
with temp as (select count(SongID) as totalSongs, year(publishedDate) as year from songs
group by year(publishedDate))
select totalSongs, year from temp
where totalSongs = (select max(totalSongs) from temp);
