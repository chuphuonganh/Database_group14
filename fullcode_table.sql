CREATE DATABASE IF NOT EXISTS Music;
USE Music;

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
    AlbumName VARCHAR(100) NULL,
    PublishedDate DATE,
    ArtistID INT NOT NULL,
    GenreID INT, -- về sau xóa để tránh gõ, lệnh đã thực hiện ở dưới
    NumberOfTracks INT DEFAULT 0,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE CASCADE
);
CREATE TABLE Songs (
    SongID INT AUTO_INCREMENT PRIMARY KEY,
    SongName VARCHAR(100) NOT NULL,
    Duration INT NOT NULL CHECK(Duration > 0),
    PublishedDate DATE,
    Language VARCHAR(50),
    AlbumID INT,
    GenreID INT NOT NULL,
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Member ENUM('NORMAL', 'PREMIUM', 'VIP') DEFAULT 'NORMAL',
    Address VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50) NOT NULL
);
CREATE TABLE Playlists (
    PlaylistID INT AUTO_INCREMENT PRIMARY KEY,
    PlaylistName VARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
CREATE TABLE Playlist_Songs (
    PlaylistID INT NOT NULL,
    SongID INT NOT NULL,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE
    on update cascade,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
    on update cascade
);
CREATE TABLE Ratings (
    RatingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    SongID INT NOT NULL,
    Rating TINYINT CHECK(Rating BETWEEN 1 AND 5),
    Review TEXT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
CREATE TABLE ArtistFollow (
    FollowID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ArtistID INT NOT NULL,
    FollowDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE CASCADE
);
CREATE TABLE Library (
    LibraryID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL, 
    LibraryName VARCHAR(100) NOT NULL, 
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Type ENUM('FAVORITE', 'PERSONAL', 'SHARED') DEFAULT 'PERSONAL', 
    TotalSongs INT DEFAULT 0 CHECK (TotalSongs >= 0), 
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
CREATE TABLE Library_Songs (
    LibraryID INT NOT NULL,
    SongID INT NOT NULL,
    AddedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (LibraryID, SongID),
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE ON UPDATE CASCADE
);
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
('Big Band'),
('Bossa Nova Jazz'),
('Ska Punk'),
('Chillwave'),
('Lo-fi Hip-Hop'),
('Future Bass'),
('Tech House'),
('Deep House'),
('Minimal Techno'),
('Ambient House'),
('Trance'),
('Psytrance'),
('Downtempo'),
('Progressive Trance'),
('Vaporwave'),
('Tropical House'),
('Garage Rock'),
('Noise Rock'),
('Emo'),
('Post-hardcore'),
('Screamo'),
('Blues Rock'),
('Post-punk Revival'),
('Folk Punk'),
('Gothic Rock'),
('Acid Jazz'),
('Garage Punk'),
('Synthwave Retrowave'),
('Pop Punk'),
('Hardcore Punk'),
('Math Rock'),
('Pop Soul'),
('Indie Pop'),
('Indie Rock'),
('Shoegaze'),
('Emo Pop'),
('Lo-fi Indie'),
('Punk Pop'),
('Darkwave'),
('Post-metal'),
('Stoner Rock'),
('Sludge Metal'),
('Doom Metal'),
('Death Metal'),
('Black Metal'),
('Thrash Metal'),
('Grindcore'),
('Industrial Metal'),
('Progressive Metal'),
('Symphonic Metal'),
('Gothic Metal'),
('Folk Metal'),
('Jazz Fusion'),
('Smooth Jazz'),
('Contemporary Jazz'),
('Electropop'),
('Nu Jazz'),
('Jazz Rap'),
('Soul Jazz'),
('Neo-soul'),
('Modern R&B'),
('Soul Pop'),
('Funk Soul'),
('Acoustic'),
('MPB'),
('Axé'),
('Heavy Metal'),
('Jazz Rock'),
('Live');

INSERT INTO Users (UserName, Email, Address, City, Country) VALUES
('Michael Green', 'johndoe1@example.com', '10 Downing St', 'London', 'UK'),
('Emily Davis', 'janesmith2@example.com', '1 Harbour Rd', 'Sydney', 'Australia'),
('Sofia Nguyen', 'alicejohnson3@example.com', '123 Sakura St', 'Tokyo', 'Japan'),
('David Lee', 'bobbrown4@example.com', '456 Yonge St', 'Toronto', 'Canada'),
('Sophia Martinez', 'charliewhite5@example.com', '789 Champs-Élysées', 'Paris', 'France'),
('David Green', 'davidgreen6@example.com', '303 Cedar St', 'Houston', 'USA'),
('Eva Black', 'evablack7@example.com', '123 Abbey Rd', 'London', 'UK'),
('Frank Blue', 'frankblue8@example.com', '456 Opera House Rd', 'Sydney', 'Australia'),
('Grace Red', 'gracered9@example.com', '789 Maple Leaf Dr', 'Toronto', 'Canada'),
('Henry Gold', 'henrygold10@example.com', '101 Brandenburg St', 'Berlin', 'Germany'),
('Ivy Silver', 'ivysilver11@example.com', '202 Sakura Ave', 'Tokyo', 'Japan'),
('Jack Rose', 'jackrose12@example.com', '303 Champs-Élysées', 'Paris', 'France'),
('Kathy Yellow', 'kathyyellow13@example.com', '404 Gateway of India Rd', 'Mumbai', 'India'),
('Leo Grey', 'leogrey14@example.com', '505 Table Mountain Rd', 'Cape Town', 'South Africa'),
('Mona Purple', 'monapurple15@example.com',  '1212 Walnut St', 'Las Vegas', 'USA'),
('Nathan Pink', 'nathanpink16@example.com',  '1313 Chestnut St', 'San Diego', 'USA'),
('Olivia Cyan', 'oliviacyan17@example.com',  '1414 Pine St', 'Miami', 'USA'),
('Paul Orange', 'paulorange18@example.com',  '1515 Oak St', 'Houston', 'USA'),
('Quincy Brown', 'quincybrown19@example.com',  '1616 Maple St', 'Austin', 'USA'),
('Rachel Indigo', 'rachelingo20@example.com',  '1717 Birch St', 'Portland', 'USA'),
('Steve Black', 'steveblack21@example.com',  '1818 Cedar St', 'Seattle', 'USA'),
('Tina White', 'tinawhite22@example.com',  '1919 Walnut St', 'Chicago', 'USA'),
('Ursula Grey', 'ursulagrey23@example.com',  '2020 Chestnut St', 'Dallas', 'USA'),
('Victor Blue', 'victorblue24@example.com',  '2121 Pine St', 'Denver', 'USA'),
('Willie Silver', 'williesilver25@example.com', '2222 Oak St', 'Boston', 'USA'),
('Xena Green', 'xenagreen26@example.com', '2323 Maple St', 'Los Angeles', 'USA'),
('Yara Red', 'yarared27@example.com', '2424 Birch St', 'San Francisco', 'USA'),
('Zane Yellow', 'zaneyellow28@example.com', '2525 Cedar St', 'Phoenix', 'USA'),
('Aiden White', 'aidenwhite29@example.com', '2626 Walnut St', 'Portland', 'USA'),
('Bella Pink', 'bellapink30@example.com', '2727 Chestnut St', 'Seattle', 'USA'),
('Cameron Cyan', 'cameroncyan31@example.com', '2828 Pine St', 'Austin', 'USA'),
('Daniel Rose', 'danielrose32@example.com', '2929 Oak St', 'Miami', 'USA'),
('Emily Grey', 'emilygrey33@example.com',  '3030 Maple St', 'Dallas', 'USA'),
('Felix Black', 'felixblack34@example.com', '3131 Birch St', 'Los Angeles', 'USA'),
('Gabriella Silver', 'gabriellasilver35@example.com','3232 Cedar St', 'Chicago', 'USA'),
('Holly Brown', 'hollybrown36@example.com', '3333 Walnut St', 'San Diego', 'USA'),
('Ian Orange', 'ianorange37@example.com', '3434 Chestnut St', 'San Francisco', 'USA'),
('Jared Green', 'jaredgreen38@example.com', '3535 Pine St', 'Phoenix', 'USA'),
('Kate Red', 'katered39@example.com', '3636 Oak St', 'Portland', 'USA'),
('Leo Blue', 'leoblue40@example.com', '3737 Maple St', 'Miami', 'USA'),
('Maya Pink', 'mayapink41@example.com', '3838 Birch St', 'Houston', 'USA'),
('Nina White', 'ninawhite42@example.com', '3939 Cedar St', 'Boston', 'USA'),
('Oscar Yellow', 'oscaryellow43@example.com', '101 Orchard Rd', 'Singapore', 'Singapore'),
('Penny Brown', 'pennybrown44@example.com', '202 Nathan Rd', 'Hong Kong', 'China'),
('Quinn Green', 'quinngreen45@example.com', '303 BTS Skytrain St', 'Bangkok', 'Thailand'),
('Rachel Cyan', 'rachelcyan46@example.com', '404 Shibuya Crossing', 'Tokyo', 'Japan'),
('Samantha Blue', 'samanthablue47@example.com', '505 Dongdaemun St', 'Seoul', 'South Korea'),
('Tom Rose', 'tomrose48@example.com', '606 Gateway Rd', 'Mumbai', 'India'),
('Ursula Pink', 'ursulapink49@example.com', '707 Jalan Sudirman', 'Jakarta', 'Indonesia'),
('Vera White', 'verawhite50@example.com', '808 Makati Ave', 'Manila', 'Philippines'),
('Walter Grey', 'waltergrey51@example.com', '909 Binh Thanh St', 'Ho Chi Minh City', 'Vietnam'),
('Xander Black', 'xanderblack52@example.com', '1010 Marina Bay St', 'Singapore', 'Singapore'),
('Yasmin Green', 'yasmingreen53@example.com', '1111 Asakusa St', 'Tokyo', 'Japan'),
('Zachary Yellow', 'zacharyyellow54@example.com', '1212 Lujiazui Rd', 'Shanghai', 'China'),
('Ava Brown', 'avabrown55@example.com', '1313 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Brock Rose', 'brockrose56@example.com', '1414 Nguyen Hue St', 'Hanoi', 'Vietnam'),
('Chloe Blue', 'chloeblue57@example.com', '1515 Rajadamnern Ave', 'Bangkok', 'Thailand'),
('Dylan Green', 'dylangreen58@example.com', '1616 Orchard Rd', 'Singapore', 'Singapore'),
('Eva White', 'evawhite59@example.com', '1717 Dong Khoi St', 'Ho Chi Minh City', 'Vietnam'),
('Finn Grey', 'finngrey60@example.com', '1818 Itaewon Rd', 'Seoul', 'South Korea'),
('Gina Cyan', 'ginacyan61@example.com', '1919 Zhongshan Rd', 'Guangzhou', 'China'),
('Hugo Red', 'hugored62@example.com', '5959 Chestnut St', 'Dallas', 'USA'),
('Iris Yellow', 'irisyellow63@example.com', '6060 Pine St', 'Miami', 'USA'),
('Jackie Pink', 'jackiepink64@example.com', '6161 Oak St', 'Houston', 'USA'),
('Keith Blue', 'keithblue65@example.com', '6262 Maple St', 'San Francisco', 'USA'),
('Liam Brown', 'liambrown66@example.com', '6363 Birch St', 'Austin', 'USA'),
('Mia White', 'miawhite67@example.com','6464 Chestnut St', 'Phoenix', 'USA'),
('Noah Green', 'noahgreen68@example.com','6565 Pine St', 'Portland', 'USA'),
('Olivia Rose', 'oliviarose69@example.com','6666 Oak St', 'Chicago', 'USA'),
('Paul Cyan', 'paulcyan70@example.com', '6767 Maple St', 'Seattle', 'USA'),
('Quincy Yellow', 'quincyyellow71@example.com', '6868 Birch St', 'Dallas', 'USA'),
('Riley Red', 'rileyred72@example.com','6969 Chestnut St', 'New York', 'USA'),
('Sophia Blue', 'sophiablue73@example.com', '7070 Pine St', 'San Diego', 'USA'),
('Theo Green', 'theogreen74@example.com', '7171 Oak St', 'Portland', 'USA'),
('Ursula Yellow', 'ursulayellow75@example.com','7272 Maple St', 'Miami', 'USA'),
('Violet White', 'violetwhite76@example.com','7373 Birch St', 'Dallas', 'USA'),
('Wendy Brown', 'wendybrown77@example.com','7474 Chestnut St', 'Phoenix', 'USA'),
('Xander Pink', 'xanderpink78@example.com','7575 Pine St', 'Los Angeles', 'USA'),
('Yara Grey', 'yaragrey79@example.com', '7676 Oak St', 'Chicago', 'USA'),
('Zoe Blue', 'zoeblue80@example.com', '7777 Maple St', 'Austin', 'USA'),
('Amos Green', 'amosgreen81@example.com', '7878 Birch St', 'Miami', 'USA'),
('Bella Black', 'bellablack82@example.com', '7979 Chestnut St', 'Houston', 'USA'),
('Carlos Red', 'carlosred83@example.com', '8080 Pine St', 'Portland', 'USA'),
('Diana Yellow', 'dianayellow84@example.com','8181 Oak St', 'San Francisco', 'USA'),
('Ethan Rose', 'ethanrose85@example.com', '8282 Maple St', 'Dallas', 'USA'),
('Fiona White', 'fionawhite86@example.com', '8383 Birch St', 'New York', 'USA'),
('George Blue', 'georgeblue87@example.com',  '8484 Chestnut St', 'Los Angeles', 'USA'),
('Holly Pink', 'hollypink88@example.com',  '8585 Pine St', 'San Diego', 'USA'),
('Ivy Black', 'ivyblack89@example.com',  '8686 Oak St', 'Houston', 'USA'),
('Jack Yellow', 'jackyellow90@example.com',  '8787 Maple St', 'Chicago', 'USA'),
('Kathy Green', 'kathygreen91@example.com',  '8888 Birch St', 'Phoenix', 'USA'),
('Liam Red', 'liamred92@example.com', '8989 Chestnut St', 'Portland', 'USA'),
('Molly Blue', 'mollyblue93@example.com', '9090 Pine St', 'San Francisco', 'USA'),
('Nina White', 'ninawhite94@example.com', '9191 Oak St', 'Austin', 'USA'),
('Oscar Grey', 'oscargrey95@example.com', '9292 Maple St', 'Miami', 'USA'),
('Paul Pink', 'paulpink96@example.com',  '9393 Birch St', 'Seattle', 'USA'),
('Quinn Cyan', 'quinncyan97@example.com', '9494 Chestnut St', 'Portland', 'USA'),
('Riley Green', 'rileygreen98@example.com', '9595 Pine St', 'Dallas', 'USA'),
('Sophia Yellow', 'sophiayellow99@example.com', '9696 Oak St', 'Chicago', 'USA'),
('Tommy Red', 'tommyred100@example.com', '101 Orchard Rd', 'Singapore', 'Singapore'),
('Alice Davis', 'alicedavis101@example.com', '202 Nathan Rd', 'Hong Kong', 'China'),
('Bradley Miller', 'bradleymiller102@example.com', '303 Shibuya Crossing', 'Tokyo', 'Japan'),
('Caitlyn Lewis', 'caitlynlewis103@example.com', '404 Dongdaemun St', 'Seoul', 'South Korea'),
('David Harris', 'davidharris104@example.com', '505 Jalan Sudirman', 'Jakarta', 'Indonesia'),
('Ella Clark', 'ellaclark105@example.com', '606 Gateway Rd', 'Mumbai', 'India'),
('Finn Walker', 'finnwalker106@example.com', '707 Zhongshan Rd', 'Guangzhou', 'China'),
('Grace Scott', 'gracescott107@example.com', '808 Binh Thanh St', 'Ho Chi Minh City', 'Vietnam'),
('Hugo Allen', 'hugoallen108@example.com', '909 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Ivy Martinez', 'ivymartinez109@example.com', '1010 Makati Ave', 'Manila', 'Philippines'),
('Jack Smith', 'jacksmith110@example.com', '1111 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('Kara Taylor', 'karataylor111@example.com', '1212 Rajadamnern Rd', 'Bangkok', 'Thailand'),
('Liam Adams', 'liamadams112@example.com', '1313 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Mason Carter', 'masoncarter113@example.com', '1414 Asakusa St', 'Tokyo', 'Japan'),
('Nina Walker', 'ninawalker114@example.com', '1515 Orchard Rd', 'Singapore', 'Singapore'),
('Oliver Young', 'oliveryoung115@example.com', '1616 Nathan Rd', 'Hong Kong', 'China'),
('Penny Hernandez', 'pennyhernandez116@example.com', '1717 Zhongshan Rd', 'Shanghai', 'China'),
('Quinn Edwards', 'quinnedwards117@example.com', '1818 Sakura Ave', 'Tokyo', 'Japan'),
('Ryan Lee', 'ryanlee118@example.com', '1919 Marina Bay Rd', 'Singapore', 'Singapore'),
('Sophia King', 'sophiaking119@example.com', '2020 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Toby Harris', 'tobyharris120@example.com', '2121 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Uma Thompson', 'umathompson121@example.com', '2222 Gateway Rd', 'Mumbai', 'India'),
('Vera Brooks', 'verabrooks122@example.com', '2323 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('William Cooper', 'williamcooper123@example.com', '2424 Makati Ave', 'Manila', 'Philippines'),
('Xander Ross', 'xandeross124@example.com', '2525 Rajadamnern Rd', 'Bangkok', 'Thailand'),
('Yvonne Green', 'yvonnegreen125@example.com', '2626 Nathan Rd', 'Hong Kong', 'China'),
('Zoe Wright', 'zoewright126@example.com', '2727 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Adam Mitchell', 'adammitchell127@example.com', '2828 Zhongshan Rd', 'Guangzhou', 'China'),
('Bella Wood', 'bellawood128@example.com', '2929 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Charlie Carter', 'charliecarter129@example.com', '3030 Orchard Rd', 'Singapore', 'Singapore'),
('Diana Clark', 'dianaclark130@example.com', '3131 Jalan Sudirman', 'Jakarta', 'Indonesia'),
('Ethan Foster', 'ethanfoster131@example.com', '3232 Gateway Rd', 'Mumbai', 'India'),
('Fiona Coleman', 'fionacoleman132@example.com', '3333 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('George King', 'georgeking133@example.com', '3434 Nathan Rd', 'Hong Kong', 'China'),
('Hailey Williams', 'haileywilliams134@example.com', '3535 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Ian Bell', 'ianbell135@example.com', '3636 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Jenna Lee', 'jennalee136@example.com', '3737 Zhongshan Rd', 'Shanghai', 'China'),
('Kyle Davis', 'kyledavis137@example.com', '3838 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Laura Wright', 'laurawright138@example.com', '3939 Marina Bay Rd', 'Singapore', 'Singapore'),
('Mason Clark', 'masonclark139@example.com', '4040 Orchard Rd', 'Singapore', 'Singapore'),
('Nina Adams', 'ninaadams140@example.com', '101 Orchard Rd', 'Singapore', 'Singapore'),
('Oscar Nelson', 'osarnelson141@example.com', '202 Nathan Rd', 'Hong Kong', 'China'),
('Paige Taylor', 'paigetaylor142@example.com', '303 Shibuya Crossing', 'Tokyo', 'Japan'),
('Quinn Harris', 'quinnharris143@example.com', '404 Dongdaemun St', 'Seoul', 'South Korea'),
('Ruby Moore', 'rubymoore144@example.com', '505 Jalan Sudirman', 'Jakarta', 'Indonesia'),
('Sam Roberts', 'samroberts145@example.com', '606 Gateway Rd', 'Mumbai', 'India'),
('Tess Scott', 'tessscott146@example.com', '707 Zhongshan Rd', 'Shanghai', 'China'),
('Uriah Lewis', 'uriahlewis147@example.com', '808 Binh Thanh St', 'Ho Chi Minh City', 'Vietnam'),
('Violet Green', 'violetgreen148@example.com', '909 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('William Brooks', 'williambrooks149@example.com', '1010 Makati Ave', 'Manila', 'Philippines'),
('Xander Thomas', 'xanderthomas150@example.com', '1111 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('Yasmin Patel', 'yasminpatel151@example.com', '1212 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Zachary Scott', 'zacharyscott152@example.com', '1313 Asakusa St', 'Tokyo', 'Japan'),
('Angela Morris', 'angelamorris153@example.com', '1414 Orchard Rd', 'Singapore', 'Singapore'),
('Brad White', 'bradwhite154@example.com', '1515 Nathan Rd', 'Hong Kong', 'China'),
('Carmen Roberts', 'carmenroberts155@example.com', '1616 Zhongshan Rd', 'Guangzhou', 'China'),
('Dexter Jones', 'dexterjones156@example.com', '1717 Sakura Ave', 'Tokyo', 'Japan'),
('Ethan Collins', 'ethancollins157@example.com', '1818 Marina Bay Rd', 'Singapore', 'Singapore'),
('Felicity Parker', 'felicityparker158@example.com', '1919 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Gabriel Rivera', 'gabrielrivera159@example.com', '2020 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Holly Campbell', 'hollycampbell160@example.com', '2121 Gateway Rd', 'Mumbai', 'India'),
('Ivan Bennett', 'ivanbennett161@example.com', '2222 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('Jackie Hall', 'jackiehall162@example.com', '2323 Makati Ave', 'Manila', 'Philippines'),
('Kara Allen', 'karaallen163@example.com', '2424 Rajadamnern Rd', 'Bangkok', 'Thailand'),
('Liam Campbell', 'liamcampbell164@example.com', '2525 Nathan Rd', 'Hong Kong', 'China'),
('Maya Martin', 'mayamartin165@example.com', '2626 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Noah Thompson', 'noahthompson166@example.com', '2727 Zhongshan Rd', 'Guangzhou', 'China'),
('Olivia Edwards', 'oliviaedwards167@example.com', '2828 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Peter Ross', 'peteross168@example.com', '2929 Orchard Rd', 'Singapore', 'Singapore'),
('Quinn Wright', 'quinnwright169@example.com', '3030 Jalan Sudirman', 'Jakarta', 'Indonesia'),
('Rachel Ward', 'rachelward170@example.com', '3131 Gateway Rd', 'Mumbai', 'India'),
('Steven Harris', 'stevenharris171@example.com', '3232 BTS Skytrain Rd', 'Bangkok', 'Thailand'),
('Tracy Evans', 'tracyevans172@example.com', '3333 Makati Ave', 'Manila', 'Philippines'),
('Ursula Davis', 'ursuladavis173@example.com', '3434 Nathan Rd', 'Hong Kong', 'China'),
('Vera Scott', 'verascott174@example.com', '3535 Dong Khoi Rd', 'Ho Chi Minh City', 'Vietnam'),
('Willie King', 'willieking175@example.com', '3636 Zhongshan Rd', 'Guangzhou', 'China'),
('Xander Moore', 'xandermoore176@example.com', '3737 Orchard Rd', 'Singapore', 'Singapore'),
('Yvonne Green', 'yvonnegreen177@example.com', '3838 Jalan Petaling', 'Kuala Lumpur', 'Malaysia'),
('Zane Morgan', 'zanemorgan178@example.com', '3939 Dongdaemun Rd', 'Seoul', 'South Korea'),
('Alice Harris', 'aliceharris179@example.com', '4040 Marina Bay Rd', 'Singapore', 'Singapore'),
('Blake Walker', 'blakewalker180@example.com', '4141 Nathan Rd', 'Hong Kong', 'China'),
('Abigail Peterson', 'abigailpeterson181@example.com', '4242 Zhongshan Rd', 'Shanghai', 'China'),
('Brian Lee', 'brianlee182@example.com', '1082 Walnut St', 'Phoenix', 'USA'),
('Caitlin White', 'caitlinwhite183@example.com', '1083 Pine St', 'Los Angeles', 'USA'),
('Daniel Green', 'danielgreen184@example.com', '1084 Oak St', 'Dallas', 'USA'),
('Eva Smith', 'evasmith185@example.com', '1085 Maple St', 'Toronto', 'Canada'),
('Frederick Mitchell', 'frederickmitchell186@example.com', '1086 Birch St', 'Vancouver', 'Canada'),
('Georgia Thomas', 'georgiathomas187@example.com', '1087 Chestnut St', 'London', 'UK'),
('Henry Robinson', 'henryrobinson188@example.com', '1088 Walnut St', 'Birmingham', 'UK'),
('Isla Allen', 'islaallen189@example.com', '1089 Pine St', 'Sydney', 'Australia'),
('Jack Dawson', 'jackdawson190@example.com',  '1090 Oak St', 'Melbourne', 'Australia'),
('Kelsey Carter', 'kelseycarter191@example.com',  '1091 Maple St', 'Berlin', 'Germany'),
('Lucas Harris', 'lucasharris192@example.com',  '1092 Birch St', 'Munich', 'Germany'),
('Madeline Cook', 'madelinecook193@example.com',  '1093 Chestnut St', 'Paris', 'France'),
('Nate Scott', 'natescott194@example.com', '1094 Walnut St', 'Marseille', 'France'),
('Olivia Turner', 'oliviaturner195@example.com',  '1095 Pine St', 'Madrid', 'Spain'),
('Paul Fisher', 'paulfisher196@example.com',  '1096 Oak St', 'Barcelona', 'Spain'),
('Quincy Davis', 'quincydavis197@example.com',  '1097 Maple St', 'Rome', 'Italy'),
('Riley Reed', 'rileyreed198@example.com',  '1098 Birch St', 'Milan', 'Italy'),
('Sophie Clark', 'sophieclark199@example.com', '1099 Chestnut St', 'Amsterdam', 'Netherlands'),
('Tyler Baker', 'tylerbaker200@example.com',  '1100 Walnut St', 'Rotterdam', 'Netherlands');
UPDATE Users
SET JoinedDate = DATE_ADD(
    '2010-01-01',
    INTERVAL FLOOR(RAND() * (DATEDIFF('2024-12-13', '2010-01-01'))) DAY
);

INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
	('Map of the Soul: 7', '2020-02-21', 3, 4, 20),
	('BE', '2020-11-20', 3, 4, 8),
	('Love Yourself: Answer', '2018-08-24', 3, 4, 26),
	('Wings', '2016-10-10', 3, 4, 15),
	('Dark & Wild', '2014-08-19', 3, 4, 14),
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
	('Dangerous Woman', '2016-05-20', 13, 1, 15),
    ('The Rise and Fall of Ziggy Stardust', '1972-06-16', 50, 50, 11),
    ('Acústico MTV [Live]', '1999-05-15', 19, 19, 13),
    ('Cidade Negra - Hits', '1999-07-22', 19, 19, 15),
    ('Na Pista', '2001-11-10', 20, 20, 12),
    ('Axé Bahia 2001', '2001-02-10', 21, 21, 14),
    ('BBC Sessions [Disc 1] [Live]', '1997-11-11', 22, 22, 12),
    ('Bongo Fury', '1975-10-02', 23, 23, 10),
    ('Carnaval 2001', '2001-03-10', 21, 21, 15),
    ('Chill: Brazil (Disc 1)', '2002-04-12', 24, 24, 13),
    ('Chill: Brazil (Disc 2)', '2002-04-12', 6, 13, 13),
    ('Garage Inc. (Disc 1)', '1998-11-24', 50, 50, 11),
    ('Greatest Hits II', '1991-10-28', 51, 51, 17),
    ('Greatest Kiss', '1997-04-08', 52, 52, 20),
    ('Heart of the Night', '1998-06-15', 53, 53, 16),
    ('International Superhits', '2001-11-13', 54, 54, 21),
    ('Into The Light', '2007-06-05', 55, 55, 11),
    ('Meus Momentos', '1998-08-12', 56, 56, 15),
    ('Minha História', '2001-09-25', 57, 57, 17),
    ('MK III The Final Concerts [Disc 1]', '1996-03-19', 58, 58, 14),
    ('Physical Graffiti [Disc 1]', '1975-02-24', 22, 22, 15),
    ('Sambas De Enredo 2001', '2001-01-10', 21, 21, 20),
    ('Supernatural', '1999-06-15', 59, 59, 13),
    ('The Best of Ed Motta', '2000-08-22', 37, 37, 12),
    ('The Essential Miles Davis [Disc 1]', '2001-05-15', 68, 68, 8),
    ('The Essential Miles Davis [Disc 2]', '2001-05-15', 68, 68, 9),
    ('The Final Concerts (Disc 2)', '1996-03-19', 58, 58, 14),
    ('Up An'' Atom', '2007-08-30', 69, 69, 10),
    ('Vinícius De Moraes - Sem Limite', '1998-11-17', 70, 70, 13),
    ('Vozes do MPB', '1998-09-12', 21, 21, 16),
    ('Chronicle, Vol. 1', '1976-01-01', 76, 76, 20),
    ('Chronicle, Vol. 2', '1986-06-25', 76, 76, 20),
    ('Cássia Eller - Coleção Sem Limite [Disc 2]', '2001-03-18', 77, 77, 14),
    ('Cássia Eller - Sem Limite [Disc 1]', '2001-03-18', 77, 77, 14),
    ('Come Taste The Band', '1975-10-10', 58, 58, 10),
    ('Deep Purple In Rock', '1970-06-03', 58, 58, 9),
    ('Fireball', '1971-07-09', 58, 58, 7),
    ('Knocking at Your Back Door: The Best Of Deep Purple in the 80''s', '1992-02-03', 58, 58, 14),
    ('Machine Head', '1972-03-25', 58, 58, 7),
    ('Purpendicular', '1996-02-17', 58, 58, 10),
    ('Slaves And Masters', '1990-10-05', 58, 58, 9),
    ('Stormbringer', '1974-12-10', 58, 58, 9),
    ('The Battle Rages On', '1993-07-19', 58, 58, 10),
    ('Vault: Def Leppard''s Greatest Hits', '1995-10-31', 78, 78, 15),
    ('Outbreak', '2007-01-12', 79, 79, 12),
    ('Djavan Ao Vivo - Vol. 02', '1999-12-10', 80, 80, 14),
    ('Djavan Ao Vivo - Vol. 1', '1999-12-10', 80, 80, 13),
    ('Elis Regina-Minha História', '1990-03-19', 41, 41, 16),
    ('The Cream Of Clapton', '1995-03-07', 81, 81, 18),
    ('Unplugged', '1992-08-25', 81, 81, 13),
    ('Album Of The Year', '1997-06-03', 82, 82, 12),
    ('King For A Day Fool For A Lifetime', '1995-03-14', 82, 82, 12),
    ('The Real Thing', '1989-06-20', 82, 82, 11),
    ('Deixa Entrar', '2003-05-01', 83, 83, 13),
    ('In Your Honor [Disc 1]', '2005-06-14', 84, 84, 10),
    ('In Your Honor [Disc 2]', '2005-06-14', 84, 84, 10),
    ('One By One', '2002-10-22', 84, 84, 11),
    ('The Colour And The Shape', '1997-05-20', 84, 84, 13),
    ('My Way: The Best Of Frank Sinatra [Disc 1]', '1997-10-14', 85, 85, 15),
    ('Roda De Funk', '1999-06-25', 86, 86, 10);
INSERT INTO Playlists (PlaylistName, CreatedDate, UserID)
SELECT 
    PlaylistName,
    DATE_ADD(Users.JoinedDate, INTERVAL FLOOR(RAND() * 365) + 1 DAY) AS CreatedDate,
    Users.UserID
FROM 
    (SELECT 
        'The Ultimate Rock Classics Playlist for Every Mood 836' AS PlaylistName, 1 AS UserID
    UNION
        SELECT 'Chill Vibes for a Perfect Evening with Friends 713', 2
    UNION
        SELECT 'Essential Jazz Tracks to Relax and Unwind 894', 3
    UNION
        SELECT 'Summer Hits to Keep You Dancing All Day 142', 4
    UNION
        SELECT 'Indie Beats to Enhance Your Creative Mindset 451', 5
    UNION
        SELECT 'Party Playlist for an Unforgettable Night Out 274', 6
    UNION
        SELECT 'Relaxing Tunes to Calm Your Soul After a Busy Day 634', 7
    UNION
        SELECT 'Workout Motivation with High-Energy Songs 852', 8
    UNION
        SELECT 'Classical Masterpieces to Set the Perfect Mood 319', 9
    UNION
        SELECT 'Throwback Hits from the 90s to Relive Your Youth 915', 10
    UNION
        SELECT 'Mood Boosters to Lift Your Spirits in Any Situation 451', 11
    UNION
        SELECT 'Romantic Playlist for a Cozy Night with Someone Special 813', 12
    UNION
        SELECT 'Morning Coffee and Chill Tunes to Start Your Day Right 204', 13
    UNION
        SELECT 'Dance Party Playlist for the Best Moves All Night Long 489', 14
    UNION
        SELECT 'Rock and Roll Anthems to Pump Up Your Energy 392', 15
    UNION
        SELECT 'Acoustic Favorites for a Cozy Afternoon at Home 932', 16
    UNION
        SELECT 'Hip Hop Beats to Feel the Rhythm of the Streets 557', 17
    UNION
        SELECT 'Relaxing Piano Melodies for a Peaceful Evening 661', 18
    UNION
        SELECT 'Pop Hits for Every Celebration and Good Time 930', 19
    UNION
        SELECT 'Road Trip Tunes for Your Next Adventure 168', 20
    UNION
        SELECT 'Chill Jazz to Wind Down and Enjoy the Night 315', 21
    UNION
        SELECT 'R&B Vibes for a Smooth and Sexy Evening 110', 22
    UNION
        SELECT 'Night Drive Playlist to Keep You Energized After Dark 852', 23
    UNION
        SELECT 'Indie Rock Essentials for a Refreshing Sound 583', 24
    UNION
        SELECT 'Electronic Dance Music for an Epic Party Vibe 274', 25
    UNION
        SELECT 'Motivational Mix to Get You Through the Toughest Days 901', 26
    UNION
        SELECT 'Old School Hip Hop Classics to Feel the Beat 745', 27
    UNION
        SELECT 'Relaxing Mornings with Soft Tunes to Start Your Day 426', 28
    UNION
        SELECT 'Chillhop Beats for the Perfect Study Session 719', 29
    UNION
        SELECT 'Ambient Sounds for a Perfect Meditation Experience 202', 30
    UNION
        SELECT 'Fresh Pop Tracks to Keep You Moving 543', 31
    UNION
        SELECT 'Rock Ballads to Touch Your Heart 352', 32
    UNION
        SELECT 'Classic Country Hits to Relive the Glory Days 763', 33
    UNION
        SELECT 'Latin Rhythms for a Dance Party 119', 34
    UNION
        SELECT 'Guitar Solo Magic to Impress the Crowd 459', 35
    UNION
        SELECT 'Electric Blues for a Soulful Evening 560', 36
    UNION
        SELECT 'Piano Solos for a Reflective Afternoon 349', 37
    UNION
        SELECT 'Instrumental Chillout for Focused Work 894', 38
    UNION
        SELECT 'Epic Movie Soundtracks to Feel Like a Hero 820', 39
    UNION
        SELECT 'Ska and Reggae for a Relaxed Vibe 312', 40
    UNION
        SELECT 'Fresh Indie Discoveries for Every Mood 293', 41
    UNION
        SELECT 'Synthwave Hits to Get Lost in Time 501', 42
    UNION
        SELECT 'Classical Music for Study and Focus 854', 43
    UNION
        SELECT 'Folk Songs for a Peaceful Getaway 660', 44
    UNION
        SELECT 'Experimental Sounds for Open Minds 439', 45
    UNION
        SELECT 'Classic Rock Hits to Keep You Pumped Up 233', 46
    UNION
        SELECT 'Top 40 Pop Hits for Every Party 512', 47
    UNION
        SELECT 'Funky Grooves for a Feel-Good Day 320', 48
    UNION
        SELECT 'Groovy Beats for an Afternoon Chillout 175', 49
    UNION
        SELECT 'Vocal Jazz for Relaxing Moments 586', 50
    UNION
        SELECT 'Alternative Rock Gems for a Fresh Sound 302', 51
    UNION
        SELECT 'Dream Pop Playlist for Peaceful Nights 203', 52
    UNION
        SELECT 'Lo-fi Chill Beats for Studying or Relaxing 104', 53
    UNION
        SELECT 'Top Reggae Hits to Set the Island Vibes 309', 54
    UNION
        SELECT 'Electronic Chillout for a Modern Relaxation 248', 55
    UNION
        SELECT 'Metal Anthems to Fuel Your Energy 981', 56
    UNION
        SELECT 'Country Duets for a Romantic Evening 742', 57
    UNION
        SELECT 'Indie Folk for a Calming Escape 150', 58
    UNION
        SELECT 'Symphonic Masterpieces to Amaze Your Ears 421', 59
    UNION
        SELECT 'Progressive Rock for an Epic Journey 389', 60
    UNION
        SELECT 'Hip Hop Classics for Old-School Vibes 557', 61
    UNION
        SELECT 'Jazz Fusion Tracks to Impress Your Friends 389', 62
    UNION
        SELECT 'The Best of 80s Dance Music 240', 63
    UNION
        SELECT 'World Music for a Cultural Experience 190', 64
    UNION
        SELECT 'Acoustic Love Songs for Special Moments 899', 65
    UNION
        SELECT 'Pop Punk Hits to Revive Your Teenage Spirit 162', 66
	    UNION
        SELECT 'Pop Rock Favorites for a Nostalgic Night', 67
    UNION
        SELECT 'Soulful Ballads to Ease Your Mind', 68
    UNION
        SELECT 'Groove Essentials for Funk Lovers', 69
    UNION
        SELECT 'Country Road Trip Playlist', 70
    UNION
        SELECT 'Electronic Chill Beats for Creative Work', 71
    UNION
        SELECT 'Feel-Good Acoustic Covers', 72
    UNION
        SELECT 'High-Energy EDM Party Mix', 73
    UNION
        SELECT 'Blues Legends: The Best of All Time', 74
    UNION
        SELECT 'Vocal Harmony Gems', 75
    UNION
        SELECT 'Alternative Hits for an Adventurous Mood', 76
    UNION
        SELECT 'Pop Ballads to Sing Along', 77
    UNION
        SELECT 'Classic Opera Arias for a Majestic Feel', 78
    UNION
        SELECT 'Indie Favorites for Music Explorers', 79
    UNION
        SELECT 'Rock and Blues Crossover Classics', 80
    UNION
        SELECT 'Summer Chill: The Ultimate Beach Playlist', 81
    UNION
        SELECT 'Smooth Jazz Vibes for Cozy Nights', 82
    UNION
        SELECT 'Hip Hop Party Anthems', 83
    UNION
        SELECT 'Meditative Tracks for Deep Focus', 84
    UNION
        SELECT 'Pop Hits from the 2000s', 85
    UNION
        SELECT 'Romantic Latin Ballads', 86
    UNION
        SELECT 'Psychedelic Rock Classics', 87
    UNION
        SELECT 'Electronic Lounge Music', 88
    UNION
        SELECT 'Power Ballads for a Heartfelt Journey', 89
    UNION
        SELECT 'Rising Indie Stars', 90
    UNION
        SELECT 'Afrobeats Rhythms for a Vibrant Dance', 91
    UNION
        SELECT 'Jazz Standards for the Perfect Dinner Party', 92
    UNION
        SELECT 'Grunge Rock Essentials', 93
    UNION
        SELECT 'Global Beats for a Worldly Experience', 94
    UNION
        SELECT 'Opera Duets for a Magical Evening', 95
    UNION
        SELECT 'K-Pop Favorites for Fans Worldwide', 96
    UNION
        SELECT 'Retro Hits from the 80s', 97
    UNION
        SELECT 'Singer-Songwriter Favorites', 98
    UNION
        SELECT 'Pop Divas: The Ultimate Playlist', 99
    UNION
        SELECT 'Relaxing Nature Sounds', 100
    UNION
        SELECT 'Bossa Nova Classics', 101
    UNION
        SELECT 'Dark Synthwave for Night Owls', 102
    UNION
        SELECT 'Gospel and Spiritual Favorites', 103
    UNION
        SELECT 'Irish Folk Songs for a Cultural Journey', 104
    UNION
        SELECT 'Garage Rock Revival', 105
    UNION
        SELECT 'Top Hits for a Workout Boost', 106
    UNION
        SELECT 'Broadway Showstoppers', 107
    UNION
        SELECT 'Epic Gaming Soundtracks', 108
    UNION
        SELECT 'Festival Anthems: Summer Edition', 109
    UNION
        SELECT 'Intense Metal for the Ultimate Energy', 110
    UNION
        SELECT 'Lush Instrumentals for Reflection', 111
    UNION
        SELECT 'Beachside Chill: The Ultimate Relaxation Mix', 112
    UNION
        SELECT 'Jazzy Christmas Classics', 113
    UNION
        SELECT 'R&B Throwbacks for the Soul', 114
    UNION
        SELECT 'Top Indie Rock Anthems', 115
    UNION
        SELECT 'Melodic Dubstep for Creative Flow', 116
    UNION
        SELECT 'Summer Reggae Party', 117
    UNION
        SELECT 'Symphonic Fantasy Adventures', 118
    UNION
        SELECT 'Dreamy Pop Tunes for a Chill Vibe', 119
    UNION
        SELECT 'Hardcore Rock Hits to Get You Moving', 120
    UNION
        SELECT 'Country Love Songs for a Romantic Night', 121
    UNION
        SELECT 'Peaceful Guitar Melodies for a Quiet Evening', 122
    UNION
        SELECT 'Epic Choral Performances', 123
    UNION
        SELECT 'Indie Electronic Explorations', 124
    UNION
        SELECT 'Big Band Swing Classics', 125
    UNION
        SELECT 'Blues Revival: Modern Takes on a Classic Genre', 126
    UNION
        SELECT 'Golden Age of Hollywood Soundtracks', 127
    UNION
        SELECT 'Feel-Good Anthems for Any Occasion', 128
    UNION
        SELECT 'Punk Rock Essentials', 129
    UNION
        SELECT 'World Fusion: A Cultural Melting Pot', 130
    UNION
        SELECT 'Acoustic Favorites for a Cozy Afternoon', 131
    UNION
        SELECT 'Upbeat K-Pop Party Mix', 132
    UNION
        SELECT 'Opera Highlights: The Greatest Moments', 133
    UNION
        SELECT 'Lo-fi Beats for Relaxed Vibes', 134
    UNION
        SELECT 'Vintage Jazz Club Hits', 135
    UNION
        SELECT 'Chill Electronic Vibes for the Perfect Sunset', 136
    UNION
        SELECT 'Guitar Heroes: Iconic Solos', 137
    UNION
        SELECT 'Funky Jazz Fusion', 138
    UNION
        SELECT 'Latin Dance Hits', 139
    UNION
        SELECT 'Alternative Pop Anthems', 140
    UNION
        SELECT 'Symphonic Metal Power Ballads', 141
    UNION
        SELECT 'Relaxing Binaural Beats', 142
    UNION
        SELECT 'Dreamy Synth Pop for a Retro Mood', 143
    UNION
        SELECT 'R&B Soul Revival', 144
    UNION
        SELECT 'Indie Acoustic Covers', 145
    UNION
        SELECT 'Upbeat Jazz Instrumentals', 146
    UNION
        SELECT 'Ambient Guitar Scapes', 147
    UNION
        SELECT 'Melancholy Tunes for Reflection', 148
    UNION
        SELECT 'Psybient Beats for Relaxed Energy', 149
    UNION
        SELECT 'Neo-Soul for a Modern Groove', 150) AS Playlists
JOIN 
    Users ON Users.UserID = Playlists.UserID;
UPDATE Playlists
SET UserID = FLOOR(1 + (RAND() * 200));
select * from Playlists;

INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
('Intro: Boy Meets Evil', 120, '2016-10-10', 'Korean', 4, 4),
('Blood Sweat & Tears', 217, '2016-10-10', 'Korean', 4, 4),
('Begin', 231, '2016-10-10', 'Korean', 4, 4),
('Lie', 217, '2016-10-10', 'Korean', 4, 4),
('Stigma', 218, '2016-10-10', 'Korean', 4, 4),
('First Love', 230, '2016-10-10', 'Korean', 4, 4),
('Reflection', 233, '2016-10-10', 'Korean', 4, 4),
('Mama', 218, '2016-10-10', 'Korean', 4, 4),
('Blue & Grey', 255, '2020-11-20', 'Korean', 2, 4),
('Telepathy', 202, '2020-11-20', 'Korean', 2, 4),
('Stay', 205, '2020-11-20', 'Korean', 2, 4),
('Dynamite', 199, '2020-11-20', 'English', 2, 4),
('Mine', 230, '2010-08-04', 'English', 38, 1),
('Back to December', 290, '2010-11-15', 'English', 38, 1),
('Speak Now', 244, '2010-10-25', 'English', 38, 1),
('Euphoria', 229, '2018-08-24', 'Korean', 3, 4),
('Trivia: Just Dance', 225, '2018-08-24', 'Korean', 3, 4),
('Serendipity', 276, '2018-08-24', 'Korean', 3, 4),
('DNA', 223, '2018-08-24', 'Korean', 3, 4),
('Fake Love', 242, '2018-08-24', 'Korean', 3, 4),
('IDOL', 222, '2018-08-24', 'Korean', 3, 4),
('Intro: Persona', 172, '2020-02-21', 'Korean', 1, 4),
('Boy With Luv', 229, '2020-02-21', 'Korean', 1, 4),
('Make It Right', 222, '2020-02-21', 'Korean', 1, 4),
('Jamais Vu', 226, '2020-02-21', 'Korean', 1, 4),
('Dionysus', 248, '2020-02-21', 'Korean', 1, 4),
('A Head Full of Dreams', 237, '2015-12-04', 'English', 2, 2),
('Birds', 236, '2015-12-04', 'English', 2, 2),
('Hymn for the Weekend', 258, '2016-01-25', 'English', 2, 2),
('Everglow', 245, '2015-12-04', 'English', 2, 2),
('Adventure of a Lifetime', 255, '2015-11-06', 'English', 2, 2),
('Fun', 266, '2015-12-04', 'English', 2, 2),
('Kaleidoscope', 110, '2015-12-04', 'English', 2, 2),
('Army of One', 295, '2015-12-04', 'English', 2, 2),
('Amazing Day', 246, '2015-12-04', 'English', 2, 2),
('Up&Up', 397, '2015-12-04', 'English', 2, 2),
('X Marks the Spot', 228, '2015-12-04', 'English', 2, 2),
('Pray You Catch Me', 213, '2016-04-23', 'English', 3, 4),
('Hold Up', 235, '2016-04-23', 'English', 3, 4),
('Don\'t Hurt Yourself', 223, '2016-04-23', 'English', 3, 4),
('Sorry', 236, '2016-04-23', 'English', 3, 4),
('6 Inch', 257, '2016-04-23', 'English', 3, 4),
('Daddy Lessons', 291, '2016-04-23', 'English', 3, 4),
('Love Drought', 239, '2016-04-23', 'English', 3, 4),
('Sandcastles', 218, '2016-04-23', 'English', 3, 4),
('Forward', 121, '2016-04-23', 'English', 3, 4),
('Freedom', 281, '2016-04-23', 'English', 3, 4),
('All Night', 282, '2016-04-23', 'English', 3, 4),
('Formation', 212, '2016-04-23', 'English', 3, 4),
('Formula of Love', 228, '2021-11-12', 'Korean', 23, 4),
('The Feels', 230, '2021-11-12', 'Korean', 23, 4),
('Perfect Love', 212, '2021-11-12', 'Korean', 23, 4),
('Chemistry', 235, '2021-11-12', 'Korean', 23, 4),
('Butterfly', 221, '2021-11-12', 'Korean', 23, 4),
('Kiss Me', 240, '2021-11-12', 'Korean', 23, 4),
('Love You', 213, '2021-11-12', 'Korean', 23, 4),
('Dreamer', 242, '2021-11-12', 'Korean', 23, 4),
('Hug Me', 218, '2021-11-12', 'Korean', 23, 4),
('All Night', 229, '2021-11-12', 'Korean', 23, 4),
('Feel It', 233, '2021-11-12', 'Korean', 23, 4),
('Into You', 226, '2021-11-12', 'Korean', 23, 4),
('Goodbye', 231, '2021-11-12', 'Korean', 23, 4),
('So Sweet', 214, '2021-11-12', 'Korean', 23, 4),
('The Last', 248, '2021-11-12', 'Korean', 23, 4),
('Tempo', 235, '2018-11-02', 'Korean', 24, 4),
('Boomerang', 218, '2018-11-02', 'Korean', 24, 4),
('Love Shot', 242, '2018-11-02', 'Korean', 24, 4),
('Bad Dream', 230, '2018-11-02', 'Korean', 24, 4),
('No Way', 217, '2018-11-02', 'Korean', 24, 4),
('Diamond', 220, '2018-11-02', 'Korean', 24, 4),
('What Is Love', 225, '2018-11-02', 'Korean', 24, 4),
('Fade', 213, '2018-11-02', 'Korean', 24, 4),
('Euphoria', 244, '2018-11-02', 'Korean', 24, 4),
('Love Me Right', 227, '2018-11-02', 'Korean', 24, 4),
('Save Me', 219, '2018-11-02', 'Korean', 24, 4),
('Star', 232, '2019-03-04', 'Korean', 25, 4),
('Dreaming', 224, '2019-03-04', 'Korean', 25, 4),
('Shine', 218, '2019-03-04', 'Korean', 25, 4),
('Tonight', 231, '2019-03-04', 'Korean', 25, 4),
('End of the World', 210, '2019-03-04', 'Korean', 25, 4),
('Wild Heart', 240, '2019-03-04', 'Korean', 25, 4),
('Happy Ending', 216, '2019-03-04', 'Korean', 25, 4),
('Skyline', 222, '2019-03-04', 'Korean', 25, 4),
('Light It Up', 233, '2019-03-04', 'Korean', 25, 4),
('Falling Star', 225, '2019-03-04', 'Korean', 25, 4),
('Palette', 247, '2017-04-21', 'Korean', 26, 4),
('Ailee', 232, '2017-04-21', 'Korean', 26, 4),
('I Like You', 213, '2017-04-21', 'Korean', 26, 4),
('Ginger', 241, '2017-04-21', 'Korean', 26, 4),
('May', 220, '2017-04-21', 'Korean', 26, 4),
('Heartbeat', 259, '2017-04-21', 'Korean', 26, 4),
('I Miss You', 227, '2017-04-21', 'Korean', 26, 4),
('Love On Top', 246, '2017-04-21', 'Korean', 26, 4),
('I Wish', 238, '2017-04-21', 'Korean', 26, 4),
('Falling', 234, '2017-04-21', 'Korean', 26, 4),
('Secret', 242, '2003-07-31', 'English', 27, 13),
('Forever', 251, '2003-07-31', 'English', 27, 13),
('Love Me', 263, '2003-07-31', 'English', 27, 13),
('Night', 215, '2003-07-31', 'English', 27, 13),
('Believe', 238, '2003-07-31', 'English', 27, 13),
('I Want You', 229, '2003-07-31', 'English', 27, 13),
('Unspoken', 257, '2003-07-31', 'English', 27, 13),
('Angel', 231, '2003-07-31', 'English', 27, 13),
('Faith', 245, '2003-07-31', 'English', 27, 13),
('Perfect', 240, '2003-07-31', 'English', 27, 13),
('True Love', 252, '2003-07-31', 'English', 27, 13),
('Shining Star', 249, '2003-07-31', 'English', 27, 13),
('Heartbeat', 212, '2015-01-12', 'English', 28, 3),
('Goodbye', 235, '2015-01-12', 'English', 28, 3),
('Daydream', 240, '2015-01-12', 'English', 28, 3),
('Tear', 224, '2015-01-12', 'English', 28, 3),
('Hopes Up', 219, '2015-01-12', 'English', 28, 3),
('One Heart', 211, '2015-01-12', 'English', 28, 3),
('Waves', 249, '2015-01-12', 'English', 28, 3),
('Miracle', 243, '2015-01-12', 'English', 28, 3),
('Home', 228, '2015-01-12', 'English', 28, 3),
('No Regrets', 252, '2015-01-12', 'English', 28, 3),
('Dreamer', 233, '2015-01-12', 'English', 28, 3),
('Sunrise', 165, '2019-11-22', 'English', 37, 3),
('Church', 212, '2019-11-22', 'English', 37, 3),
('Trouble in Town', 257, '2019-11-22', 'English', 37, 3),
('BrokEn', 155, '2019-11-22', 'English', 37, 3),
('Daddy', 255, '2019-11-22', 'English', 37, 3),
('WOTW / POTP', 90, '2019-11-22', 'English', 37, 3),
('Arabesque', 356, '2019-11-22', 'English', 37, 3),
('When I Need a Friend', 143, '2019-11-22', 'English', 37, 3),
('Guns', 121, '2019-11-22', 'English', 37, 3),
('Orphans', 231, '2019-10-24', 'English', 37, 3),
('Èkó', 155, '2019-11-22', 'English', 37, 3),
('Cry Cry Cry', 173, '2019-11-22', 'English', 37, 3),
('Old Friends', 129, '2019-11-22', 'English', 37, 3),
('Bani Adam', 247, '2019-11-22', 'English', 37, 3),
('Champion of the World', 261, '2019-11-22', 'English', 37, 3),
('Everyday Life', 244, '2019-11-22', 'English', 37, 3),
('Dear John', 406, '2010-10-25', 'English', 38, 1),
('Mean', 239, '2010-10-25', 'English', 38, 1),
('The Story of Us', 267, '2010-10-25', 'English', 38, 1),
('Enchanted', 361, '2010-10-25', 'English', 38, 1),
('Dangerous Woman', 233, '2016-05-20', 'English', 49, 1),
('Into You', 257, '2016-05-20', 'English', 49, 1),
('Side to Side', 230, '2016-05-20', 'English', 49, 1),
('Let Me Love You', 239, '2016-05-20', 'English', 49, 1),
('Greedy', 215, '2016-05-20', 'English', 49, 1),
('Leave Me Lonely', 243, '2016-05-20', 'English', 49, 1),
('Everyday', 228, '2016-05-20', 'English', 49, 1),
('Bad Decisions', 235, '2016-05-20', 'English', 49, 1),
('Touch It', 220, '2016-05-20', 'English', 49, 1),
('Moonlight', 215, '2016-05-20', 'English', 49, 1),
('Sometimes', 227, '2016-05-20', 'English', 49, 1),
('I Don’t Care', 215, '2016-05-20', 'English', 49, 1),
('Dangerous Woman (Reprise)', 210, '2016-05-20', 'English', 49, 1),
('Getting Older', 220, '2021-07-30', 'English', 11, 1),
('I Didn’t Change My Number', 230, '2021-07-30', 'English', 11, 1),
('Billie Bossa Nova', 204, '2021-07-30', 'English', 11, 1),
('My Future', 210, '2021-07-30', 'English', 11, 1),
('Oxytocin', 222, '2021-07-30', 'English', 11, 1),
('Goldwing', 237, '2021-07-30', 'English', 11, 1),
('Bad Habits', 230, '2021-06-25', 'English', 34, 1),
('Overpass Graffiti', 229, '2021-10-29', 'English', 34, 1),
('Shivers', 207, '2021-09-10', 'English', 34, 1),
('Visiting Hours', 199, '2021-08-19', 'English', 34, 1),
('First Times', 211, '2021-06-25', 'English', 34, 1),
('Lost Cause', 213, '2021-07-30', 'English', 11, 1),
('Halo', 219, '2021-07-30', 'English', 11, 1),
('Everybody Dies', 225, '2021-07-30', 'English', 11, 1),
('Your Power', 240, '2021-07-30', 'English', 11, 1),
('NDA', 215, '2021-07-30', 'English', 11, 1),
('Happier Than Ever', 235, '2021-07-30', 'English', 11, 1),
('Male Fantasy', 223, '2021-07-30', 'English', 11, 1),
('God’s Plan', 189, '2018-06-29', 'English', 4, 7),
('I’m Upset', 210, '2018-06-29', 'English', 4, 7),
('Mob Ties', 208, '2018-06-29', 'English', 4, 7),
('Nice For What', 240, '2018-06-29', 'English', 4, 7),
('Nonstop', 230, '2018-06-29', 'English', 4, 7),
('Summer Games', 259, '2018-06-29', 'English', 4, 7),
('Jaded', 220, '2018-06-29', 'English', 4, 7),
('Blinding Lights', 200, '2020-03-20', 'English', 6, 7),
('In Your Eyes', 215, '2020-03-20', 'English', 6, 7),
('Save Your Tears', 215, '2020-03-20', 'English', 6, 7),
('Heartless', 243, '2020-03-20', 'English', 6, 7),
('Too Late', 258, '2020-03-20', 'English', 6, 7),
('Scared to Live', 250, '2020-03-20', 'English', 6, 7),
('Believer', 204, '2017-06-23', 'English', 7, 2),
('Thunder', 210, '2017-06-23', 'English', 7, 2),
('Whatever It Takes', 215, '2017-06-23', 'English', 7, 2),
('I Don’t Know Why', 220, '2017-06-23', 'English', 7, 2),
('Mouth of the River', 225, '2017-06-23', 'English', 7, 2),
('Start Over', 230, '2017-06-23', 'English', 7, 2),
('Dancing in the Dark', 210, '2017-06-23', 'English', 7, 2),
('Rise Up', 218, '2017-06-23', 'English', 7, 2),
('Walking the Wire', 205, '2017-06-23', 'English', 7, 2),
('The Fall', 240, '2017-06-23', 'English', 7, 2),
('Green Light', 232, '2017-03-02', 'English', 41, 1),
('Sober', 198, '2017-06-16', 'English', 41, 1),
('Homemade Dynamite', 235, '2017-06-16', 'English', 41, 1),
('The Louvre', 269, '2017-06-16', 'English', 41, 1),
('Liability', 213, '2017-06-16', 'English', 41, 1),
('Hard Feelings / Lover', 361, '2017-06-16', 'English', 41, 1),
('Sober II (Melodrama)', 274, '2017-06-16', 'English', 41, 1),
('Writer in the Dark', 277, '2017-06-16', 'English', 41, 1),
('Supercut', 268, '2017-06-16', 'English', 41, 1),
('Delicate', 213, '2017-06-16', 'English', 41, 1),
('Perfect Places', 238, '2017-06-16', 'English', 41, 1),
('Slow Burn', 245, '2018-03-30', 'English', 42, 8),
('I Miss You', 222, '2018-03-30', 'English', 42, 8),
('Butterflies', 220, '2018-03-30', 'English', 42, 8),
('Love Is a Wild Thing', 233, '2018-03-30', 'English', 42, 8),
('Space Cowboy', 276, '2018-03-30', 'English', 42, 8),
('Happy & Sad', 229, '2018-03-30', 'English', 42, 8),
('Mother', 258, '2018-03-30', 'English', 42, 8),
('Oh, What a World', 241, '2018-03-30', 'English', 42, 8),
('Golden Hour', 276, '2018-03-30', 'English', 42, 8),
('Teenage Wildflower', 244, '2018-03-30', 'English', 42, 8),
('Wonder Woman', 221, '2018-03-30', 'English', 42, 8),
('Supermodel', 229, '2017-06-09', 'English', 43, 7),
('Love Galore', 264, '2017-04-07', 'English', 43, 7),
('Drew Barrymore', 285, '2017-06-09', 'English', 43, 7),
('Prom', 251, '2017-06-09', 'English', 43, 7),
('The Weekend', 241, '2017-06-09', 'English', 43, 7),
('Avenue', 200, '2017-06-09', 'English', 43, 7),
('Go Gina', 218, '2017-06-09', 'English', 43, 7),
('Broken Clocks', 230, '2017-06-09', 'English', 43, 7),
('Anything', 215, '2017-06-09', 'English', 43, 7),
('Normal Girl', 241, '2017-06-09', 'English', 43, 7),
('Pretty Little Birds', 229, '2017-06-09', 'English', 43, 7),
('Locked Out of Heaven', 209, '2012-12-07', 'English', 47, 1),
('When I Was Your Man', 200, '2012-12-07', 'English', 47, 1),
('Treasure', 217, '2012-12-07', 'English', 47, 1),
('Gorilla', 230, '2012-12-07', 'English', 47, 1),
('Young Girls', 212, '2012-12-07', 'English', 47, 1),
('Moonshine', 227, '2012-12-07', 'English', 47, 1),
('Our First Time', 216, '2012-12-07', 'English', 47, 1),
('Show Me', 210, '2012-12-07', 'English', 47, 1),
('If I Knew', 223, '2012-12-07', 'English', 47, 1),
('Money Make Her Smile', 235, '2012-12-07', 'English', 47, 1),
('Circles', 211, '2019-09-06', 'English', 9, 7),
('Wow.', 196, '2019-09-06', 'English', 9, 7),
('Goodbyes', 185, '2019-09-06', 'English', 9, 7),
('I Fall Apart', 232, '2019-09-06', 'English', 9, 7),
('Sunflower', 211, '2019-09-06', 'English', 9, 7),
('Enemies', 248, '2019-09-06', 'English', 9, 7),
('A Thousand Bad Times', 229, '2019-09-06', 'English', 9, 7),
('Staring at the Sun', 240, '2019-09-06', 'English', 9, 7),
('On the Road', 238, '2019-09-06', 'English', 9, 7),
('Die for Me', 225, '2019-09-06', 'English', 9, 7),
('Hollywoods Bleeding', 261, '2019-09-06', 'English', 9, 7),
('Psycho', 234, '2019-09-06', 'English', 9, 7),
('Take What You Want', 248, '2019-09-06', 'English', 9, 7),
('Wow. (Remix)', 210, '2019-09-06', 'English', 9, 7),
('Keep The Family Close', 227, '2016-04-29', 'English', 33, 7),
('9', 212, '2016-04-29', 'English', 33, 7),
('U With Me?', 238, '2016-04-29', 'English', 33, 7),
('Feel No Ways', 232, '2016-04-29', 'English', 33, 7),
('Hype', 228, '2016-04-29', 'English', 33, 7),
('Weston Road Flows', 249, '2016-04-29', 'English', 33, 7),
('Redemption', 211, '2016-04-29', 'English', 33, 7),
('With You', 226, '2016-04-29', 'English', 33, 7),
('Controlla', 221, '2016-04-29', 'English', 33, 7),
('One Dance', 198, '2016-04-29', 'English', 33, 7),
('Life of the Party', 205, '2018-05-25', 'English', 12, 1),
('Something Big', 212, '2018-05-25', 'English', 12, 1),
('Stitches', 220, '2018-05-25', 'English', 12, 1),
('Never Be Alone', 240, '2018-05-25', 'English', 12, 1),
('I Don’t Even Know Your Name', 215, '2018-05-25', 'English', 12, 1),
('Strings', 210, '2018-05-25', 'English', 12, 1),
('Ruin', 228, '2018-05-25', 'English', 12, 1),
('A Little Too Much', 232, '2018-05-25', 'English', 12, 1),
('Bad Reputation', 220, '2018-05-25', 'English', 12, 1),
('This Is What It Takes', 230, '2018-05-25', 'English', 12, 1),
('Castaway', 213, '2018-05-25', 'English', 12, 1),
('Show You', 225, '2018-05-25', 'English', 12, 1),
('Understand', 242, '2018-05-25', 'English', 12, 1),
('Patience', 233, '2018-05-25', 'English', 12, 1),
('Work', 200, '2016-01-28', 'English', 13, 7),
('Needed Me', 210, '2016-01-28', 'English', 13, 7),
('Love on the Brain', 235, '2016-01-28', 'English', 13, 7),
('Kiss It Better', 240, '2016-01-28', 'English', 13, 7),
('Desperado', 230, '2016-01-28', 'English', 13, 7),
('Woo', 210, '2016-01-28', 'English', 13, 7),
('Same Ol’ Mistakes', 250, '2016-01-28', 'English', 13, 7),
('James Joint', 120, '2016-01-28', 'English', 13, 7),
('Higher', 200, '2016-01-28', 'English', 13, 7),
('Close to You', 225, '2016-01-28', 'English', 13, 7),
('Goodnight Gotham', 160, '2016-01-28', 'English', 13, 7),
('This Love', 230, '2002-06-25', 'English', 14, 1),
('She Will Be Loved', 245, '2002-06-25', 'English', 14, 1),
('Sunday Morning', 210, '2002-06-25', 'English', 14, 1),
('Tangled', 220, '2002-06-25', 'English', 14, 1),
('Harder to Breathe', 230, '2002-06-25', 'English', 14, 1),
('Must Get Out', 235, '2002-06-25', 'English', 14, 1),
('Secret', 225, '2002-06-25', 'English', 14, 1),
('Through with You', 240, '2002-06-25', 'English', 14, 1),
('The Sun', 210, '2002-06-25', 'English', 14, 1),
('Not Coming Home', 250, '2002-06-25', 'English', 14, 1),
('Sweetest Goodbye', 215, '2002-06-25', 'English', 14, 1),
('Teenage Dream', 240, '2010-08-24', 'English', 15, 1),
('California Gurls', 230, '2010-08-24', 'English', 15, 1),
('Firework', 245, '2010-08-24', 'English', 15, 1),
('E.T.', 235, '2010-08-24', 'English', 15, 1),
('Last Friday Night (T.G.I.F.)', 250, '2010-08-24', 'English', 15, 1),
('The One That Got Away', 240, '2010-08-24', 'English', 15, 1),
('Pearl', 230, '2010-08-24', 'English', 15, 1),
('Hummingbird Heartbeat', 215, '2010-08-24', 'English', 15, 1),
('Not Like the Movies', 225, '2010-08-24', 'English', 15, 1),
('Who Am I Living For?', 230, '2010-08-24', 'English', 15, 1),
('Fingerprints', 240, '2010-08-24', 'English', 15, 1),
('Purpose', 210, '2015-11-13', 'English', 16, 1),
('Mark My Words', 220, '2015-11-13', 'English', 16, 1),
('I’ll Show You', 240, '2015-11-13', 'English', 16, 1),
('Sorry', 203, '2015-11-13', 'English', 16, 1),
('Love Yourself', 223, '2015-11-13', 'English', 16, 1),
('Company', 232, '2015-11-13', 'English', 16, 1),
('No Pressure', 215, '2015-11-13', 'English', 16, 1),
('Life Is Worth Living', 245, '2015-11-13', 'English', 16, 1),
('Children', 210, '2015-11-13', 'English', 16, 1),
('Purpose (Reprise)', 220, '2015-11-13', 'English', 16, 1),
('Where Are Ü Now', 234, '2015-11-13', 'English', 16, 1),
('Rare', 220, '2020-01-10', 'English', 17, 1),
('Dance Again', 230, '2020-01-10', 'English', 17, 1),
('Look at Her Now', 205, '2020-01-10', 'English', 17, 1),
('Feel Me', 210, '2020-01-10', 'English', 17, 1),
('Kinda Crazy', 215, '2020-01-10', 'English', 17, 1),
('Vulnerable', 225, '2020-01-10', 'English', 17, 1),
('People You Know', 240, '2020-01-10', 'English', 17, 1),
('Let Me Get Me', 220, '2020-01-10', 'English', 17, 1),
('Bad Liar', 210, '2020-01-10', 'English', 17, 1),
('Cut You Off', 235, '2020-01-10', 'English', 17, 1),
('Survivors', 230, '2020-01-10', 'English', 17, 1),
('Ashley', 220, '2020-01-17', 'English', 18, 1),
('Clementine', 205, '2020-01-17', 'English', 18, 1),
('Graveyard', 230, '2020-01-17', 'English', 18, 1),
('You Should Be Sad', 215, '2020-01-17', 'English', 18, 1),
('Without Me', 240, '2020-01-17', 'English', 18, 1),
('I HATE EVERYBODY', 250, '2020-01-17', 'English', 18, 1),
('Finally // Beautiful Stranger', 230, '2020-01-17', 'English', 18, 1),
('3AM', 220, '2020-01-17', 'English', 18, 1),
('Alanis’ Interlude', 160, '2020-01-17', 'English', 18, 1),
('Be Kind', 230, '2020-01-17', 'English', 18, 1),
('Everything I Wanted', 220, '2020-01-17', 'English', 18, 1),
('Future Nostalgia', 230, '2020-03-27', 'English', 19, 1),
('Don’t Start Now', 200, '2020-03-27', 'English', 19, 1),
('Physical', 210, '2020-03-27', 'English', 19, 1),
('Levitating', 215, '2020-03-27', 'English', 19, 1),
('Pretty Please', 225, '2020-03-27', 'English', 19, 1),
('Hallucinate', 220, '2020-03-27', 'English', 19, 1),
('Love Again', 230, '2020-03-27', 'English', 19, 1),
('Break My Heart', 215, '2020-03-27', 'English', 19, 1),
('Good in Bed', 225, '2020-03-27', 'English', 19, 1),
('Golden', 255, '2019-12-13', 'English', 20, 1),
('Watermelon Sugar', 174, '2019-12-13', 'English', 20, 1),
('Adore You', 259, '2019-12-13', 'English', 20, 1),
('Lights Up', 191, '2019-12-13', 'English', 20, 1),
('Cherry', 229, '2019-12-13', 'English', 20, 1),
('Falling', 228, '2019-12-13', 'English', 20, 1),
('To Be So Lonely', 228, '2019-12-13', 'English', 20, 1),
('She', 267, '2019-12-13', 'English', 20, 1),
('Sunflower, Vol. 6', 202, '2019-12-13', 'English', 20, 1),
('Canyon Moon', 228, '2019-12-13', 'English', 20, 1),
('Fine Line', 286, '2019-12-13', 'English', 20, 1),
('Nobody Is Listening', 248, '2021-01-15', 'English', 21, 7),
('What If', 221, '2021-01-15', 'English', 21, 7),
('Don’t Go', 234, '2021-01-15', 'English', 21, 7),
('Love Me Back', 216, '2021-01-15', 'English', 21, 7),
('With You', 230, '2021-01-15', 'English', 21, 7),
('Alone', 219, '2021-01-15', 'English', 21, 7),
('Better Than Me', 234, '2021-01-15', 'English', 21, 7),
('Listen To Me', 225, '2021-01-15', 'English', 21, 7),
('Sad Songs', 239, '2021-01-15', 'English', 21, 7),
('Cold Heart', 211, '2021-01-15', 'English', 21, 7),
('Goodbye', 240, '2021-01-15', 'English', 21, 7),
('How You Like That', 210, '2020-10-02', 'Korean', 22, 4),
('Ice Cream', 227, '2020-10-02', 'Korean', 22, 4),
('Pretty Savage', 215, '2020-10-02', 'Korean', 22, 4),
('Bet You Wanna', 223, '2020-10-02', 'Korean', 22, 4),
('Lovesick Girls', 229, '2020-10-02', 'Korean', 22, 4),
('Love To Hate Me', 233, '2020-10-02', 'Korean', 22, 4),
('You Never Know', 258, '2020-10-02', 'Korean', 22, 4),
('Crazy Over You', 229, '2020-10-02', 'Korean', 22, 4),
('Boys Will Be Boys', 240, '2020-03-27', 'English', 19, 1),
('Physical (Reprise)', 200, '2020-03-27', 'English', 19, 1),
('State of Grace', 296, '2012-10-16', 'English', 39, 1),
('Red', 220, '2012-10-02', 'English', 39, 1),
('Treacherous', 242, '2012-10-16', 'English', 39, 1),
('I Knew You Were Trouble', 220, '2012-10-09', 'English', 39, 1),
('All Too Well', 321, '2012-10-22', 'English', 39, 1),
('22', 231, '2012-10-22', 'English', 39, 1),
('We Are Never Ever Getting Back Together', 193, '2012-08-13', 'English', 39, 1),
('Everything Has Changed', 264, '2012-10-22', 'English', 39, 1),
('Imagine', 183, '2019-02-08', 'English', 10, 7),
('Needy', 233, '2019-02-08', 'English', 10, 7),
('NASA', 212, '2019-02-08', 'English', 10, 7),
('Bloodline', 207, '2019-02-08', 'English', 10, 7),
('Fake Smile', 207, '2019-02-08', 'English', 10, 7),
('Bad Idea', 226, '2019-02-08', 'English', 10, 7),
('Make Up', 211, '2019-02-08', 'English', 10, 7),
('Ghostin', 248, '2019-02-08', 'English', 10, 7),
('In My Head', 232, '2019-02-08', 'English', 10, 7),
('7 Rings', 202, '2019-02-08', 'English', 10, 7),
('Thank U, Next', 275, '2019-02-08', 'English', 10, 7),
('Break Up with Your Girlfriend, I’m Bored', 211, '2019-02-08', 'English', 10, 7),
('Endless Love', 240, '2018-02-01', 'English', 30, 3),
('I Will Always Love You', 245, '2018-02-01', 'English', 30, 3),
('My Heart Will Go On', 265, '2018-02-01', 'English', 30, 3),
('Unchained Melody', 210, '2018-02-01', 'English', 30, 3),
('Just the Way You Are', 225, '2018-02-01', 'English', 30, 3),
('Can’t Help Falling in Love', 220, '2018-02-01', 'English', 30, 3),
('Something', 250, '2018-02-01', 'English', 30, 3),
('At Last', 230, '2018-02-01', 'English', 30, 3),
('All of Me', 240, '2018-02-01', 'English', 30, 3),
('Amazed', 215, '2018-02-01', 'English', 30, 3),
('You Are So Beautiful', 210, '2018-02-01', 'English', 30, 3),
('Havana', 210, '2019-12-11', 'Spanish', 31, 1),
('Bailando', 250, '2019-12-11', 'Spanish', 31, 1),
('Despacito', 235, '2019-12-11', 'Spanish', 31, 1),
('Mi Gente', 230, '2019-12-11', 'Spanish', 31, 1),
('Vivir Mi Vida', 240, '2019-12-11', 'Spanish', 31, 1),
('Danza Kuduro', 220, '2019-12-11', 'Spanish', 31, 1),
('La Bicicleta', 225, '2019-12-11', 'Spanish', 31, 1),
('El Perdón', 210, '2019-12-11', 'Spanish', 31, 1),
('Limón y sal', 250, '2019-12-11', 'Spanish', 31, 1),
('Echa Pa’lante', 240, '2019-12-11', 'Spanish', 31, 1),
('Héroe', 220, '2019-12-11', 'Spanish', 31, 1),
('Sing', 234, '2014-06-20', 'English', 1, 33),
('Don\'t', 228, '2014-06-13', 'English', 1, 33),
('Photograph', 258, '2014-06-20', 'English', 1, 33),
('Thinking Out Loud', 281, '2014-06-20', 'English', 1, 33),
('Bloodstream', 303, '2014-06-20', 'English', 1, 33),
('Tenerife Sea', 253, '2014-06-20', 'English', 1, 33),
('I See Fire', 322, '2013-11-05', 'English', 1, 33),
('Nina', 211, '2014-06-20', 'English', 1, 33),
('Afire Love', 308, '2014-06-20', 'English', 1, 33),
('Runaway', 215, '2014-06-20', 'English', 1, 33),
('One', 257, '2014-05-16', 'English', 1, 33),
('Hello', 295, '2015-10-23', 'English', 32, 1),
('Send My Love (To Your New Lover)', 223, '2016-05-16', 'English', 32, 1),
('I Miss You', 348, '2015-11-20', 'English', 32, 1),
('When We Were Young', 293, '2015-11-20', 'English', 32, 1),
('Remedy', 239, '2015-11-20', 'English', 32, 1),
('Water Under the Bridge', 241, '2015-11-20', 'English', 32, 1),
('River Lea', 229, '2015-11-20', 'English', 32, 1),
('Love in the Dark', 277, '2015-11-20', 'English', 32, 1),
('Million Years Ago', 228, '2015-11-20', 'English', 32, 1),
('All I Ask', 273, '2015-11-20', 'English', 32, 1),
('Sweetest Devotion', 247, '2015-11-20', 'English', 32, 1),
('I Forgot That You Existed', 171, '2019-08-23', 'English', 35, 1),
('Cruel Summer', 178, '2019-08-23', 'English', 35, 1),
('Lover', 221, '2019-08-23', 'English', 35, 1),
('The Archer', 207, '2019-07-23', 'English', 35, 1),
('I Think He Knows', 173, '2019-08-23', 'English', 35, 1),
('Miss Americana & The Heartbreak Prince', 207, '2019-08-23', 'English', 35, 1),
('Paper Rings', 223, '2019-08-23', 'English', 35, 1),
('Cornelia Street', 293, '2019-08-23', 'English', 35, 1),
('Death By A Thousand Cuts', 230, '2019-08-23', 'English', 35, 1),
('London Boy', 191, '2019-08-23', 'English', 35, 1),
('Soon You’ll Get Better', 206, '2019-08-23', 'English', 35, 1),
('False God', 200, '2019-08-23', 'English', 35, 1),
('You Need To Calm Down', 171, '2019-06-14', 'English', 35, 1),
('Afterglow', 208, '2019-08-23', 'English', 35, 1),
('ME!', 193, '2019-04-26', 'English', 35, 1),
('Daylight', 259, '2019-08-23', 'English', 35, 1),
('It’s Nice To Have A Friend', 161, '2019-08-23', 'English', 35, 1),
('The Man', 252, '2014-06-20', 'English', 1, 33),
('Over It', 231, '2019-10-04', 'English', 44, 7),
('I Don’t Mind', 245, '2019-10-04', 'English', 44, 7),
('My Best Friend', 220, '2019-10-04', 'English', 44, 7),
('Playing Games', 240, '2019-10-04', 'English', 44, 7),
('No Guidance', 259, '2019-10-04', 'English', 44, 7),
('Don’t Make Me Wait', 234, '2019-10-04', 'English', 44, 7),
('Time of Our Lives', 248, '2019-10-04', 'English', 44, 7),
('Better With You', 235, '2019-10-04', 'English', 44, 7),
('Trust Issues', 227, '2019-10-04', 'English', 44, 7),
('Never Again', 212, '2019-10-04', 'English', 44, 7),
('Just a Moment', 253, '2019-10-04', 'English', 44, 7),
('Thinkin Bout You', 232, '2012-07-10', 'English', 45, 7),
('Pyramids', 304, '2012-07-10', 'English', 45, 7),
('Sweet Life', 233, '2012-07-10', 'English', 45, 7),
('Bad Religion', 212, '2012-07-10', 'English', 45, 7),
('Super Rich Kids', 259, '2012-07-10', 'English', 45, 7),
('Monks', 211, '2012-07-10', 'English', 45, 7),
('Pilot Jones', 230, '2012-07-10', 'English', 45, 7),
('Crack Rock', 252, '2012-07-10', 'English', 45, 7),
('Forrest Gump', 232, '2012-07-10', 'English', 45, 7),
('Lost', 261, '2012-07-10', 'English', 45, 7),
('White', 238, '2012-07-10', 'English', 45, 7),
('All Girls Are The Same', 204, '2018-05-23', 'English', 46, 7),
('Lucid Dreams', 246, '2018-05-23', 'English', 46, 7),
('Armed & Dangerous', 200, '2018-05-23', 'English', 46, 7),
('Lean Wit Me', 206, '2018-05-23', 'English', 46, 7),
('IDGAF', 231, '2018-05-23', 'English', 46, 7),
('Black & White', 232, '2018-05-23', 'English', 46, 7),
('Killing Me', 235, '2018-05-23', 'English', 46, 7),
('Empty', 238, '2018-05-23', 'English', 46, 7),
('I Want It', 245, '2018-05-23', 'English', 46, 7),
('Hurt Me', 243, '2018-05-23', 'English', 46, 7),
('Goodbye & Good Riddance', 228, '2018-05-23', 'English', 46, 7),
('Starboy', 232, '2016-11-25', 'English', 48, 7),
('Love to Lay', 221, '2016-11-25', 'English', 48, 7),
('Party Monster', 231, '2016-11-25', 'English', 48, 7),
('False Alarm', 201, '2016-11-25', 'English', 48, 7),
('Reminder', 243, '2016-11-25', 'English', 48, 7),
('Rockin’', 225, '2016-11-25', 'English', 48, 7),
('Secrets', 220, '2016-11-25', 'English', 48, 7),
('True Colors', 233, '2016-11-25', 'English', 48, 7),
('A Lonely Night', 241, '2016-11-25', 'English', 48, 7),
('Nothing Without You', 248, '2016-11-25', 'English', 48, 7),
('All I Know', 240, '2016-11-25', 'English', 48, 7),
('Born This Way', 256, '2011-05-23', 'English', 29, 1),
('Judas', 396, '2011-05-23', 'English', 29, 1),
('Americano', 224, '2011-05-23', 'English', 29, 1),
('Hair', 271, '2011-05-23', 'English', 29, 1),
('Scheiße', 270, '2011-05-23', 'English', 29, 1),
('Bloody Mary', 268, '2011-05-23', 'English', 29, 1),
('Bad Kids', 212, '2011-05-23', 'English', 29, 1),
('Highway Unicorn (Road to Love)', 305, '2011-05-23', 'English', 29, 1),
('Heavy Metal Lover', 298, '2011-05-23', 'English', 29, 1),
('Electric Chapel', 296, '2011-05-23', 'English', 29, 1),
('The Queen', 274, '2011-05-23', 'English', 29, 1),
('HeavyDirtySoul', 238, '2015-05-17', 'English', 36, 2),
('Stressed Out', 227, '2015-05-17', 'English', 36, 2),
('Ride', 255, '2015-05-17', 'English', 36, 2),
('Fairly Local', 195, '2015-05-17', 'English', 36, 2),
('Tear In My Heart', 234, '2015-05-17', 'English', 36, 2),
('Lane Boy', 234, '2015-05-17', 'English', 36, 2),
('The Judge', 284, '2015-05-17', 'English', 36, 2),
('Doubt', 201, '2015-05-17', 'English', 36, 2),
('Polarize', 244, '2015-05-17', 'English', 36, 2),
('We Don’t Believe What’s On TV', 219, '2015-05-17', 'English', 36, 2),
('Message Man', 234, '2015-05-17', 'English', 36, 2),
('Just Dance', 252, '2008-08-19', 'English', 40, 1),
('Lovegame', 248, '2008-08-19', 'English', 40, 1),
('Paparazzi', 225, '2008-08-19', 'English', 40, 1),
('Poker Face', 267, '2008-08-19', 'English', 40, 1),
('Eh, Eh (Nothing Else I Can Say)', 222, '2008-08-19', 'English', 40, 1),
('Beautiful, Dirty, Rich', 242, '2008-08-19', 'English', 40, 1),
('Bad Romance', 258, '2008-08-19', 'English', 40, 1),
('Alejandro', 298, '2008-08-19', 'English', 40, 1),
('Monster', 221, '2008-08-19', 'English', 40, 1),
('Speechless', 281, '2008-08-19', 'English', 40, 1),
('Dance In The Dark', 267, '2008-08-19', 'English', 40, 1),
('Alice', 219, '2020-05-29', 'English', 5, 1),
('Stupid Love', 215, '2020-02-28', 'English', 5, 1),
('Rain On Me', 226, '2020-05-22', 'English', 5, 1),
('Free Woman', 232, '2020-05-29', 'English', 5, 1),
('Fun Tonight', 242, '2020-05-29', 'English', 5, 1),
('Chromatica II', 61, '2020-05-29', 'English', 5, 1),
('911', 216, '2020-05-29', 'English', 5, 1),
('Sine From Above', 301, '2020-05-29', 'English', 5, 1),
('Enigma', 252, '2020-05-29', 'English', 5, 1),
('Replay', 229, '2020-05-29', 'English', 5, 1),
('Chromatica III', 75, '2020-05-29', 'English', 5, 1),
('Plastic Doll', 258, '2020-05-29', 'English', 5, 1),
('Love Me Right', 233, '2020-05-29', 'English', 5, 1),
('1000 Doves', 249, '2020-05-29', 'English', 5, 1),
('Babylon', 237, '2020-05-29', 'English', 5, 1),
('Grenade', 234, '2010-10-04', 'English', 8, 1),
('Just The Way You Are', 258, '2010-10-04', 'English', 8, 1),
('The Lazy Song', 185, '2010-10-04', 'English', 8, 1),
('Marry You', 196, '2010-10-04', 'English', 8, 1),
('Talking To The Moon', 238, '2010-10-04', 'English', 8, 1),
('Count On Me', 232, '2010-10-04', 'English', 8, 1),
('Runaway Baby', 213, '2010-10-04', 'English', 8, 1),
('Our First Time', 244, '2010-10-04', 'English', 8, 1),
('Billionaire', 225, '2010-10-04', 'English', 8, 1),
('Somewhere In Brooklyn', 255, '2010-10-04', 'English', 8, 1),

('Intro: What Am I to You', 166, '2014-08-19', 'Korean', 5, 4),
('Danger', 244, '2014-08-19', 'Korean', 5, 4),
('War of Hormone', 240, '2014-08-19', 'Korean', 5, 4),
('Let Me Know', 255, '2014-08-19', 'Korean', 5, 4),
('Rain', 265, '2014-08-19', 'Korean', 5, 4),
('BTS Cypher Pt.3: Killer', 267, '2014-08-19', 'Korean', 5, 4),
('Hip Hop Lover', 259, '2014-08-19', 'Korean', 5, 4),
('Blanket Kick', 220, '2014-08-19', 'Korean', 5, 4);

-------------------------------------------- SỬA DỮ LIỆU--------------------------------
-- Thêm album của Rihanna
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Good Girl Gone Bad', '2007-05-30', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Rihanna'), 1, 12),
('Rated R', '2009-11-20', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Rihanna'), 1, 13),
('Loud', '2010-11-12', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Rihanna'), 1, 11),
('Talk That Talk', '2011-11-18', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Rihanna'), 1, 11),
('Unapologetic', '2012-11-19', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Rihanna'), 1, 14);
-- Thêm album của Jolin Tsai
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Show Your Love', '2003-06-18', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Jolin Tsai'), 39, 10),
('Magic', '2005-11-25', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Jolin Tsai'), 39, 12),
('Dancing Diva', '2006-11-02', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Jolin Tsai'), 39, 10),
('Butterfly', '2009-11-20', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Jolin Tsai'), 39, 11),
('MUSE', '2014-07-18', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Jolin Tsai'), 39, 12);
-- Thêm album của Alan Walker
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Different World', '2018-12-14', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Alan Walker'), 21, 10),
('Walkerverse', '2020-05-15', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Alan Walker'), 21, 12);
-- Thêm album của Avicii
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('True', '2013-09-13', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Avicii'), 21, 12),
('Stories', '2015-10-02', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Avicii'), 21, 14);
-- Thêm album của Calvin Harris
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('18 Months', '2012-10-26', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Calvin Harris'), 21, 10),
('Motion', '2014-11-04', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Calvin Harris'), 21, 12);
-- Thêm album của David Guetta
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('One Love', '2009-08-24', (SELECT ArtistID FROM Artist WHERE ArtistName = 'David Guetta'), 21, 12),
('Nothing But the Beat', '2011-08-26', (SELECT ArtistID FROM Artist WHERE ArtistName = 'David Guetta'), 21, 14);
-- Thêm album của Shakira
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Laundry Service', '2001-11-13', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Shakira'), 21, 13),
('El Dorado', '2017-05-26', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Shakira'), 21, 10);
-- Thêm album của Maluma
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('F.A.M.E.', '2018-05-18', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Maluma'), 34, 12),
('11:11', '2019-05-17', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Maluma'), 34, 11);

-- Thêm album của Bad Bunny
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('X 100PRE', '2018-12-24', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Bad Bunny'), 34, 12),
('YHLQMDLG', '2020-02-29', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Bad Bunny'), 34, 20);

-- Thêm album của Camila Cabello
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Camila', '2018-01-12', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Camila Cabello'), 34, 10),
('Romance', '2019-12-06', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Camila Cabello'), 34, 14);

-- Thêm album của Demi Lovato
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Confident', '2015-10-16', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Demi Lovato'), 34, 10),
('Tell Me You Love Me', '2017-09-29', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Demi Lovato'), 34, 12);

-- Thêm album của Nicki Minaj
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Pink Friday', '2010-11-22', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Nicki Minaj'), 34, 13),
('The Pinkprint', '2014-12-15', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Nicki Minaj'), 34, 16);

-- Thêm album của Cardi B
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Invasion of Privacy', '2018-04-06', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Cardi B'), 34, 13);

-- Thêm album của Megan Thee Stallion
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Suga', '2020-03-06', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Megan Thee Stallion'), 34, 9),
('Good News', '2020-11-20', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Megan Thee Stallion'), 34, 17);

-- Thêm album của Doja Cat
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Amala', '2018-03-30', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Doja Cat'), 34, 9),
('Hot Pink', '2019-11-07', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Doja Cat'), 34, 10);

-- Thêm album của Lil Nas X
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('7', '2019-06-21', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Lil Nas X'), 34, 8);

-- Thêm album của Travis Scott
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('Astroworld', '2018-08-03', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Travis Scott'), 34, 17);

-- Thêm album của Future
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) VALUES
('DS2', '2015-07-17', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Future'), 34, 18),
('Hndrxx', '2017-02-24', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Future'), 34, 14);
INSERT INTO Album (AlbumName, PublishedDate, ArtistID, GenreID, NumberOfTracks) 
VALUES
('Illmatic', '1994-04-19', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Nas'), 34, 10),
('It Was Written', '1996-07-02', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Nas'), 34, 14),

('DAMN.', '2017-04-14', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Kendrick Lamar'), 34, 14),
('To Pimp a Butterfly', '2015-03-15', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Kendrick Lamar'), 34, 16),

('2014 Forest Hills Drive', '2014-12-09', (SELECT ArtistID FROM Artist WHERE ArtistName = 'J. Cole'), 34, 13),
('KOD', '2018-04-20', (SELECT ArtistID FROM Artist WHERE ArtistName = 'J. Cole'), 34, 12),

('Under Pressure', '2014-10-21', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Logic'), 34, 12),
('The Incredible True Story', '2015-11-13', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Logic'), 34, 18),

('Cuz I Love You', '2019-04-19', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Lizzo'), 34, 12),
('Special', '2022-07-15', (SELECT ArtistID FROM Artist WHERE ArtistName = 'Lizzo'), 34, 10);
-- Thêm dữ liệu bài hát.
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Good Girl Gone Bad"
('Umbrella', 274, '2007-03-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Shut Up and Drive', 220, '2007-06-11', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Hate That I Love You', 229, '2007-09-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Take a Bow', 203, '2008-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Disturbia', 230, '2008-07-08', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Rehab', 246, '2008-01-28', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Don\'t Stop the Music', 231, '2007-10-31', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Breakin’ Dishes', 217, '2008-01-08', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Love Without Tragedy', 255, '2007-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Push Up on Me', 240, '2007-08-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),
('Good Girl Gone Bad', 263, '2007-05-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good Girl Gone Bad'), 1),

-- Album "Rated R"
('Russian Roulette', 258, '2009-10-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Hard', 229, '2009-11-23', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Rude Boy', 227, '2010-01-25', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Fire Bomb', 237, '2009-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Te Amo', 243, '2010-03-23', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Love the Way You Lie (Part II)', 271, '2009-12-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Photographs', 249, '2009-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),
('Stupid in Love', 220, '2009-03-11', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Rated R'), 1),

-- Album "Loud"
('Only Girl (In the World)', 232, '2010-10-25', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('What’s My Name?', 227, '2010-10-25', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('S&M', 233, '2010-01-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('Cheers (Drink to That)', 232, '2011-06-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('California King Bed', 246, '2011-05-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('Man Down', 251, '2011-05-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('Raining Men', 231, '2010-11-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),
('Complicated', 220, '2010-12-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Loud'), 1),

-- Album "Talk That Talk"
('We Found Love', 238, '2011-09-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),
('You Da One', 223, '2011-11-11', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),
('Talk That Talk', 231, '2011-11-11', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),
('Where Have You Been', 238, '2012-03-05', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),
('Birthday Cake', 170, '2012-02-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),
('Cockiness (Love It)', 223, '2011-11-11', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Talk That Talk'), 1),

-- Album "Unapologetic"
('Diamonds', 228, '2012-11-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1),
('Stay', 213, '2012-01-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1),
('Pour It Up', 257, '2013-01-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1),
('Love Without Tragedy', 255, '2013-02-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1),
('What Now', 244, '2012-11-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1),
('Numb', 234, '2012-11-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Unapologetic'), 1);

INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Show Your Love"
('Show Your Love', 210, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('The Rose', 240, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Kiss Me', 230, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Love You More', 210, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('I Am Not Yours', 220, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Stay With Me', 250, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Happy Alone', 235, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Last Kiss', 245, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Don\'t Cry', 230, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),
('Secret Garden', 240, '2003-06-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Show Your Love'), 39),

-- Album "Magic"
('Magic', 233, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('You', 245, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Love is Here', 250, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Fate', 240, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Don\'t Let Me Go', 255, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Goodbye', 230, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Love & Magic', 250, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Nothing Can Change My Love for You', 245, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('Butterfly Dream', 240, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),
('In Love With You', 230, '2005-11-25', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Magic'), 39),

-- Album "Dancing Diva"
('Dancing Diva', 235, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Queen', 220, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Passion', 250, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Superstar', 240, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Dance Floor', 245, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Diva', 230, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Fly Away', 255, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Never Say Goodbye', 230, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Show Me the Way', 240, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),
('Dance with Me', 235, '2006-11-02', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Dancing Diva'), 39),

-- Album "Butterfly"
('Butterfly', 240, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Wings', 235, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Transformation', 250, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Love Butterfly', 245, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Fly High', 235, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('True Love', 245, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Believe in Love', 240, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Magical Love', 250, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Eternal Love', 230, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),
('Butterfly Kiss', 235, '2009-11-20', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'Butterfly'), 39),

-- Album "MUSE"
('MUSE', 240, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Lost in Time', 245, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('The Awakening', 230, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Fading Away', 255, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Never Turn Back', 240, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Muse\'s Heart', 230, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Sing to Me', 245, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Fascination', 240, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('In the Dark', 250, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39),
('Dreams', 240, '2014-07-18', 'Mandarin', (SELECT AlbumID FROM Album WHERE AlbumName = 'MUSE'), 39);
-- Thêm bài hát vào album của Alan Walker
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Different World"
('Different World', 210, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('All Falls Down', 220, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Faded', 240, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Alone', 210, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Tired', 230, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Sing Me to Sleep', 240, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Darkside', 250, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('On My Way', 220, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Diamond Heart', 240, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),
('Lost Control', 250, '2018-12-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Different World'), 21),

-- Album "Walkerverse"
('Fade', 225, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('No Sleep', 240, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Lily', 230, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Unity', 240, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Hey Brother', 250, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Spectre', 220, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Sing Me to Sleep', 240, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('The Spectre', 245, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Faded Reborn', 250, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21),
('Force', 220, '2020-05-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Walkerverse'), 21);

-- Thêm bài hát vào album của Avicii
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "True"
('Wake Me Up', 250, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Hey Brother', 240, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Addicted to You', 230, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('I Could Be the One', 240, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Lay Me Down', 235, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Dear Boy', 230, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Dancing in My Head', 245, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Hope There’s Someone', 255, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('The Nights', 240, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),
('Shameless', 230, '2013-09-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'True'), 21),

-- Album "Stories"
('Waiting for Love', 240, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('For a Better Day', 230, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Broken Arrows', 245, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('The Days', 220, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Without You', 235, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Pure Grinding', 250, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Sunset Jesus', 245, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Broke Our Hearts', 255, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('City Lights', 240, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21),
('Touch Me', 230, '2015-10-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Stories'), 21);

-- Thêm bài hát vào album của Calvin Harris
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "18 Months"
('Bounce', 235, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Let’s Go', 245, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('We Found Love', 240, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('I Need Your Love', 230, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Drinking from the Bottle', 255, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Sweet Nothing', 245, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Under Control', 240, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Iron', 230, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Awooga', 250, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),
('Here 2 China', 245, '2012-10-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '18 Months'), 21),

-- Album "Motion"
('Summer', 240, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Blame', 230, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Outside', 240, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Pray to God', 245, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('My Way', 250, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Open Wide', 235, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Love Now', 240, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Slow Acid', 250, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('It Was You', 240, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21),
('Numb', 230, '2014-11-04', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Motion'), 21);
-- Thêm bài hát vào album của David Guetta
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "One Love"
('When Love Takes Over', 240, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Sexy Bitch', 230, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Memories', 220, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('I Gotta Feeling', 240, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('On the Dancefloor', 230, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Missing You', 225, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Love Is Gone', 220, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Tomorrow Can Wait', 230, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('Gettin\' Over You', 240, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('How Soon Is Now', 230, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('The World Is Mine', 235, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),
('One Love', 240, '2009-08-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'One Love'), 21),

-- Album "Nothing But the Beat"
('Where Them Girls At', 235, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Without You', 245, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Turn Me On', 230, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Little Bad Girl', 240, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('I Can Only Imagine', 250, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Where Is the Love', 240, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Sweat', 225, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Just One Last Time', 230, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('Nothing But the Beat', 240, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'), 21),
('The Alphabeat', 230, '2011-08-26', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Nothing But the Beat'),21);

-- Thêm bài hát vào album của Shakira
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Laundry Service"
('Whenever, Wherever', 230, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Underneath Your Clothes', 240, '2001-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Hips Don’t Lie', 245, '2001-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Te Dejo Madrid', 220, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Inevitable', 235, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('The One', 240, '2001-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Antología', 230, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Ciega, Sordomuda', 240, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Tú', 225, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),
('Ojos Así', 245, '2001-11-13', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'Laundry Service'), 21),

-- Album "El Dorado"
('Me Enamoré', 240, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Perro Fiel', 230, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Chantaje', 235, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('La Bicicleta', 240, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('El Dorado', 250, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Nada', 230, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Amarillo', 240, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Caderas Blancas', 245, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Toneladas de Amor', 235, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21),
('Blackmail', 230, '2017-05-26', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'El Dorado'), 21);

-- Thêm bài hát vào album của Maluma
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "F.A.M.E."
('Felices los 4', 230, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Corazón', 235, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Borró Cassette', 240, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Vivir Mi Vida', 230, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('El Préstamo', 220, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Amigos con Derechos', 245, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Hawái', 250, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('24 Horas', 240, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('La Resaca', 230, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),
('Mala Mía', 235, '2018-05-18', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'F.A.M.E.'), 34),

-- Album "11:11"
('No Se Me Quita', 245, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Instinto', 230, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Qué Chimba', 240, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('La Noche', 230, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Vente Pa\' Ca', 235, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('No Te Vayas', 240, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Solita', 230, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Me Gusta', 235, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Sin Contrato', 245, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34),
('Tu Amor', 240, '2019-05-17', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = '11:11'), 34); 
-- Thêm bài hát vào album của Bad Bunny
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "X 100PRE"
('Mía', 240, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Vete', 230, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('La Canción', 245, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Ni Bien Ni Mal', 235, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Estamos Bien', 230, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Solo de Mí', 240, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Si Estuviésemos Juntos', 245, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Como Te Quiero Yo a Ti', 250, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Qué Pretendes', 240, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Pa\' Romperla', 230, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('Esquema', 235, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),
('X 100PRE', 240, '2018-12-24', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'X 100PRE'), 34),

-- Album "YHLQMDLG"
('Si Veo a Tu Mamá', 245, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('La Santa', 230, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Bichiyal', 240, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Pa\' Romperla', 245, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Safaera', 250, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Bye Me Fui', 240, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('El Apagón', 230, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Pa\' Ti', 235, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Vete', 230, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Pa\' Las Mujeres', 240, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('Rodeo', 250, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34),
('YHLQMDLG', 240, '2020-02-29', 'Spanish', (SELECT AlbumID FROM Album WHERE AlbumName = 'YHLQMDLG'), 34);

-- Thêm bài hát vào album của Camila Cabello
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Camila"
('Havana', 240, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Never Be the Same', 235, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Crying in the Club', 245, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Into It', 230, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Real Friends', 240, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('All These Years', 230, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('She Loves Control', 250, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('I Have Questions', 240, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Something\'s Gotta Give', 245, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),
('Consequences', 235, '2018-01-12', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Camila'), 34),

-- Album "Romance"
('Liar', 235, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Shameless', 245, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Cry for Me', 240, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Easy', 230, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Find You Again', 240, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Should\'ve Said It', 235, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Dream of You', 240, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Used to This', 230, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Bad Kind of Butterflies', 245, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34),
('Living Proof', 250, '2019-12-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Romance'), 34);

-- Thêm bài hát vào album của Demi Lovato
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Confident"
('Confident', 240, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Cool for the Summer', 230, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Old Ways', 240, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Kingdom Come', 250, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Stone Cold', 245, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Waitin for You', 230, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Father', 240, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Heart Attack', 250, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Yes', 230, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),
('Warrior', 240, '2015-10-16', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Confident'), 34),

-- Album "Tell Me You Love Me"
('Sorry Not Sorry', 240, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Tell Me You Love Me', 235, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('You Don\'t Do It for Me Anymore', 250, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Games', 240, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Concentration', 245, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Hitchhiker', 230, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Only Forever', 240, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Lonely', 235, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Sober', 230, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34),
('Skyscraper', 240, '2017-09-29', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Tell Me You Love Me'), 34);
-- Thêm bài hát vào album của Nicki Minaj
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Pink Friday"
('Your Love', 240, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Roman\'s Revenge', 235, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Check It Out', 250, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Moment 4 Life', 245, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Super Bass', 230, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Fly', 240, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Blazin', 235, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Did It On\'em', 240, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Right Thru Me', 250, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('I’m the Best', 240, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Here I Am', 230, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Save Me', 245, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),
('Last Chance', 235, '2010-11-22', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Pink Friday'), 34),

-- Album "The Pinkprint"
('All Things Go', 240, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('I Lied', 230, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('The Crying Game', 245, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Feeling Myself', 240, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Only', 230, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Truffle Butter', 245, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Swalla', 230, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Anaconda', 250, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Pills N Potions', 240, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Bed of Lies', 235, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Grand Piano', 240, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Looking Ass', 245, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('All Eyes on Me', 230, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('Big Bank', 240, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34),
('The Night Is Still Young', 235, '2014-12-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Pinkprint'), 34);

-- Thêm bài hát vào album của Cardi B
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Invasion of Privacy"
('Bodak Yellow', 230, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('I Like It', 240, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Be Careful', 235, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Ring', 245, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Money', 250, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Bartier Cardi', 240, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Drip', 230, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Choppa', 245, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Best Life', 235, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Thru Your Phone', 240, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Up', 235, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('I Do', 240, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34),
('Get Up 10', 250, '2018-04-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Invasion of Privacy'), 34);

-- Thêm bài hát vào album của Megan Thee Stallion
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Suga"
('Savage', 230, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Captain Hook', 240, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('B.I.T.C.H.', 250, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Hit My Phone', 245, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Sugar Baby', 235, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Cry Baby', 240, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('What’s New', 230, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Intercourse', 240, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),
('Savage Remix', 245, '2020-03-06', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Suga'), 34),

-- Album "Good News"
('Good News', 240, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Body', 235, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Do It On the Tip', 245, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Girls in the Hood', 240, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Cry Baby', 235, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Freak', 245, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Hot Girl Summer', 230, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Savage Remix', 240, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34),
('Big Ole Freak', 230, '2020-11-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Good News'), 34);
-- Thêm bài hát vào album của Doja Cat
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Amala"
('Go To Town', 210, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('So High', 230, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Moo!', 240, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Roll With Us', 245, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Freak', 250, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Tia Tamera', 240, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Want You', 230, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Downtown', 220, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),
('Bye Bitch', 240, '2018-03-30', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Amala'), 34),

-- Album "Hot Pink"
('Juicy', 230, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Say So', 240, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Like That', 235, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Cyber Sex', 250, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Streets', 245, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Talk Dirty', 240, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Wine', 235, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Bottom Bitch', 240, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34),
('Need to Know', 250, '2019-11-07', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hot Pink'), 34);

-- Thêm bài hát vào album của Lil Nas X
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "7"
('Old Town Road', 130, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('Panini', 210, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('Rodeo', 240, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('Bring U Down', 220, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('C7osure', 240, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('Kick It', 230, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('F9mily', 225, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34),
('Don’t Want It', 215, '2019-06-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '7'), 34);

-- Thêm bài hát vào album của Travis Scott
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Astroworld"
('SICKO MODE', 320, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('STARGAZING', 260, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('STOP TRYING TO BE GOD', 245, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('R.I.P. SCREW', 240, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('NO BYSTANDERS', 250, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('YOSEMITE', 230, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('HOUSTONFORNIA', 240, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('SKELETONS', 245, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('WAKE UP', 220, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('CAN’T SAY', 235, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('5% TINT', 230, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('BUTTERFLY EFFECT', 240, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('GATTI', 250, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('HOUSTONFORNIA', 245, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('HIGHEST IN THE ROOM', 220, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34),
('SICKO MODE REMIX', 320, '2018-08-03', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Astroworld'), 34);

-- Thêm bài hát vào album của Future
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "DS2"
('Thought It Was a Drought', 260, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Blow a Bag', 250, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Where Ya At', 240, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('F*** Up Some Commas', 255, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Stick Talk', 245, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('I Serve the Base', 230, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Slave Master', 235, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Where Ya At', 240, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),
('Trap Niggas', 230, '2015-07-17', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DS2'), 34),

-- Album "Hndrxx"
('Selfish', 245, '2017-02-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hndrxx'), 34),
('Incredible', 240, '2017-02-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hndrxx'), 34),
('Commas', 250, '2017-02-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hndrxx'), 34),
('Poppin', 235, '2017-02-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hndrxx'), 34),
('March Madness', 260, '2017-02-24', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Hndrxx'), 34);
-- Thêm bài hát vào album của Nas
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Illmatic"
('N.Y. State of Mind', 240, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('Life\'s a Bitch', 245, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('The World Is Yours', 255, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('Halftime', 220, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('Memory Lane', 245, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('One Love', 250, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('Represent', 230, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('It Ain\'t Hard to Tell', 255, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('Ain\'t No Such Thing', 250, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),
('The Genesis', 235, '1994-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Illmatic'), 34),

-- Album "It Was Written"
('The Message', 240, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Take It In Blood', 235, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Street Dreams', 250, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('I Gave You Power', 245, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Watch Dem Niggas', 240, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Affirmative Action', 250, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Nas Is Coming', 245, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Black Girl Lost', 240, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('Suspect', 230, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34),
('You Owe Me', 255, '1996-07-02', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'It Was Written'), 34);

-- Thêm bài hát vào album của Kendrick Lamar
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "DAMN."
('DNA.', 230, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('HUMBLE.', 220, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('ELEMENT.', 235, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('LOYALTY.', 240, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('PRIDE.', 250, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('FEEL.', 245, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('LOVE.', 230, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('XXX.', 240, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('FEAR.', 245, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),
('GOD.', 230, '2017-04-14', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'DAMN.'), 34),

-- Album "To Pimp a Butterfly"
('Wesley\'s Theory', 250, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('For Free?', 230, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('King Kunta', 240, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('Institutionalized', 245, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('These Walls', 250, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('U', 235, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('Alright', 240, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('For Sale?', 245, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34),
('Momma', 230, '2015-03-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'To Pimp a Butterfly'), 34);

-- Thêm bài hát vào album của J. Cole
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "2014 Forest Hills Drive"
('January 28th', 240, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('Wet Dreamz', 230, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('03\' Adolescence', 250, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('A Tale of 2 Citiez', 245, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('Fire Squad', 240, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('St. Tropez', 230, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('G.O.M.D.', 250, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('Love Yourz', 240, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),
('Note to Self', 255, '2014-12-09', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = '2014 Forest Hills Drive'), 34),

-- Album "KOD"
('KOD', 240, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('ATM', 230, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Motiv8', 245, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('KOD', 240, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Friends', 255, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Once an Addict', 245, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('The Cut Off', 250, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Close', 235, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Brackets', 240, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34),
('Window Pain', 245, '2018-04-20', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'KOD'), 34);

-- Thêm bài hát vào album của Logic
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Under Pressure"
('Intro', 210, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Soul Food', 250, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Nikki', 245, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Growing Pains', 240, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('The Come Up', 230, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Under Pressure', 240, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Till the End', 255, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('Paradise', 250, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),
('The Man Who Fell from the Sky', 245, '2014-10-21', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Under Pressure'), 34),

-- Album "The Incredible True Story"
('Contact', 240, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Fade Away', 250, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('The Incredible True Story', 245, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Paradise', 240, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Young Jedi', 230, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Intermission', 225, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('The Cube', 235, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Like Me', 245, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('Under Pressure', 230, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34),
('City Lights', 245, '2015-11-13', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'The Incredible True Story'), 34);

-- Thêm bài hát vào album của Lizzo
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID) VALUES
-- Album "Cuz I Love You"
('Cuz I Love You', 240, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Juice', 235, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Tempo', 250, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Soulmate', 245, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Good as Hell', 240, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Truth Hurts', 255, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),
('Lingerie', 230, '2019-04-19', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Cuz I Love You'), 34),

-- Album "Special"
('About Damn Time', 240, '2022-07-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Special'), 34),
('2 Be Loved', 230, '2022-07-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Special'), 34),
('Special', 250, '2022-07-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Special'), 34),
('I Love You Bitch', 245, '2022-07-15', 'English', (SELECT AlbumID FROM Album WHERE AlbumName = 'Special'), 34);
-- Thêm song vào album chưa có bài hát naofooo ----
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'Starboy'
('Starboy', 230, '2016-11-25', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Starboy' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Party Monster', 249, '2016-11-25', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Starboy' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('False Alarm', 220, '2016-11-25', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Starboy' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),

-- Bài hát cho album 'Chill: Brazil (Disc 2)'
('Bossa Nova 1', 180, '2002-04-12', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Bossa Nova' LIMIT 1)),
('Bossa Nova 2', 210, '2002-04-12', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Bossa Nova' LIMIT 1)),
('Chill Vibes', 200, '2002-04-12', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Bossa Nova' LIMIT 1));
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'Unorthodox Jukebox'
('Locked Out of Heaven', 232, '2012-12-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Unorthodox Jukebox' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1)),
('When I Was Your Man', 210, '2012-12-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Unorthodox Jukebox' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1)),

-- Bài hát cho album 'Dangerous Woman'
('Dangerous Woman', 215, '2016-05-20', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Dangerous Woman' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1)),
('Into You', 243, '2016-05-20', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Dangerous Woman' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1)),

-- Bài hát cho album 'Acústico MTV [Live]'
('Song 1 - Acústico MTV', 180, '2000-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Acústico MTV [Live]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Acoustic' LIMIT 1)),
('Song 2 - Acústico MTV', 200, '2000-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Acústico MTV [Live]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Acoustic' LIMIT 1)),

-- Bài hát cho album 'Cidade Negra - Hits'
('Song 1 - Cidade Negra', 220, '2010-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cidade Negra - Hits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Reggae' LIMIT 1)),
('Song 2 - Cidade Negra', 230, '2010-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cidade Negra - Hits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Reggae' LIMIT 1)),

-- Bài hát cho album 'Na Pista'
('Song 1 - Na Pista', 240, '2005-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Na Pista' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Electronic' LIMIT 1)),
('Song 2 - Na Pista', 260, '2005-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Na Pista' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Electronic' LIMIT 1));
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'Axé Bahia 2001'
('Axé Song 1', 210, '2001-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Axé Bahia 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Axé' LIMIT 1)),
('Axé Song 2', 190, '2001-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Axé Bahia 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Axé' LIMIT 1)),

-- Bài hát cho album 'Carnaval 2001'
('Carnaval Song 1', 200, '2001-02-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Carnaval 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Samba' LIMIT 1)),
('Carnaval Song 2', 220, '2001-02-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Carnaval 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Samba' LIMIT 1)),

-- Bài hát cho album 'Sambas De Enredo 2001'
('Enredo Song 1', 250, '2001-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Sambas De Enredo 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Samba' LIMIT 1)),
('Enredo Song 2', 230, '2001-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Sambas De Enredo 2001' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Samba' LIMIT 1)),

-- Bài hát cho album 'Vozes do MPB'
('MPB Song 1', 200, '2000-11-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vozes do MPB' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('MPB Song 2', 180, '2000-11-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vozes do MPB' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),

-- Bài hát cho album 'BBC Sessions [Disc 1] [Live]'
('BBC Live Song 1', 270, '1995-10-12', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'BBC Sessions [Disc 1] [Live]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Live' LIMIT 1)),
('BBC Live Song 2', 260, '1995-10-12', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'BBC Sessions [Disc 1] [Live]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Live' LIMIT 1));
 -- Bài hát cho album 'Physical Graffiti [Disc 1]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Custard Pie', 390, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Rover', 340, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('In My Time of Dying', 480, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Houses of the Holy', 300, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Trampled Under Foot', 380, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Kashmir', 420, '1975-02-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Physical Graffiti [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'Goodbye & Good Riddance'
('All Girls Are the Same', 220, '2018-05-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Goodbye & Good Riddance' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hip-Hop' LIMIT 1)),
('Lucid Dreams', 239, '2018-05-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Goodbye & Good Riddance' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hip-Hop' LIMIT 1)),
('Lean wit Me', 172, '2018-05-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Goodbye & Good Riddance' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hip-Hop' LIMIT 1)),
('Wasted', 227, '2018-05-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Goodbye & Good Riddance' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hip-Hop' LIMIT 1)),

-- Bài hát cho album 'Channel Orange'
('Thinkin Bout You', 214, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Pyramids', 590, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Super Rich Kids', 310, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Lost', 241, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Sweet Life', 247, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1)),
('Bad Religion', 200, '2012-07-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Channel Orange' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'R&B' LIMIT 1));


INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'Fireball'
('Fireball', 220, '1971-09-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Fireball' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Mule', 290, '1971-09-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Fireball' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Knocking at Your Back Door: The Best Of Deep Purple in the 80\'s'
('Knocking at Your Back Door', 428, '1984-10-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Knocking at Your Back Door: The Best Of Deep Purple in the 80\'s' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Machine Head'
('Highway Star', 376, '1972-03-25', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Machine Head' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Smoke on the Water', 340, '1972-03-25', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Machine Head' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Purpendicular'
('Sometimes I Feel Like Screaming', 420, '1996-02-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Purpendicular' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Loosen My Strings', 349, '1996-02-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Purpendicular' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Slaves And Masters'
('King of Dreams', 307, '1990-10-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Slaves And Masters' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Cut Runs Deep', 347, '1990-10-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Slaves And Masters' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
-- Bài hát cho album 'The Battle Rages On'
('The Battle Rages On', 308, '1993-07-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Battle Rages On' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('A Twist in the Tale', 303, '1993-07-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Battle Rages On' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Bananas'
('House of Pain', 303, '2003-05-19', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Bananas' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Picture of Innocence', 353, '2003-05-19', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Bananas' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Now What?!'
('Above and Beyond', 315, '2013-04-26', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Now What?!' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('All the Time in the World', 348, '2013-04-26', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Now What?!' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Infinite'
('Time for Bedlam', 317, '2017-04-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Infinite' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Surprising', 353, '2017-04-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Infinite' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Whoosh!'
('Throw My Bones', 299, '2020-08-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Whoosh!' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Nothing at All', 339, '2020-08-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Whoosh!' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));


INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
-- Bài hát cho album 'King For A Day Fool For A Lifetime'
('Epic', 350, '1992-10-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'King For A Day Fool For A Lifetime' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Midlife Crisis', 290, '1992-10-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'King For A Day Fool For A Lifetime' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Ricochet', 240, '1992-10-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'King For A Day Fool For A Lifetime' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('A Small Victory', 270, '1992-10-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'King For A Day Fool For A Lifetime' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'The Real Thing'
('From Out of Nowhere', 300, '1989-06-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Real Thing' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Epic', 350, '1989-06-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Real Thing' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Falling to Pieces', 250, '1989-06-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Real Thing' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('We Care a Lot', 280, '1989-06-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Real Thing' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'Deixa Entrar'
('Deixa Entrar', 210, '1992-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deixa Entrar' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Abertura', 200, '1992-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deixa Entrar' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Na Carreira', 230, '1992-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deixa Entrar' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Coração Vagabundo', 240, '1992-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deixa Entrar' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),

-- Bài hát cho album 'In Your Honor [Disc 1]'
('All My Life', 240, '2005-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Best of You', 260, '2005-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('DOA', 230, '2005-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Hell', 270, '2005-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'In Your Honor [Disc 2]'
('Friend of a Friend', 240, '2005-06-13', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Over and Out', 270, '2005-06-13', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Last Song', 280, '2005-06-13', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Razor', 230, '2005-06-13', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'In Your Honor [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'One By One'
('All My Life', 230, '2002-10-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'One By One' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Times Like These', 220, '2002-10-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'One By One' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Low', 240, '2002-10-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'One By One' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Have It All', 250, '2002-10-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'One By One' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'The Colour And The Shape'
('Everlong', 240, '1997-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Colour And The Shape' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Monkey Wrench', 220, '1997-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Colour And The Shape' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('My Hero', 260, '1997-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Colour And The Shape' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Walking After You', 290, '1997-02-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Colour And The Shape' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),

-- Bài hát cho album 'My Way: The Best Of Frank Sinatra [Disc 1]'
('My Way', 270, '1969-12-30', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'My Way: The Best Of Frank Sinatra [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('Fly Me to the Moon', 180, '1964-08-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'My Way: The Best Of Frank Sinatra [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('New York, New York', 300, '1980-10-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'My Way: The Best Of Frank Sinatra [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('Strangers in the Night', 240, '1966-03-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'My Way: The Best Of Frank Sinatra [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),

-- Bài hát cho album 'Roda De Funk'
('Funkando', 210, '2015-09-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Roda De Funk' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Funk' LIMIT 1));
-- Bài hát cho album 'Unplugged'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Layla (Unplugged)', 355, '1992-08-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Unplugged' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Tears In Heaven (Unplugged)', 290, '1992-08-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Unplugged' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Wonderful Tonight (Unplugged)', 355, '1992-08-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Unplugged' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Album Of The Year'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('The Unquiet Grave', 240, '2000-10-10', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Album Of The Year' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Ashes In The Wind', 290, '2001-05-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Album Of The Year' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('On The Road Again', 245, '2001-05-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Album Of The Year' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));
-- Bài hát cho album 'Djavan Ao Vivo - Vol. 02'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Oceano', 255, '1989-07-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 02' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Se', 232, '1991-06-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 02' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Samurai', 251, '1989-07-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 02' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'Djavan Ao Vivo - Vol. 1'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Flor De Lis', 270, '1982-06-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Esquinas', 239, '1984-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Linha Do Equador', 260, '1984-04-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Djavan Ao Vivo - Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'The Cream Of Clapton'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Tears In Heaven', 290, '1992-01-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Cream Of Clapton' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Layla', 245, '1970-11-09', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Cream Of Clapton' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Cocaine', 238, '1977-12-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Cream Of Clapton' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));
-- Bài hát cho album 'Cássia Eller - Sem Limite [Disc 1]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Malandragem', 210, '1990-03-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cássia Eller - Sem Limite [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('O Segundo Sol', 245, '1999-09-20', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cássia Eller - Sem Limite [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'Vault: Def Leppard's Greatest Hits'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Pour Some Sugar On Me', 250, '1987-05-30', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vault: Def Leppard\'s Greatest Hits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Love Bites', 245, '1988-05-23', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vault: Def Leppard\'s Greatest Hits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Hysteria', 250, '1987-08-03', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vault: Def Leppard\'s Greatest Hits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Outbreak'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Zombie', 239, '1994-09-06', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Outbreak' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Shine', 245, '1996-10-29', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Outbreak' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));
-- Bài hát cho album 'Chronicle, Vol. 1'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Bad Moon Rising', 120, '1969-04-16', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Green River', 140, '1969-08-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Proud Mary', 230, '1969-01-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 1' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Chronicle, Vol. 2'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Down on the Corner', 200, '1969-09-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 2' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Fortunate Son', 170, '1969-10-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 2' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Who\'ll Stop the Rain', 220, '1970-01-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chronicle, Vol. 2' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Cássia Eller - Coleção Sem Limite [Disc 2]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('O Mundo é Um Moinho', 230, '1995-11-10', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cássia Eller - Coleção Sem Limite [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Malandragem', 210, '1990-03-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cássia Eller - Coleção Sem Limite [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('O Segundo Sol', 245, '1999-09-20', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Cássia Eller - Coleção Sem Limite [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'The Essential Miles Davis [Disc 2]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('So What', 545, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('Freddie Freeloader', 590, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('All Blues', 555, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 2]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1));

-- Bài hát cho album 'Up An\' Atom'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Up An\' Atom', 150, '1958-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Up An\' Atom' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('Swing Spring', 270, '1958-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Up An\' Atom' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('The Scene Is Clean', 300, '1958-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Up An\' Atom' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1));

-- Bài hát cho album 'Vinícius De Moraes - Sem Limite'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Chega de Saudade', 230, '1958-11-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vinícius De Moraes - Sem Limite' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Garota de Ipanema', 260, '1962-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vinícius De Moraes - Sem Limite' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Águas de Março', 290, '1972-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Vinícius De Moraes - Sem Limite' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));
-- Bài hát cho album 'Deep Purple In Rock'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Speed King', 300, '1970-06-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deep Purple In Rock' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1)),
('Child in Time', 420, '1970-06-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deep Purple In Rock' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1)),
('Black Night', 240, '1970-06-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Deep Purple In Rock' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1));

-- Bài hát cho album 'Stormbringer'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Stormbringer', 300, '1974-11-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Stormbringer' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1)),
('Holy Man', 400, '1974-11-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Stormbringer' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1)),
('You Can’t Do It Right', 245, '1974-11-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Stormbringer' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Hard Rock' LIMIT 1));

-- Bài hát cho album 'Supernatural'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Smooth', 271, '1999-06-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Supernatural' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Latin' LIMIT 1)),
('Maria Maria', 300, '1999-06-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Supernatural' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Latin' LIMIT 1)),
('Put Your Lights On', 283, '1999-06-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Supernatural' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Latin' LIMIT 1));

-- Bài hát cho album 'The Essential Miles Davis [Disc 1]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('So What', 545, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('Freddie Freeloader', 590, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1)),
('All Blues', 555, '1959-08-17', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Essential Miles Davis [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz' LIMIT 1));
-- Bài hát cho album 'Minha História'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('O Mundo é um Moinho', 210, '1999-09-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Aquarela do Brasil', 250, '1999-09-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Corcovado', 200, '1999-09-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'MK III The Final Concerts [Disc 1]'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Smoke on the Water', 300, '1975-04-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'MK III The Final Concerts [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Highway Star', 340, '1975-04-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'MK III The Final Concerts [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Space Truckin', 380, '1975-04-07', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'MK III The Final Concerts [Disc 1]' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'The Final Concerts (Disc 2)'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Child in Time', 420, '1975-04-08', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Final Concerts (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('The Mule', 400, '1975-04-08', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Final Concerts (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Lazy', 370, '1975-04-08', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Final Concerts (Disc 2)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Come Taste The Band'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Comin’ Home', 260, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Come Taste The Band' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Lady Luck', 300, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Come Taste The Band' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('I Need Love', 320, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Come Taste The Band' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));
-- Bài hát cho album 'Heart of the Night'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Heart of the Night', 250, '1988-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Heart of the Night' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1)),
('Night Moves', 290, '1986-08-05', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Heart of the Night' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Long Night', 240, '1988-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Heart of the Night' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Pop' LIMIT 1));

-- Bài hát cho album 'International Superhits'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Basket Case', 210, '1994-02-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'International Superhits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Punk Rock' LIMIT 1)),
('Good Riddance (Time of Your Life)', 212, '1997-10-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'International Superhits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Punk Rock' LIMIT 1)),
('When I Come Around', 230, '1994-02-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'International Superhits' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Punk Rock' LIMIT 1));

-- Bài hát cho album 'Into The Light'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Into The Light', 250, '1998-06-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Into The Light' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Shine', 260, '1998-06-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Into The Light' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Hold On', 230, '1998-06-15', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Into The Light' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Meus Momentos'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Meus Momentos', 240, '2001-10-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Meus Momentos' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Tempo Perdido', 260, '2001-10-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Meus Momentos' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('O Mundo é um Moinho', 220, '2001-10-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Meus Momentos' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));
-- Bài hát cho album 'The Rise and Fall of Ziggy Stardust'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Starman', 240, '1972-04-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Rise and Fall of Ziggy Stardust' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Ziggy Stardust', 200, '1972-04-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Rise and Fall of Ziggy Stardust' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Rock ‘n’ Roll Suicide', 300, '1972-04-28', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Rise and Fall of Ziggy Stardust' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Garage Inc. (Disc 1)'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Turn the Page', 340, '1998-11-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Garage Inc. (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Heavy Metal' LIMIT 1)),
('The Wait', 250, '1998-11-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Garage Inc. (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Heavy Metal' LIMIT 1)),
('Loverman', 320, '1998-11-24', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Garage Inc. (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Heavy Metal' LIMIT 1));

-- Bài hát cho album 'Greatest Hits II'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Under Pressure', 250, '1981-10-26', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Hits II' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Another One Bites the Dust', 220, '1980-08-22', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Hits II' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('I Want to Break Free', 230, '1984-04-02', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Hits II' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));

-- Bài hát cho album 'Greatest Kiss'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('I Was Made for Lovin’ You', 240, '1979-08-20', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Kiss' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Rock and Roll All Nite', 250, '1975-02-12', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Kiss' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1)),
('Detroit Rock City', 235, '1976-02-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Greatest Kiss' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Rock' LIMIT 1));
-- Bài hát cho album 'Bongo Fury'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Carolina Hard-Core Ecstasy', 320, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Bongo Fury' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz Rock' LIMIT 1)),
('Inca Roads', 420, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Bongo Fury' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz Rock' LIMIT 1)),
('Don’t Eat the Yellow Snow', 350, '1975-11-01', 'English', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Bongo Fury' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Jazz Rock' LIMIT 1));

-- Bài hát cho album 'Chill: Brazil (Disc 1)'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Águas de Março', 250, '1972-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Bossa Nova' LIMIT 1)),
('Sampa', 300, '1990-08-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Mas Que Nada', 180, '1963-10-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Chill: Brazil (Disc 1)' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Samba' LIMIT 1));

-- Bài hát cho album 'The Best of Ed Motta'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Manuel', 285, '1990-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Best of Ed Motta' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Festa', 310, '1997-05-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Best of Ed Motta' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Só Você', 270, '1997-05-15', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'The Best of Ed Motta' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Bài hát cho album 'Elis Regina-Minha História'
INSERT INTO Songs (SongName, Duration, PublishedDate, Language, AlbumID, GenreID)
VALUES
('Águas de Março', 250, '1972-03-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Elis Regina-Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'Bossa Nova' LIMIT 1)),
('O Leãozinho', 220, '1983-01-01', 'Portuguese', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Elis Regina-Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1)),
('Alfonsina y El Mar', 300, '1982-10-01', 'Spanish', 
 (SELECT AlbumID FROM Album WHERE AlbumName = 'Elis Regina-Minha História' LIMIT 1), 
 (SELECT GenreID FROM Genres WHERE GenreName = 'MPB' LIMIT 1));

-- Insert 200 PlaylistID and SongID combinations into Playlist_Songs
INSERT INTO Playlist_Songs (PlaylistID, SongID) 
VALUES
(1, 5), (1, 10), (1, 15), (1, 20), 
(1, 25), (1, 30), (1, 35), (1, 40),
(1, 45), (1, 50), (1, 55), (1, 60),
(2, 65), (2, 70), (2, 75), (2, 80),
(2, 85), (2, 90), (2, 95), (2, 100),
(3, 105), (3, 110), (3, 115), (3, 120),
(3, 125), (3, 130), (3, 135), (3, 140),
(4, 145), (4, 150), (4, 155), (4, 160),
(4, 165), (4, 170), (4, 180),
(5, 185), (5, 190), (5, 195), (5, 200),
(5, 205), (5, 210), (5, 215), (5, 220),
(6, 225), (6, 230), (6, 235), (6, 240),
(6, 245), (6, 250), (6, 255), (6, 260),
(7, 265), (7, 270), (7, 275), (7, 280),
(7, 285), (7, 290), (7, 295), (7, 300),
(8, 305), (8, 310), (8, 315), (8, 320),
(8, 325), (8, 330), (8, 335), (8, 340),
(9, 345), (9, 350), (9, 355), (9, 360),
(9, 365), (9, 370), (9, 375), (9, 380),
(10, 385), (10, 390), (10, 395), (10, 400),
(10, 405), (10, 410), (10, 415), (10, 420),
(11, 425), (11, 430), (11, 435), (11, 440),
(11, 445), (11, 450), (11, 455), (11, 460),
(12, 465), (12, 470), (12, 475), (12, 480),
(12, 485), (12, 490), (12, 495), (12, 500),
(13, 505), (13, 510), (13, 515), (13, 520),
(13, 525), (13, 530), (13, 535), (13, 540),
(14, 545), (14, 550), (14, 555), (14, 560),
(14, 565), (14, 570), (14, 575), (14, 580),
(15, 585), (15, 590), (15, 595), (15, 600),
(15, 605), (15, 610), (15, 615), (15, 620),
(16, 625), (16, 630), (16, 635), (16, 640),
(16, 645), (16, 650), (16, 655), (16, 660),
(17, 665), (17, 670), (17, 675), (17, 680),
(17, 685), (17, 690), (17, 695), (17, 700),
(18, 705), (18, 710), (18, 715), (18, 720),
(18, 725), (18, 730), (18, 735), (18, 740),
(19, 745), (20, 1077), (20, 1030), (20, 1134), 
(20, 1225), (20, 355), (20, 1053),
(21, 523), (21, 758), (21, 893), (21, 745), (21, 618), (21, 272),
(22, 686), (22, 419), (22, 127), (22, 375), (22, 1093), (22, 276),
(23, 61), (23, 913), (23, 940), (23, 963), (23, 80), (23, 201),
(24, 1225), (24, 1076), (24, 546), (24, 247), (24, 670), (24, 1198),
(25, 840), (25, 901), (25, 969), (25, 327), (25, 391), (25, 624),
(26, 374), (26, 1242), (26, 971), (26, 930), (26, 767), (26, 672),
(27, 121), (27, 1014), (27, 477), (27, 283), (27, 271), (27, 357),
(28, 485), (28, 202), (28, 82), (28, 753), (28, 17), (28, 587),
(29, 20), (29, 443), (29, 390), (29, 194), (29, 29), (29, 586),
(30, 73), (30, 757), (30, 825), (30, 848), (30, 1141), (30, 460),
(31, 125), (31, 534), (31, 897), (31, 806), (31, 455), (31, 935),
(32, 522), (32, 180), (32, 585), (32, 575), (32, 814), (32, 643),
(33, 975), (33, 1118), (33, 972), (33, 688), (33, 254), (33, 1175),
(34, 376), (34, 713), (34, 67), (34, 1112), (34, 504), (34, 368),
(35, 704), (35, 1103), (35, 727), (35, 777), (35, 1137), (35, 670),
(36, 360), (36, 186), (36, 1101), (36, 38), (36, 876), (36, 613),
(37, 304), (37, 1153), (37, 999), (37, 499), (37, 748), (37, 1156),
(38, 443), (38, 406), (38, 314), (38, 1111), (38, 1094), (38, 1112),
(39, 876), (39, 1027), (39, 645), (39, 1244), (39, 1138), (39, 516),
 (40, 1010), (40, 1134), (40, 1083), (40, 761), (40, 1027), (40, 284),
(41, 1023), (41, 527), (41, 1131), (41, 743), (41, 494), (41, 1208),
(42, 411), (42, 999), (42, 515), (42, 759), (42, 235), (42, 314),
(43, 48), (43, 967), (43, 570), (43, 771), (43, 1073), (43, 922),
(44, 561), (44, 1114), (44, 152), (44, 707), (44, 14), (44, 1154),
(45, 1138), (45, 1133), (45, 1076), (45, 919), (45, 1099), (45, 856),
(46, 1028), (46, 1088), (46, 881), (46, 703), (46, 1167), (46, 653),
(47, 660), (47, 459), (47, 296), (47, 390), (47, 1221), (47, 651),
(48, 545), (48, 128), (48, 969), (48, 276), (48, 925), (48, 756),
(49, 545), (49, 415), (49, 1189), (49, 1208), (49, 99), (49, 392),
(50, 618), (50, 394), (50, 787), (50, 679), (50, 1073), (50, 605),
(51, 1101), (51, 855), (51, 769), (51, 389), (51, 1006), (51, 767),
(52, 372), (52, 1195), (52, 607), (52, 461), (52, 1131), (52, 961),
(53, 378), (53, 1046), (53, 768), (53, 1095), (53, 177), (53, 2),
(54, 732), (54, 362), (54, 857), (54, 156), (54, 1143), (54, 56),
(55, 467), (55, 463), (55, 268), (55, 449), (55, 378), (55, 550),
(56, 1086), (56, 827), (56, 507), (56, 1018), (56, 818), (56, 156),
(57, 671), (57, 710), (57, 691), (57, 552), (57, 784), (57, 1063),
(58, 139), (58, 723), (58, 681), (58, 915), (58, 178), (58, 1090),
(59, 136), (59, 295), (59, 439), (59, 677), (59, 1205), (59, 1116),
(60, 1235), (60, 1236), (60, 1237), (60, 1238), (60, 1239), (60, 1240),
(61, 1241), (61, 1242), (61, 1243), (61, 1244), (61, 1225), (61, 1200),
(62, 1195), (62, 1180), (62, 1170), (62, 1165), (62, 1160), (62, 1155),
(63, 1140), (63, 1135), (63, 1120), (63, 1115), (63, 1110), (63, 1105),
(64, 1090), (64, 1085), (64, 1070), (64, 1065), (64, 1060), (64, 1055),
(65, 1040), (65, 1035), (65, 1020), (65, 1015), (65, 1010), (65, 1005),
(66, 990), (66, 985), (66, 970), (66, 965), (66, 960), (66, 955),
(67, 940), (67, 935), (67, 920), (67, 915), (67, 910), (67, 905),
(68, 890), (68, 885), (68, 870), (68, 865), (68, 860), (68, 855),
(69, 840), (69, 835), (69, 820), (69, 815), (69, 810), (69, 805),
(70, 790), (70, 785), (70, 770), (70, 765), (70, 760), (70, 755),
(71, 740), (71, 735), (71, 720), (71, 715), (71, 710), (71, 705),
(72, 690), (72, 685), (72, 670), (72, 665), (72, 660), (72, 655),
(73, 640), (73, 635), (73, 620), (73, 615), (73, 610), (73, 605),
(74, 590), (74, 585), (74, 570), (74, 565), (74, 560), (74, 555),
(75, 540), (75, 535), (75, 520), (75, 515), (75, 510), (75, 505),
(76, 356), (76, 857), (76, 1123), (76, 435), (76, 921), (76, 287),
(77, 784), (77, 432), (77, 672), (77, 921), (77, 78), (77, 1145),
(78, 392), (78, 245), (78, 876), (78, 531), (78, 789), (78, 101),
(79, 590), (79, 867), (79, 113), (79, 752), (79, 311), (79, 478),
(80, 1083), (80, 562), (80, 395), (80, 120), (80, 789), (80, 932),
(81, 219), (81, 781), (81, 457), (81, 856), (81, 1103), (81, 234),
(82, 523), (82, 894), (82, 189), (82, 710), (82, 605), (82, 489),
(83, 765), (83, 432), (83, 231), (83, 119), (83, 876), (83, 1035),
(84, 980), (84, 613), (84, 439), (84, 1107), (84, 672), (84, 218),
(85, 540), (85, 235), (85, 908), (85, 712), (85, 376), (85, 1102),
(86, 314), (86, 502), (86, 431), (86, 1200), (86, 821), (86, 745),
(87, 230), (87, 998), (87, 571), (87, 764), (87, 1092), (87, 345),
(88, 657), (88, 845), (88, 201), (88, 725), (88, 331), (88, 1194),
(89, 401), (89, 759), (89, 602), (89, 999), (89, 104), (89, 1150),
(90, 670), (90, 329), (90, 800), (90, 521), (90, 283), (90, 1148),
(91, 493), (91, 671), (91, 567), (91, 231), (91, 708), (91, 1162),
(92, 315), (92, 890), (92, 642), (92, 298), (92, 1084), (92, 751),
(93, 120), (93, 789), (93, 354), (93, 621), (93, 401), (93, 923),
(94, 576), (94, 231), (94, 999), (94, 1111), (94, 411), (94, 815),
(95, 650), (95, 123), (95, 210), (95, 390), (95, 798), (95, 1050),
(96, 1001), (96, 567), (96, 321), (96, 479), (96, 890), (96, 712),
(97, 234), (97, 658), (97, 210), (97, 876), (97, 453), (97, 1049),
(98, 723), (98, 945), (98, 390), (98, 1121), (98, 128), (98, 1143),
(99, 509), (99, 321), (99, 654), (99, 120), (99, 987), (99, 1155),
(100, 872), (100, 612), (100, 321), (100, 543), (100, 891), (100, 1188);

INSERT INTO ArtistFollow (UserID, ArtistID, FollowDate) VALUES
(1, 2, '2020-10-23'),
(3, 2, '2021-01-15'),
(4, 3, '2022-05-18'),
(5, 4, '2024-09-10'),
(6, 5, '2020-10-23'),
(7, 6, '2024-09-15'),
(8, 7, '2024-09-20'),
(9, 8, '2024-09-25'),
(10, 9, '2020-06-17'),
(11, 10, '2021-09-21'),
(12, 11, '2024-09-30'),
(13, 12, '2023-04-11'),
(14, 13, '2020-12-07'),
(15, 14, '2024-10-05'),
(16, 15, '2024-11-10'),
(17, 16, '2023-05-10'),
(18, 17, '2024-11-15'),
(19, 18, '2024-11-20'),
(20, 19, '2024-12-01'),
(21, 20, '2023-03-17'),
(22, 21, '2020-09-11'),
(23, 22, '2021-05-05'),
(24, 23, '2024-10-10'),
(25, 24, '2023-06-13'),
(26, 25, '2020-01-20'),
(27, 26, '2021-11-28'),
(28, 27, '2024-09-28'),
(29, 28, '2024-10-15'),
(30, 29, '2024-11-01'),
(31, 30, '2021-07-22'),
(32, 31, '2022-12-05'),
(33, 32, '2023-09-14'),
(34, 33, '2020-05-09'),
(35, 34, '2021-06-10'),
(36, 35, '2022-09-15'),
(37, 36, '2024-12-03'),
(38, 37, '2024-11-25'),
(39, 38, '2021-04-19'),
(40, 39, '2022-07-26'),
(41, 40, '2023-10-20'),
(42, 41, '2024-09-05'),
(43, 42, '2024-09-10'),
(44, 43, '2024-09-12'),
(45, 44, '2024-10-12'),
(46, 45, '2024-11-07'),
(47, 46, '2021-12-19'),
(48, 47, '2022-10-08'),
(49, 48, '2023-07-01'),
(50, 49, '2020-07-29'),
(51, 50, '2024-10-30'),
(52, 27, '2020-08-20'),
(53, 10, '2023-02-15'),
(54, 13, '2024-12-01'),
(55, 44, '2022-08-31'),
(56, 30, '2022-03-06'),
(57, 11, '2020-04-16'),
(58, 13, '2024-10-10'),
(59, 43, '2024-12-02'),
(60, 3, '2022-05-19'),
(61, 28, '2020-07-08'),
(62, 48, '2024-09-12'),
(63, 20, '2020-06-10'),
(64, 26, '2022-10-06'),
(65, 50, '2021-12-30'),
(66, 26, '2021-11-11'),
(67, 40, '2023-03-05'),
(68, 49, '2024-09-19'),
(69, 37, '2022-07-27'),
(70, 28, '2024-09-22'),
(71, 30, '2021-04-23'),
(72, 32, '2023-03-01'),
(73, 9, '2020-02-03'),
(74, 44, '2023-03-04'),
(75, 29, '2023-10-30'),
(76, 11, '2024-10-11'),
(77, 13, '2020-12-21'),
(78, 44, '2022-01-11'),
(79, 35, '2024-11-18'),
(80, 49, '2021-11-19'),
(81, 4, '2024-09-13'),
(82, 35, '2020-07-29'),
(83, 4, '2020-02-14'),
(84, 18, '2020-05-29'),
(85, 11, '2021-04-02'),
(86, 11, '2020-12-24'),
(87, 23, '2020-07-18'),
(88, 16, '2023-08-20'),
(89, 21, '2024-11-10'),
(90, 6, '2022-12-08'),
(91, 28, '2024-09-30'),
(92, 6, '2023-08-22'),
(93, 13, '2024-11-15'),
(94, 24, '2021-02-16'),
(95, 46, '2024-12-05'),
(96, 21, '2022-06-16'),
(97, 39, '2024-10-20'),
(98, 9, '2022-12-24'),
(99, 30, '2023-04-03'),
(100, 25, '2022-04-18'),
(101, 18, '2020-12-16'),
(102, 39, '2021-04-14'),
(103, 33, '2020-05-17'),
(104, 45, '2020-12-27'),
(105, 30, '2023-12-25'),
(106, 41, '2020-01-30'),
(107, 3, '2020-10-11'),
(108, 38, '2024-10-14'),
(109, 4, '2024-09-16'),
(110, 20, '2020-11-05'),
(111, 45, '2020-08-06'),
(112, 15, '2020-02-17'),
(113, 1, '2024-09-20'),
(114, 4, '2022-01-21'),
(115, 31, '2022-03-18'),
(116, 37, '2021-01-17'),
(117, 4, '2021-08-31'),
(118, 15, '2024-11-12'),
(119, 10, '2023-02-18'),
(120, 16, '2020-02-29'),
(121, 46, '2021-08-08'),
(122, 15, '2020-09-20'),
(123, 28, '2024-09-25'),
(124, 29, '2024-09-28'),
(125, 43, '2022-07-08'),
(126, 8, '2020-04-11'),
(127, 9, '2022-03-15'),
(128, 20, '2024-10-01'),
(129, 45, '2021-07-25'),
(130, 17, '2021-09-09'),
(131, 50, '2021-06-21'),
(132, 42, '2020-09-05'),
(133, 47, '2022-06-27'),
(134, 40, '2020-01-10'),
(135, 40, '2024-09-20'),
(136, 24, '2024-12-01'),
(137, 40, '2021-07-28'),
(138, 31, '2021-04-24'),
(139, 18, '2024-11-05'),
(140, 30, '2024-11-10'),
(141, 41, '2024-12-07'),
(142, 28, '2024-10-05'),
(143, 20, '2024-09-22'),
(144, 49, '2024-09-19'),
(145, 7, '2024-09-25'),
(146, 6, '2024-09-10'),
(147, 47, '2024-10-30'),
(148, 49, '2024-11-13'),
(149, 28, '2024-12-03'),
(150, 1, '2024-11-11'),
(151, 12, '2024-09-18');

INSERT INTO Library (UserID, LibraryName, Type, TotalSongs, CreatedDate)
SELECT 
    FLOOR(1 + (RAND() * 200)),  -- Chọn ngẫu nhiên UserID từ 1 đến 200
    CASE 
        WHEN RAND() > 0.95 THEN CONCAT('Chill & Relax ', FLOOR(1 + (RAND() * 1000)))  -- Chill & Relax
        WHEN RAND() > 0.9 THEN CONCAT('Top 100 Charts ', FLOOR(1 + (RAND() * 1000)))    -- Top Charts
        WHEN RAND() > 0.85 THEN CONCAT('Indie Discovery ', FLOOR(1 + (RAND() * 500)))    -- Indie Music
        WHEN RAND() > 0.8 THEN CONCAT('90s Classics ', FLOOR(1 + (RAND() * 400)))        -- 90s Classics
        WHEN RAND() > 0.75 THEN CONCAT('Hip Hop & R&B ', FLOOR(1 + (RAND() * 600)))       -- Hip Hop & R&B
        WHEN RAND() > 0.7 THEN CONCAT('Summer Vibes ', FLOOR(1 + (RAND() * 700)))        -- Summer Vibes
        WHEN RAND() > 0.65 THEN CONCAT('Rock Anthems ', FLOOR(1 + (RAND() * 500)))        -- Rock Anthems
        WHEN RAND() > 0.6 THEN CONCAT('Personal Playlist ', FLOOR(1 + (RAND() * 200)))   -- Personal Playlist
        WHEN RAND() > 0.55 THEN CONCAT('Electronic Beats ', FLOOR(1 + (RAND() * 800)))    -- Electronic Beats
        WHEN RAND() > 0.5 THEN CONCAT('Throwback Hits ', FLOOR(1 + (RAND() * 300)))       -- Throwback Hits
        WHEN RAND() > 0.45 THEN CONCAT('Workout Power ', FLOOR(1 + (RAND() * 600)))       -- Workout Playlist
        WHEN RAND() > 0.4 THEN CONCAT('Acoustic Dreams ', FLOOR(1 + (RAND() * 700)))      -- Acoustic Playlist
        WHEN RAND() > 0.35 THEN CONCAT('Jazz Classics ', FLOOR(1 + (RAND() * 500)))       -- Jazz Music
        WHEN RAND() > 0.3 THEN CONCAT('Classical Symphony ', FLOOR(1 + (RAND() * 400)))   -- Classical Music
        WHEN RAND() > 0.25 THEN CONCAT('Deep House Vibes ', FLOOR(1 + (RAND() * 600)))    -- Deep House
        WHEN RAND() > 0.2 THEN CONCAT('Mellow Beats ', FLOOR(1 + (RAND() * 700)))         -- Mellow Beats
        WHEN RAND() > 0.15 THEN CONCAT('Lo-Fi Hip Hop ', FLOOR(1 + (RAND() * 500)))        -- Lo-Fi Beats
        WHEN RAND() > 0.1 THEN CONCAT('Pop Hits Collection ', FLOOR(1 + (RAND() * 800)))  -- Pop Hits
        WHEN RAND() > 0.05 THEN CONCAT('Country Roads ', FLOOR(1 + (RAND() * 500)))       -- Country Music
        ELSE CONCAT('Reggae Vibes ', FLOOR(1 + (RAND() * 300)))                           -- Reggae Music
    END,  -- Tên thư viện phong phú và đa dạng
    CASE 
        WHEN RAND() > 0.75 THEN 'FAVORITE' 
        WHEN RAND() > 0.5 THEN 'PERSONAL' 
        else 'SHARED' 
    END,  -- Loại thư viện đa dạng
    FLOOR(50 + (RAND() * 300)),  -- Số bài hát ngẫu nhiên từ 20 đến 500
    NOW() - INTERVAL FLOOR(RAND() * 730) DAY  -- Thời gian tạo thư viện trong 2 năm qua
FROM 
    (SELECT 1 FROM information_schema.tables LIMIT 200) AS temp;


INSERT INTO Library_Songs (LibraryID, SongID, AddedDate) VALUES
(1, 23, '2024-10-10'),
(52, 450, '2024-10-11'),
(73, 184, '2024-11-02'),
(43, 46, '2024-10-12'),
(87, 689, '2024-11-15'),
(70, 656, '2024-10-15'),
(66, 568, '2024-10-03'),
(92, 514, '2024-11-01'),
(86, 294, '2024-10-20'),
(97, 660, '2024-11-22'),
(25, 546, '2024-11-05'),
(84, 185, '2024-10-13'),
(44, 329, '2024-10-25'),
(9, 696, '2024-10-07'),
(64, 636, '2024-11-17'),
(53, 49, '2024-10-12'),
(24, 651, '2024-10-14'),
(4, 365, '2024-11-01'),
(100, 648, '2024-11-04'),
(32, 405, '2024-10-30'),
(87, 559, '2024-11-20'),
(86, 623, '2024-11-10'),
(98, 266, '2024-10-28'),
(29, 684, '2024-10-29'),
(73, 207, '2024-11-10'),
(60, 645, '2024-11-11'),
(64, 166, '2024-11-25'),
(27, 589, '2024-11-12'),
(12, 109, '2024-10-12'),
(19, 174, '2024-11-13'),
(88, 474, '2024-11-06'),
(27, 67, '2024-10-01'),
(74, 410, '2024-11-10'),
(66, 424, '2024-11-18'),
(60, 382, '2024-11-14'),
(14, 172, '2024-10-21'),
(60, 595, '2024-11-05'),
(87, 77, '2024-12-02'),
(13, 54, '2024-11-12'),
(65, 126, '2024-11-09'),
(61, 462, '2024-10-26'),
(43, 428, '2024-10-21'),
(7, 278, '2024-11-20'),
(86, 606, '2024-11-08'),
(26, 241, '2024-10-15'),
(71, 222, '2024-11-10'),
(42, 554, '2024-11-21'),
(89, 223, '2024-10-14'),
(22, 515, '2024-11-11'),
(64, 387, '2024-10-20'),
(22, 134, '2024-10-25'),
(50, 44, '2024-11-10'),
(96, 111, '2024-11-18'),
(61, 437, '2024-10-10'),
(60, 619, '2024-10-16'),
(7, 219, '2024-11-23'),
(86, 573, '2024-12-05'),
(5, 143, '2024-11-03'),
(47, 395, '2024-11-17'),
(81, 173, '2024-10-19'),
(61, 559, '2024-10-23'),
(85, 325, '2024-11-12'),
(79, 495, '2024-11-19'),
(79, 305, '2024-12-01'),
(65, 598, '2024-11-24'),
(15, 217, '2024-10-28'),
(3, 389, '2024-12-04'),
(3, 477, '2024-11-11'),
(73, 697, '2024-11-07'),
(68, 269, '2024-10-18'),
(13, 685, '2024-11-03'),
(33, 286, '2024-12-09'),
(49, 392, '2024-10-16'),
(24, 70, '2024-11-12'),
(44, 471, '2024-10-19'),
(89, 327, '2024-10-22'),
(78, 521, '2024-11-16'),
(63, 666, '2024-10-26'),
(13, 522, '2024-11-13'),
(63, 441, '2024-10-13'),
(36, 603, '2024-11-21'),
(76, 540, '2024-10-23'),
(99, 171, '2024-11-05'),
(35, 262, '2024-10-01'),
(82, 297, '2024-11-12'),
(53, 490, '2024-11-06'),
(24, 58, '2024-11-02'),
(62, 625, '2024-12-02'),
(36, 16, '2024-11-04'),
(74, 83, '2024-12-02'),
(19, 73, '2024-10-27'),
(89, 118, '2024-11-14'),
(36, 546, '2024-11-09'),
(71, 278, '2024-11-05'),
(24, 662, '2024-10-25'),
(93, 394, '2024-11-20'),
(91, 324, '2024-12-01'),
(51, 493, '2024-10-30'),
(31, 6, '2024-11-07'),
(26, 392, '2024-11-15'),
(10, 243, '2024-10-06'),
(62, 315, '2024-11-10'),
(49, 476, '2024-11-01'),
(75, 217, '2024-11-18'),
(18, 304, '2024-11-09'),
(29, 111, '2024-10-11'),
(77, 651, '2024-10-18'),
(6, 502, '2024-10-12'),
(71, 387, '2024-10-08'),
(53, 222, '2024-11-17'),
(12, 584, '2024-11-12'),
(90, 219, '2024-10-21'),
(33, 432, '2024-11-08'),
(84, 615, '2024-10-23'),
(57, 288, '2024-10-25'),
(47, 679, '2024-11-02'),
(94, 543, '2024-12-01'),
(25, 407, '2024-11-04'),
(14, 566, '2024-11-15'),
(96, 434, '2024-10-28'),
(83, 384, '2024-10-14'),
(52, 609, '2024-10-12'),
(23, 129, '2024-11-04'),
(45, 354, '2024-10-27'),
(78, 407, '2024-11-23'),
(55, 676, '2024-10-18'),
(20, 490, '2024-10-29'),
(98, 543, '2024-11-10'),
(42, 324, '2024-11-25'),
(60, 162, '2024-10-18'),
(5, 618, '2024-11-04'),
(70, 292, '2024-11-23'),
(11, 478, '2024-11-04'),
(63, 56, '2024-11-12'),
(88, 589, '2024-11-09'),
(32, 377, '2024-11-04'),
(61, 192, '2024-11-02'),
(41, 387, '2024-10-27'),
(82, 451, '2024-11-12'),
(43, 609, '2024-10-27'),
(97, 616, '2024-11-01'),
(31, 452, '2024-10-01'),
(41, 402, '2024-10-02'),
(51, 312, '2024-10-03'),
(71, 623, '2024-10-04'),
(61, 228, '2024-10-05'),
(50, 302, '2024-10-06'),
(43, 510, '2024-10-07'),
(61, 376, '2024-10-08'),
(62, 577, '2024-10-09'),
(53, 348, '2024-10-10'),
(83, 224, '2024-10-11'),
(72, 467, '2024-10-12'),
(47, 412, '2024-10-13'),
(61, 158, '2024-10-14'),
(39, 563, '2024-10-15'),
(70, 433, '2024-10-16'),
(60, 212, '2024-10-17'),
(53, 150, '2024-10-18'),
(48, 369, '2024-10-19'),
(42, 459, '2024-10-20'),
(63, 287, '2024-10-21'),
(72, 246, '2024-10-22'),
(58, 310, '2024-10-23'),
(64, 333, '2024-10-24'),
(67, 564, '2024-10-25'),
(45, 289, '2024-10-26'),
(63, 112, '2024-10-27'),
(54, 436, '2024-10-28'),
(59, 290, '2024-10-29'),
(66, 520, '2024-10-30'),
(73, 149, '2024-10-31'),
(75, 300, '2024-11-01'),
(77, 152, '2024-11-02'),
(71, 410, '2024-11-03'),
(62, 145, '2024-11-04'),
(69, 515, '2024-11-05'),
(73, 293, '2024-11-06'),
(56, 396, '2024-11-07'),
(70, 212, '2024-11-08'),
(55, 472, '2024-11-09'),
(59, 387, '2024-11-10'),
(61, 524, '2024-11-11'),
(52, 184, '2024-11-12'),
(64, 575, '2024-11-13'),
(50, 319, '2024-11-14'),
(62, 143, '2024-11-16'),
(66, 563, '2024-11-17'),
(60, 274, '2024-11-18'),
(75, 451, '2024-11-19'),
(57, 423, '2024-11-20'),
(69, 532, '2024-11-21'),
(64, 290, '2024-11-22'),
(66, 514, '2024-11-23'),
(70, 562, '2024-11-24'),
(63, 283, '2024-11-25'),
(72, 485, '2024-11-27'),
(75, 557, '2024-11-28'),
(68, 411, '2024-11-29'),
(72, 586, '2024-11-30'),
(65, 515, '2024-12-01'),
(63, 290, '2024-12-02'),
(59, 245, '2024-12-03'),
(67, 415, '2024-12-04'),
(66, 536, '2024-12-05'),
(64, 291, '2024-12-06'),
(63, 473, '2024-12-07'),
(61, 292, '2024-12-08'),
(62, 559, '2024-12-09'),
(63, 487, '2024-12-10'),
(60, 362, '2024-12-11'),
(65, 425, '2024-12-12'),
(67, 284, '2024-12-13'),
(69, 565, '2024-12-14'),
(62, 413, '2024-12-15');

INSERT INTO Ratings (UserID, SongID, Rating, Review, CreatedDate)
SELECT 
    U.UserID,
    FLOOR(1 + (RAND() * 748)),
    FLOOR(1 + (RAND() * 5)),
    CASE 
        WHEN RAND() > 0.5 THEN 'Great song!' 
        ELSE NULL 
    END,
    DATE_ADD(U.JoinedDate, INTERVAL (RAND() * 365) DAY)
FROM
    (SELECT UserID, JoinedDate FROM Users ORDER BY RAND() LIMIT 350) AS U; 

UPDATE ArtistFollow
SET FollowDate = DATE_ADD('2010-01-01', INTERVAL (RAND() * 900) DAY) ;
UPDATE Users
SET Member = CASE 
    WHEN RAND() < 0.4 THEN 'NORMAL'
    WHEN RAND() < 0.7 THEN 'PREMIUM'
    ELSE 'VIP'
END;

Alter table Album drop column GenreID;
select * from Album;
select * from Artist;
select * from Users;
select * from Genres;
select * from Playlists;
select * from Songs;
select * from Playlist_Songs;

select * from Ratings;
select * from Library;
select * from ArtistFollow;
select * from Album;
select * from Playlists;

