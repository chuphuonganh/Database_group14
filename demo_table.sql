CREATE DATABASE IF NOT EXISTS MusicLibrary;
USE MusicLibrary;

CREATE TABLE Artist (
    ArtistID INT AUTO_INCREMENT PRIMARY KEY,
    ArtistName VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    Style VARCHAR(100),
    City VARCHAR(50),
    DateOfBirth DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Album (
    AlbumID INT AUTO_INCREMENT PRIMARY KEY,
    AlbumName VARCHAR(100) NOT NULL,
    PublishedDate DATE,
    ArtistID INT NOT NULL,
    GenreID INT,
    NumberOfTracks INT DEFAULT 0,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE CASCADE
);


CREATE TABLE Songs (
    SongsID INT AUTO_INCREMENT PRIMARY KEY,
    SongName VARCHAR(100) NOT NULL,
    Duration INT NOT NULL CHECK(Duration > 0),
    PublishedDate DATE,
    Language VARCHAR(50),
    AlbumID INT NOT NULL,
    GenreID INT,
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE SET NULL
);

CREATE TABLE Library (
    LibraryID INT AUTO_INCREMENT PRIMARY KEY,
    LikedSong INT,
    FavouriteSong INT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalSongs INT DEFAULT 0 CHECK(TotalSongs >= 0),
    PlayCount INT DEFAULT 0 CHECK(PlayCount >= 0)
);

CREATE TABLE Users (
    UsersID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Member ENUM('NORMAL', 'PREMIUM') DEFAULT 'NORMAL',
    LibraryID INT NOT NULL,
    Address VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50) NOT NULL,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID) ON DELETE CASCADE
);

CREATE TABLE Playlists (
    PlaylistID INT AUTO_INCREMENT PRIMARY KEY,
    PlaylistName VARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    LibraryID INT NOT NULL,
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID) ON DELETE CASCADE
);

CREATE TABLE Songs_has_Playlists (
    SongsID INT NOT NULL,
    PlaylistID INT NOT NULL,
    PRIMARY KEY (SongsID, PlaylistID),
    FOREIGN KEY (SongsID) REFERENCES Songs(SongsID) ON DELETE CASCADE,
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE
);
ALTER TABLE library
ADD CONSTRAINT FK_FavouriteSong
FOREIGN KEY (FavouriteSong) REFERENCES songs(SongsID);


