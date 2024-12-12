Use music;
-- 1.Thêm bài hát mới (và hủy) vào Album
start TRANSACTION;
insert into songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
values ('see you again', 126, '2024-12-12', 'English', 101, 12);
select * from songs
where SongName = 'see you again' and Duration = 126;
rollback;

-- 2.Thêm nghệ sĩ mới và hoàn tác
start TRANSACTION;
insert into Artist(ArtistName, Country, Style, City, DateOfBirth, Phone)
values ('Đàm Vĩnh Hưng', 'Việt Nam', 'Rock', 'Hưng Yên', '2005-11-14', 
'23020390');  
ROLLBACK;

-- thêm nghệ sĩ và bài hát, quay lại điểm lưu nếu không thêm được bài hát
start TRANSACTION;
savepoint add_artist;
insert into Artist (ArtistName, Country, Style, City, DateOfBirth, Phone) 
values  ('ali cooper', 'UK', 'Pop', 'London', '1985-06-15', '987654321');
insert into Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) 
values('Pop Tune', 200, '2024-04-01', 'English', NULL, 1);
ROLLBACK TO add_artist;

-- 2. Thêm một Playlist và thêm bài hát vào Playlist đó, sau đó hủy
start TRANSACTION;
insert into Playlists (PlaylistName, CreatedDate, UserID)
values ('Suýt', '2024-12-12', 137);
set @newPlaylistID = Last_insert_id();
insert into Playlist_Songs(PlaylistID,SongID)
values(@newPlaylistID, 3);
ROLLBACK;

-- 3.Thêm playlist và bài hát vào playlist, hoàn tác toàn bộ nếu bài hát không tồn tại
start TRANSACTION;
insert into Playlists (PlaylistName, UserID) 
values ('Chill Vibes', 1);
insert into Playlist_Songs (PlaylistID, SongID) 
values (Last_insert_ID(), 999);
ROLLBACK;

-- 4.Cập nhật xếp hạng bài hát, hoàn tác
start TRANSACTION;
update Ratings
set Rating = 5
where UserID = 10 AND SongID = 65;
insert into Ratings (UserID, SongID, Rating, Review, CreatedDate) 
values (1, 2, 5, 'Amazing song!', NOW());
ROLLBACK;

-- 5.Xóa đánh giá bài hát và hủy 
start TRANSACTION;
delete from Ratings
where UserID = 193 and Review = 'Great song!';
ROLLBACK;

-- 7.Theo dõi nghệ sĩ và thêm bài hát vào thư viện
start transaction;
insert into Artist (ArtistName, Country, Style, City, DateOfBirth, Phone)
values ('Ngọt', 'Việt Nam', 'Pop', 'Hà Nội', '1999-11-14', '23020390');
insert into Library (UserID, LibraryName, CreatedDate, Type, TotalSongs)
values(14, 'Love yourself', '2024-12-12 21:43:54', 'PERSONAL', 1689);
ROLLBACK;

-- 8.Thêm bài hát và thêm bài hát vào Playlist nhưng hủy hết dùng savepoint
start transaction;
savepoint before_add_songs;
insert into songs(SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
values('Memories', 134, '2023-12-9', 'Spanish', 29, 15);
savepoint before_add_songs_into_Playlists;
insert into Playlist_Songs(PlaylistID, SongID)
values(1,134);
insert into Playlist_Songs(PlaylistID, SongID)
values(7,134);
ROLLBACK TO before_add_songs;

-- 9. Cập nhật bài hát và đánh giá bài hát, quay lại điểm lưu nếu xảy ra lỗi khi đánh giá:
start transaction;
savepoint add_song;
update Songs 
set AlbumID = 80
where SongName = 'Have You Ever?';
set @tempID = (select AlbumID from Songs where SongName = 'Have You Ever?');

savepoint add_rating;
insert into Ratings (UserID, SongID, Rating, Review, CreatedDate) 
select 8, @tempID, 100, 'Masterpiece!', NOW()
from dual
where not exists(
    select 1 from Ratings 
    where UserID = 8 and SongID = @tempID
);
rollback to add_rating;
rollback to add_song;

-- 10.Quản lý album và danh sách phát, quay lại điểm lưu nếu xảy ra lỗi khi thêm bài hát vào playlist
start transaction;

savepoint update_album;
select * from songs;
update songs 
set AlbumID = 45
where SongName = 'Life Goes On' and AlbumID != 45;

set @songid = (select SongID from songs where SongName = 'Life Goes On');
set @playlistid = (select PlaylistID from Playlists where PlaylistName = 'Party Hits' and UserID = 98);

savepoint add_song_to_playlist;

insert into Playlist_Songs (PlaylistID, SongID)
select @playlistid, @songid
from dual
where not exists (
    select 1 from Playlist_Songs 
    where PlaylistID = @playlistid and SongID = @songid
);

rollback to add_song_to_playlist;

rollback to update_album;

commit;
