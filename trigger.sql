USE music;
-- 1. Trigger để tự động cập nhật số lượng bài hát cho thành viên trong Library 
-- Tự động cộng thêm 1 bài khi thêm songs vào library cho TotalSongs 
DELIMITER $$
CREATE TRIGGER after_add_song_to_library
after insert on Library_Songs
for each row
begin
	update Library
	set TotalSongs = TotalSongs + 1
	where LibraryID = NEW.LibraryID;
END$$
DELIMITER ;
-- test hoàn thiện
select TotalSongs from Library
where LibraryID = 18;
select * from Library_Songs;
insert into Library_Songs(LibraryID, SongID)
values(18, 34);
select TotalSongs from Library
where LibraryID = 18;

-- 2.Tự động trừ đi một bài khi xóa 1 bài khỏi Library
DELIMITER $$
CREATE TRIGGER after_delete_song_from_library
after delete on Library_Songs for each row
begin
    update Library
    set TotalSongs = TotalSongs - 1
    where LibraryID = OLD.LibraryID;
end $$
DELIMITER ;
-- test hoàn thiện
delete from Library_Songs
where LibraryID = 18 and SongID = 34;
select TotalSongs from Library
where LibraryID = 18;

-- 3.Trigger kiểm tra bài hát có tồn tại trước khi thêm bài không 
DELIMITER $$
create trigger before_add_song_to_library
before insert on Library_Songs for each row
begin 
	if exists ( select 1 from Library_Songs
				where LibraryID = NEW.LibraryID
				and SongID = NEW.SongID )
	then signal SQLSTATE '45000'
		 set message_text =  'Bài hát đã tồn tại trong thư viện';
    end if;
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
select * from Library_Songs;
insert into Library_Songs(LibraryID, SongID)
values(3, 477);
rollback;

-- 3.Tự động ghi vào bảng log mỗi khi bài hát được thêm/xóa khỏi thư viện
create table if not exists Library_Log(
	LogID INT AUTO_INCREMENT PRIMARY KEY,
    LibraryID INT NOT NULL,
    SongID INT NOT NULL,
    Action ENUM('ADD', 'REMOVE') NOT NULL,
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP );
-- Trigger ghi log khi thêm bài hát 
DELIMITER $$
create trigger after_add_song_to_library_log
after insert on Library_Songs for each row
begin
	insert into Library_Log(LibraryID, SongID, Action)
	values(NEW.LibraryID, NEW.SongID, 'ADD');
	end $$
DELIMITER ;
-- test hoàn thiện
insert into Library_Songs(LibraryID, SongID)
values(4, 577);
select * from Library_Log
where LibraryID = 4 and SongID = 577;

-- Trigger ghi log khi xóa bài hát
DELIMITER $$
create trigger after_delete_song_from_library_log
after delete on Library_Songs for each row
begin
	insert into Library_Log(LibraryID, SongID, Action)
	values(OLD.LibraryID, OLD.SongID, 'REMOVE');
	end $$
DELIMITER ;

-- test hoàn thiện
delete from Library_Songs
where LibraryID = 4 and SongID = 577;
select * from Library_Log
where LibraryID = 4 and SongID = 577;

-- 4. Trigger giới hạn số lượng bài hát của mỗi thư viện
DELIMITER $$
create trigger before_add_song_to_library_limit
before insert on Library_Songs for each row
begin
	declare song_count int;
    select TotalSongs into song_count from Library
    where LibraryID = NEW.LibraryID;
    if song_count >= 500
    then
		SIGNAL SQLSTATE '45000'
        set message_text='Thư viện không thể có hơn 500 bài';
	end if;
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
insert into Library(UserID, LibraryName, TotalSongs)
values(89, 'Electronic', 500);
insert into Library_Songs(LibraryID, SongID)
values(last_insert_id(), 15);
rollback;

-- 5. Tự động chuẩn hóa định dạng Artist thành chữ thường
DELIMITER $$
create trigger normalize_artist_name
before insert on Artist for each row
begin
	set NEW.ArtistName = Lower(NEW.ArtistName);
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
insert into Artist(ArtistName)
values('KAGG GLE');
select * from Artist
where ArtistID = last_insert_id();
rollback;