-- Thêm dữ liệu vào bảng Artist
INSERT INTO Artist (ArtistName, Country, Style, City, DateOfBirth, Phone, Email) VALUES
('Taylor Swift', 'USA', 'Pop', 'Nashville', '1989-12-13', '1234567890', 'taylor@swift.com'),
('Ed Sheeran', 'UK', 'Pop, Folk', 'Halifax', '1991-02-17', '0987654321', 'ed@sheeran.com'),
('BTS', 'South Korea', 'K-pop', 'Seoul', '2013-06-13', '5678901234', 'bts@bigent.com'),
('Adele', 'UK', 'Pop, Soul', 'London', '1988-05-05', '8765432109', 'adele@music.com'),
('Coldplay', 'UK', 'Alternative Rock', 'London', '1996-01-01', '1230984567', 'coldplay@band.com'),
('Beyoncé', 'USA', 'R&B, Pop', 'Houston', '1981-09-04', '3216549870', 'beyonce@queenb.com'),
('Drake', 'Canada', 'Hip-Hop, R&B', 'Toronto', '1986-10-24', '4567890123', 'drake@ovo.com'),
('Lady Gaga', 'USA', 'Pop', 'New York', '1986-03-28', '9876543210', 'gaga@monster.com'),
('The Weeknd', 'Canada', 'R&B, Pop', 'Toronto', '1990-02-16', '6543217890', 'weeknd@starboy.com'),
('Imagine Dragons', 'USA', 'Alternative Rock', 'Las Vegas', '2008-01-01', '2345678901', 'idragons@music.com'),
('Bruno Mars', 'USA', 'Pop, Funk', 'Honolulu', '1985-10-08', '8901234567', 'bruno@mars.com'),
('Post Malone', 'USA', 'Hip-Hop, Pop', 'Syracuse', '1995-07-04', '1234567809', 'post@malone.com'),
('Ariana Grande', 'USA', 'Pop, R&B', 'Boca Raton', '1993-06-26', '0987612345', 'ariana@grande.com'),
('Billie Eilish', 'USA', 'Pop, Alternative', 'Los Angeles', '2001-12-18', '5678901235', 'billie@eilish.com'),
('Shawn Mendes', 'Canada', 'Pop, Folk', 'Pickering', '1998-08-08', '7654321098', 'shawn@mendes.com'),
('Rihanna', 'Barbados', 'Pop, R&B', 'Bridgetown', '1988-02-20', '2345678091', 'rihanna@fenty.com'),
('Maroon 5', 'USA', 'Pop Rock', 'Los Angeles', '2001-06-01', '3219876540', 'maroon5@band.com'),
('Katy Perry', 'USA', 'Pop', 'Santa Barbara', '1984-10-25', '6549873210', 'katy@perry.com'),
('Justin Bieber', 'Canada', 'Pop, R&B', 'Stratford', '1994-03-01', '7890123456', 'justin@bieber.com'),
('Selena Gomez', 'USA', 'Pop', 'Grand Prairie', '1992-07-22', '8907654321', 'selena@gomez.com'),
('Halsey', 'USA', 'Pop, Alternative', 'Edison', '1994-09-29', '4567890312', 'halsey@music.com'),
('Dua Lipa', 'UK', 'Pop, Disco', 'London', '1995-08-22', '1239084567', 'dua@lipa.com'),
('Harry Styles', 'UK', 'Pop, Rock', 'Redditch', '1994-02-01', '9871023456', 'harry@styles.com'),
('Zayn Malik', 'UK', 'Pop, R&B', 'Bradford', '1993-01-12', '5647382910', 'zayn@malik.com'),
('BLACKPINK', 'South Korea', 'K-pop', 'Seoul', '2016-08-08', '8905671234', 'blackpink@yg.com'),
('TWICE', 'South Korea', 'K-pop', 'Seoul', '2015-10-20', '6789012345', 'twice@jyp.com'),
('EXO', 'South Korea', 'K-pop', 'Seoul', '2012-04-08', '1234509876', 'exo@sm.com'),
('TXT', 'South Korea', 'K-pop', 'Seoul', '2019-03-04', '7650894321', 'txt@bigent.com'),
('IU', 'South Korea', 'K-pop, Ballad', 'Seoul', '1993-05-16', '6789012456', 'iu@uaena.com'),
('Jay Chou', 'Taiwan', 'Mandopop', 'Taipei', '1979-01-18', '3456789012', 'jay@chou.com'),
('G.E.M.', 'China', 'Mandopop', 'Shanghai', '1991-08-16', '2345678098', 'gem@music.com'),
('Jolin Tsai', 'Taiwan', 'Mandopop', 'Taipei', '1980-09-15', '7654321090', 'jolin@tsai.com'),
('Eason Chan', 'Hong Kong', 'Cantopop', 'Hong Kong', '1974-07-27', '8765432190', 'eason@chan.com'),
('Faye Wong', 'China', 'Cantopop, Mandopop', 'Beijing', '1969-08-08', '3456789010', 'faye@wong.com'),
('Alan Walker', 'Norway', 'EDM', 'Bergen', '1997-08-24', '4567891230', 'alan@walker.com'),
('Marshmello', 'USA', 'EDM', 'Philadelphia', '1992-05-19', '5678901236', 'marshmello@dj.com'),
('Kygo', 'Norway', 'EDM', 'Bergen', '1991-09-11', '6789014320', 'kygo@dj.com'),
('Avicii', 'Sweden', 'EDM', 'Stockholm', '1989-09-08', '1236780912', 'avicii@tim.com'),
('Calvin Harris', 'UK', 'EDM', 'Dumfries', '1984-01-17', '9876541032', 'calvin@harris.com'),
('David Guetta', 'France', 'EDM', 'Paris', '1967-11-07', '8907651203', 'david@guetta.com'),
('Pitbull', 'USA', 'Hip-Hop, Pop', 'Miami', '1981-01-15', '3456708912', 'pitbull@music.com'),
('Enrique Iglesias', 'Spain', 'Pop, Latin', 'Madrid', '1975-05-08', '4567892034', 'enrique@iglesias.com'),
('Shakira', 'Colombia', 'Pop, Latin', 'Barranquilla', '1977-02-02', '5678903456', 'shakira@hips.com'),
('Jennifer Lopez', 'USA', 'Pop, R&B', 'New York', '1969-07-24', '6789014567', 'jlo@music.com'),
('Maluma', 'Colombia', 'Reggaeton', 'Medellin', '1994-01-28', '7890125678', 'maluma@reggaeton.com'),
('Daddy Yankee', 'Puerto Rico', 'Reggaeton', 'San Juan', '1977-02-03', '8901236789', 'daddy@yankee.com'),
('Bad Bunny', 'Puerto Rico', 'Reggaeton, Latin Trap', 'San Juan', '1994-03-10', '9012347890', 'bad@bunny.com'),
('Ozuna', 'Puerto Rico', 'Reggaeton', 'San Juan', '1992-03-13', '0123456789', 'ozuna@latin.com'),
('Camila Cabello', 'USA', 'Pop, Latin', 'Havana', '1997-03-03', '1234567098', 'camila@cabello.com'),
('Luis Fonsi', 'Puerto Rico', 'Pop, Latin', 'San Juan', '1978-04-15', '2345678190', 'luis@fonsi.com'),
('Anitta', 'Brazil', 'Pop, Funk', 'Rio de Janeiro', '1993-03-30', '3456789201', 'anitta@funk.com'),
('Sia', 'Australia', 'Pop, Alternative', 'Adelaide', '1975-12-18', '4567890312', 'sia@music.com'),
('Troye Sivan', 'Australia', 'Pop, Dance', 'Perth', '1995-06-05', '5678901423', 'troye@sivan.com'),
('Tones and I', 'Australia', 'Pop, Indie', 'Mornington Peninsula', '2000-08-15', '6789012534', 'tones@music.com'),
('Lorde', 'New Zealand', 'Pop, Indie', 'Auckland', '1996-11-07', '7890123645', 'lorde@music.com'),
('Sam Smith', 'UK', 'Pop, Soul', 'London', '1992-05-19', '8901234756', 'sam@smith.com'),
('Ellie Goulding', 'UK', 'Pop, Electronic', 'Hereford', '1986-12-30', '9012345867', 'ellie@goulding.com'),
('Florence Welch', 'UK', 'Indie, Pop', 'London', '1986-08-28', '0123456978', 'florence@welch.com'),
('Jessie J', 'UK', 'Pop, R&B', 'London', '1988-03-27', '1234567089', 'jessie@j.com'),
('Demi Lovato', 'USA', 'Pop, R&B', 'Albuquerque', '1992-08-20', '2345678191', 'demi@lovato.com'),
('Nicki Minaj', 'USA', 'Hip-Hop, Pop', 'Queens', '1982-12-08', '3456789202', 'nicki@minaj.com'),
('Cardi B', 'USA', 'Hip-Hop', 'The Bronx', '1992-10-11', '4567890313', 'cardi@b.com'),
('Megan Thee Stallion', 'USA', 'Hip-Hop', 'Houston', '1995-02-15', '5678901424', 'megan@stallion.com'),
('Doja Cat', 'USA', 'Pop, Hip-Hop', 'Los Angeles', '1995-10-21', '6789012535', 'doja@cat.com'),
('Lil Nas X', 'USA', 'Hip-Hop, Pop', 'Lithia Springs', '1999-04-09', '7890123646', 'lilnasx@music.com'),
('Travis Scott', 'USA', 'Hip-Hop, Trap', 'Houston', '1991-04-30', '8901234757', 'travis@scott.com'),
('Future', 'USA', 'Hip-Hop, Trap', 'Atlanta', '1983-11-20', '9012345868', 'future@trap.com'),
('Kanye West', 'USA', 'Hip-Hop, Rap', 'Atlanta', '1977-06-08', '0123456979', 'kanye@west.com'),
('Jay-Z', 'USA', 'Hip-Hop, Rap', 'Brooklyn', '1969-12-04', '1234567090', 'jayz@music.com'),
('Eminem', 'USA', 'Hip-Hop, Rap', 'Detroit', '1972-10-17', '2345678192', 'eminem@rap.com'),
('Nas', 'USA', 'Hip-Hop, Rap', 'Brooklyn', '1973-09-14', '3456789203', 'nas@rap.com'),
('Kendrick Lamar', 'USA', 'Hip-Hop', 'Compton', '1987-06-17', '4567890314', 'kendrick@lamar.com'),
('J. Cole', 'USA', 'Hip-Hop, Rap', 'Frankfurt', '1985-01-28', '5678901425', 'jcole@music.com'),
('Logic', 'USA', 'Hip-Hop, Rap', 'Gaithersburg', '1990-01-22', '6789012536', 'logic@rap.com'),
('Lizzo', 'USA', 'Pop, Hip-Hop', 'Detroit', '1988-04-27', '7890123647', 'lizzo@music.com'),
('SZA', 'USA', 'R&B, Alternative', 'St. Louis', '1990-11-08', '8901234758', 'sza@music.com'),
('H.E.R.', 'USA', 'R&B, Soul', 'Vallejo', '1997-06-27', '9012345869', 'her@music.com'),
('Jhene Aiko', 'USA', 'R&B, Soul', 'Los Angeles', '1988-03-16', '0123456980', 'jhene@aiko.com'),
('Normani', 'USA', 'R&B, Pop', 'Atlanta', '1996-05-31', '1234567091', 'normani@music.com'),
('Chris Brown', 'USA', 'R&B, Hip-Hop', 'Tappahannock', '1989-05-05', '2345678193', 'chris@brown.com'),
('Usher', 'USA', 'R&B, Pop', 'Dallas', '1978-10-14', '3456789204', 'usher@music.com'),
('Trey Songz', 'USA', 'R&B, Soul', 'Petersburg', '1984-11-28', '4567890315', 'trey@songz.com'),
('Alicia Keys', 'USA', 'R&B, Soul', 'New York', '1981-01-25', '5678901426', 'alicia@keys.com'),
('John Legend', 'USA', 'R&B, Soul', 'Springfield', '1978-12-28', '6789012537', 'john@legend.com'),
('Brandy', 'USA', 'R&B, Soul', 'McComb', '1979-02-11', '7890123648', 'brandy@music.com'),
('Ne-Yo', 'USA', 'R&B, Pop', 'Camden', '1979-10-18', '8901234759', 'neyo@music.com');
INSERT INTO Genres (GenreName) VALUES
('Pop'),
('Rock'),
('Jazz'),
('K-pop'),
('Classical'),
('Hip-Hop'),
('R&B'),
('Country'),
('Electronic'),
('Reggae'),
('Blues'),
('Soul'),
('Folk'),
('Disco'),
('Funk'),
('Metal'),
('Indie'),
('Alternative'),
('Latin'),
('Trap'),
('House'),
('Techno'),
('EDM'),
('Dubstep'),
('Gospel'),
('Opera'),
('Punk Rock'),
('Hard Rock'),
('Grunge'),
('Progressive Rock'),
('Synthwave'),
('Chillout'),
('Lo-fi'),
('Ambient'),
('New Age'),
('World Music'),
('Afrobeat'),
('Ska'),
('Dancehall'),
('Bossa Nova'),
('Samba'),
('Flamenco'),
('Bollywood'),
('Mandopop'),
('Cantopop'),
('J-pop'),
('Trot'),
('Ballad'),
('Chanson'),
('Swing'),
('Big Band');

INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('25', '2015-11-20', 4, 1, 11),
('A Head Full of Dreams', '2015-12-04', 5, 2, 11),
('Lemonade', '2016-04-23', 6, 7, 12),
('Scorpion', '2018-06-29', 7, 7, 25),
('Chromatica', '2020-05-29', 8, 1, 16),
('After Hours', '2020-03-20', 9, 7, 14),
('Evolve', '2017-06-23', 10, 2, 12),
('Doo-Wops & Hooligans', '2010-10-04', 11, 1, 10),
('Hollywoods Bleeding', '2019-09-06', 12, 7, 17),
('Thank U, Next', '2019-02-08', 13, 7, 12),
('Happier Than Ever', '2021-07-30', 14, 1, 16),
('Shawn Mendes', '2018-05-25', 15, 1, 14),
('Anti', '2016-01-28', 17, 7, 13),
('Songs About Jane', '2002-06-25', 18, 1, 12),
('Teenage Dream', '2010-08-24', 19, 1, 12),
('Purpose', '2015-11-13', 20, 1, 13),
('Rare', '2020-01-10', 21, 1, 13),
('Manic', '2020-01-17', 22, 1, 16),
('Future Nostalgia', '2020-03-27', 23, 1, 11),
('Fine Line', '2019-12-13', 24, 1, 12),
('Nobody Is Listening', '2021-01-15', 25, 7, 11),
('The Album', '2020-10-02', 26, 4, 8),
('Formula of Love', '2021-11-12', 27, 4, 17),
('Don’t Mess Up My Tempo', '2018-11-02', 28, 4, 11),
('The Dream Chapter: STAR', '2019-03-04', 29, 4, 5),
('Palette', '2017-04-21', 30, 4, 10),
('The Secret', '2003-07-31', 31, 13, 12),
('Heartbeat', '2015-01-12', 33, 3, 11),
('Born This Way', '2011-05-23', 8, 1, 14),
('Immortal Love Songs', '2018-02-01', 36, 3, 9),
('Havana Nights', '2019-12-11', 34, 1, 13),
('Bad Habits', '2023-04-30', 2, 1, 5),
('Views', '2016-04-29', 7, 7, 20),
('X', '2014-06-20', 2, 1, 12),
('Lover', '2019-08-23', 1, 1, 18),
('Blurryface', '2015-05-17', 10, 2, 14),
('Everyday Life', '2019-11-22', 5, 2, 16),
('Speak Now', '2010-10-25', 1, 1, 14),
('Red', '2012-10-22', 1, 1, 16),
('The Fame', '2008-08-19', 8, 1, 14),
('Melodrama', '2017-06-16', 44, 1, 11),
('Golden Hour', '2018-03-30', 48, 8, 13),
('CTRL', '2017-06-09', 42, 7, 14),
('Over It', '2019-10-04', 41, 7, 18),
('Channel Orange', '2012-07-10', 50, 7, 17),
('Goodbye & Good Riddance', '2018-05-23', 46, 7, 16),
('Unorthodox Jukebox', '2012-12-07', 11, 1, 10),
('Starboy', '2016-11-25', 9, 7, 18),
('Dangerous Woman', '2016-05-20', 13, 1, 15);

INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
('Shake It Off', 230, '2014-10-27', 'English', 1, 1),
('Perfect', 263, '2017-03-03', 'English', 2, 1),
('Dynamite', 199, '2020-08-21', 'Korean', 3, 4);

INSERT INTO Library (LikedSong, FavouriteSong, TotalSongs, PlayCount) VALUES
(1, 1, 10, 50),
(2, 3, 20, 120);

INSERT INTO Users (UserName, Email, LibraryID, Address, City, Country) VALUES
('Alice', 'alice@example.com', 1, '123 Main St', 'Los Angeles', 'USA'),
('Bob', 'bob@example.com', 2, '456 Elm St', 'London', 'UK');