-- 6. Cập nhật trạng thái thành viên: Nếu một users đã đánh giá 50 bài hát
-- tự động nâng trạng thái Member lên PREMIUM, trên 100 là VIP
DELIMITER $$
create trigger upgrade_member_status
after insert on Ratings for each row
begin 
	declare rating_count int;
    select count(*) into rating_count
    from Ratings
    where UserID = NEW.UserID;
    if rating_count >= 5 and rating_count <= 10 then
		update Users
        set Member = 'PREMIUM'
        where UserID = NEW.UserID;
	elseif rating_count > 10 then 
		update Users
        set Member = 'VIP'
        where UserID = NEW.UserID;
	end if;
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
select count(r.Rating), r.UserID, u.Member from Ratings r
join Users u on r.UserID = u.UserID
group by r.UserID, u.Member; 
INSERT INTO Ratings(UserID, SongID, Rating) values
(24,12,3);
select * from Users where UserID = 24;
rollback;

CREATE TABLE Artist_Logs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Action VARCHAR(10),
    ArtistID INT,
    OldData JSON,
    NewData JSON,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- 7.Ghi lại tất cả thay đổi (thêm, sửa, xóa) trên bảng Artist vào một bảng log (Artist_Logs).
-- Ghi lại loại hành động, thời gian, và dữ liệu trước và sau.
DELIMITER $$
create trigger log_artist_changes
after insert on Artist for each row
begin
    insert into Artist_Logs (Action, ArtistID, NewData)
    values ('INSERT', NEW.ArtistID, JSON_OBJECT('ArtistName', NEW.ArtistName, 'Country', NEW.Country));
end $$

create trigger log_artist_update
after update on Artist for each row
begin
    insert into Artist_Logs (Action, ArtistID, OldData, NewData)
    values ('UPDATE', OLD.ArtistID, 
            JSON_OBJECT('ArtistName', OLD.ArtistName, 'Country', OLD.Country),
            JSON_OBJECT('ArtistName', NEW.ArtistName, 'Country', NEW.Country));
end $$

create trigger log_artist_delete
after delete on Artist for each row
begin
    insert into Artist_Logs (Action, ArtistID, OldData)
    values ('DELETE', OLD.ArtistID, 
            JSON_OBJECT('ArtistName', OLD.ArtistName, 'Country', OLD.Country));
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
insert into Artist(ArtistName, Country, Style, City, DateOfBirth, Phone)
values('CIN Minh cit', 'Việt Nam', 'NUMETAL','Hà Nội', '2005-1-9','23020399');
select * from Artist_Logs
where ArtistID = last_insert_id();
update Artist
set Style = 'Rock'
where ArtistID = last_insert_id();
select * from Artist_Logs
where ArtistID = last_insert_id();
rollback;

-- 8.Tự động tính trung bình đánh giá
ALTER TABLE Songs
ADD COLUMN RatingAverage DECIMAL(5, 2) DEFAULT 0;

DELIMITER $$
create trigger calculate_average_rating
after insert on Ratings for each row
begin 
	update songs
    set RatingAverage = (select AVG(Rating) from Ratings 
						where SongID = NEW.SongID)
	where SongID = NEW.SongID;
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
insert into Ratings (UserID, SongID, Rating)
values(54, 146, 3);
select * from songs
where SongID = 146;
rollback;

-- 9. Khi một nghệ sĩ bị xóa thì xóa những Album và Songs liên quan
DELIMITER $$
create trigger cascade_artist_deletion
before delete on Artist for each row
begin
    delete from Songs where AlbumID in (select AlbumID from Album where ArtistID = OLD.ArtistID);
    delete from Album where ArtistID = OLD.ArtistID;
end $$
DELIMITER ;
-- test hoàn thiện
start transaction;
select * from Album
where ArtistID = 6;
delete from Artist
where ArtistID = 6;
select * from Album
where ArtistID = 6;
rollback;

SHOW TRIGGERS;
SELECT CONCAT('DROP TRIGGER IF EXISTS ', TRIGGER_NAME, ';') 
FROM INFORMATION_SCHEMA.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'music';
DROP TRIGGER IF EXISTS after_add_song_to_library;
DROP TRIGGER IF EXISTS after_delete_song_from_library;
DROP TRIGGER IF EXISTS before_add_song_to_library;
DROP TRIGGER IF EXISTS after_add_song_to_library_log;
DROP TRIGGER IF EXISTS after_delete_song_from_library_log;
DROP TRIGGER IF EXISTS before_add_song_to_library_limit;
DROP TRIGGER IF EXISTS normalize_artist_name;
DROP TRIGGER IF EXISTS upgrade_member_status;
DROP TRIGGER IF EXISTS log_artist_changes;
DROP TRIGGER IF EXISTS log_artist_delete;
DROP TRIGGER IF EXISTS log_artist_update;
DROP TRIGGER IF EXISTS calculate_average_rating;
DROP TRIGGER IF EXISTS cascade_artist_deletion;