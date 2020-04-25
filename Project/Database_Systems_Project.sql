DROP DATABASE steam;

CREATE DATABASE steam;
USE steam;

CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    email_address VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    date_of_birth DATE NOT NULL,
    address_street VARCHAR(255) NOT NULL,
    address_city VARCHAR(30) NOT NULL,
    address_country VARCHAR(30) NOT NULL,
    address_postcode VARCHAR(10) NOT NULL
);

CREATE TABLE credit_card (
	cc_id INT AUTO_INCREMENT PRIMARY KEY,
    cc_type VARCHAR(24) NOT NULL,
    cc_number BIGINT(16) ZEROFILL,
    exp_date DATE,
    ccv SMALLINT(3) ZEROFILL,
    billing_address_street VARCHAR(255) NOT NULL,
    billing_address_city VARCHAR(30) NOT NULL,
    billing_address_country VARCHAR(30) NOT NULL,
    billing_address_postcode VARCHAR(10) NOT NULL,
    fk_user_id INT NOT NULL,
    FOREIGN KEY(fk_user_id) REFERENCES users(id)
);

CREATE TABLE developers (
	dev_id INT AUTO_INCREMENT PRIMARY KEY,
    dev_name VARCHAR(255)
);

CREATE TABLE publishers (
	pub_id INT AUTO_INCREMENT PRIMARY KEY,
    pub_name VARCHAR(255)
);

CREATE TABLE games (
	game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(32),
    release_date DATE,
    price DECIMAL(5,2),
    age_rating INT,
    copies_sold INT,
    fk_dev_id INT,
    fk_pub_id INT,
    FOREIGN KEY(fk_dev_id) REFERENCES developers(dev_id),
    FOREIGN KEY(fk_pub_id) REFERENCES publishers(pub_id)
);

CREATE TABLE reviews (
	review_id INT AUTO_INCREMENT PRIMARY KEY,
    pos_or_neg CHAR(1),
    review_text VARCHAR(4096),
    fk_user_id INT,
    fk_game_id INT,
    FOREIGN KEY(fk_user_id) REFERENCES users(id),
    FOREIGN KEY(fk_game_id) REFERENCES games(game_id)
);

CREATE TABLE tags (
	tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(64)
);

CREATE TABLE gamesowned (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fk_user_id INT,
    fk_game_id INT,
    FOREIGN KEY(fk_user_id) REFERENCES users(id),
    FOREIGN KEY(fk_game_id) REFERENCES games(game_id)
);

CREATE TABLE tagsgames (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fk_tag_id INT,
    fk_game_id INT,
    FOREIGN KEY(fk_tag_id) REFERENCES tags(tag_id),
    FOREIGN KEY(fk_game_id) REFERENCES games(game_id)
);

-- Data
INSERT INTO users (
	username,
    created_at,
	email_address,
	first_name,
	last_name,
    date_of_birth,
	address_street,
	address_city,
	address_country,
	address_postcode
)
VALUES
	("JohnSmith", "2015-04-16 12:05:11.412", "johnsmith@email.com", "John", "Smith", "1990-01-05", "2 Oak Street", "London", "United Kingdom", "A16B12"),
    ("JaneMurphy", "2017-01-22 11:45:22.147", "janemurphy@email.com", "Jane", "Murphy", "1985-06-20", "46 Elm Street", "Dublin", "Ireland", "C45D56"),
    ("GordonFreeman", "2010-12-10 20:15:50.456", "gordonfreeman@email.com", "Gordon", "Freeman", "1970-03-15", "101 Valve Lane", "New York", "USA", "H12L89"),
    ("Slayer99", "2019-11-07 14:30:55.336", "slayer99@email.com", "Alan", "Johnson", "1999-11-12", "14 Rodeo Drive", "Austin", "USA", "F78D45"),
    ("Carol123", "2020-02-23 10:41:32.492", "carol123@email.com", "Carol", "Anderson", "2005-10-01", "44 Sunset Lane", "Los Angeles", "USA", "B11Q23"),
    ("TheGameGod", "2018-07-09 04:55:32.825", "thegamegod@email.com", "Jack", "Dempsey", "2004-08-29", "17 Willow Drive", "Manchester", "United Kingdom", "E77G21"),
    ("AlexHanson", "2012-05-01 10:36:05.618", "alexhanson@email.com", "Alex", "Hanson", "1989-02-22", "222 Park Lane", "Cork", "Ireland", "R19T73"),
    ("AmazonWarrior", "2013-09-30 21:06:31.204", "amazonwarrior@email.com", "Sarah", "Harper", "1998-11-30", "96 Ocean Way", "Miami", "USA", "L55K77"),
    ("KateReeves", "2019-01-28 16:01:54.085", "katereeves@email.com", "Kate", "Reeves", "1982-03-15", "1010 Riverview Place", "Stockholm", "Sweden", "P46O82"),
    ("Batman42", "2014-02-08 15:17:03.109", "batman42@email.com", "Bruce", "Masterson", "2006-07-19", "5 Castle Street", "London", "United Kingdom", "I47J36");

INSERT INTO credit_card (
	cc_type,
    cc_number,
    exp_date,
    ccv,
    billing_address_street,
    billing_address_city,
    billing_address_country,
    billing_address_postcode,
    fk_user_id
)
VALUES
	("Visa", 6415862130120548, "2023-02-01", 563, "2 Oak Street", "London", "United Kingdom", "A16B12", 1),
    ("Visa", 9521402103695804, "2024-05-01", 485, "46 Elm Street", "Dublin", "Ireland", "C45D56", 2),
    ("Mastercard", 9504152015448488, "2023-06-01", 643, "101 Valve Lane", "New York", "USA", "H12L89", 3),
    ("Visa", 9960320155478415, "2025-09-01", 186, "14 Rodeo Drive", "Austin", "USA", "F78D45", 4),
    ("Mastercard", 3021540155484963, "2022-04-01", 431, "44 Sunset Lane", "Los Angeles", "USA", "B11Q23", 5),
    ("Visa", 7102502555416336, "2023-11-01", 951, "17 Willow Drive", "Manchester", "United Kingdom", "E77G21", 6),
    ("Mastercard", 4451236565899877, "2022-12-01", 841, "222 Park Lane", "Cork", "Ireland", "R19T73", 7),
    ("Mastercard", 1025449681557136, "2024-08-01", 271, "96 Ocean Way", "Miami", "USA", "L55K77", 8),
    ("Visa", 1482379546287319, "2024-06-01", 753, "1010 Riverview Place", "Stockholm", "Sweden", "P46O82", 9),
    ("Mastercard", 3366487752010185, "2022-07-01", 348, "5 Castle Street", "London", "United Kingdom", "I47J36", 10);

INSERT INTO developers (
	dev_name
)
VALUES
	("FromSoftware"),
    ("Capcom"),
    ("Ubisoft"),
    ("Rockstar");

INSERT INTO publishers (
	pub_name
)
VALUES
	("Namco Bandai Games"),
	("Capcom"),
    ("Activision"),
    ("Ubisoft"),
    ("Rockstar");

INSERT INTO games (
	title,
    genre,
    release_date,
    price,
    age_rating,
    copies_sold,
    fk_dev_id,
    fk_pub_id
)
VALUES
	("Dark Souls", "RPG", "2011-09-22", 19.99, 15, 800000, 1, 1),
    ("Resident Evil 7", "Action", "2017-01-24", 29.99, 18, 1200000, 2, 2),
    ("Sekiro: Shadows Die Twice", "RPG", "2019-03-22", 59.99, 15, 500000, 1, 3),
    ("Far Cry 4", "FPS", "2014-11-18", 14.99, 18, 1500000, 3, 4),
    ("Assassin's Creed: Odyssey", "Action", "2018-10-05", 39.99, 15, 2000000, 3, 4),
    ("Monster Hunter: World", "RPG", "2018-01-26", 49.99, 12, 3000000, 2, 2),
    ("Grand Theft Auto V", "Action", "2013-09-17", 29.99, 18, 10000000, 4, 5),
    ("Steep", "Sports", "2016-12-02", 9.99, 6, 750000, 3, 4),
    ("Watchdogs", "Action", "2014-05-27", 14.99, 15, 1250000, 3, 4),
    ("Red Dead Redemption 2", "Action", "2018-10-26", 59.99, 18, 4500000, 4, 5);

INSERT INTO reviews (
	pos_or_neg,
    review_text,
    fk_user_id,
    fk_game_id
)
VALUES
	("P", "Amazing!", 2, 1),
    ("P", "Great game!", 2, 5),
    ("N", "Boring!", 4, 2),
    ("P", "Fantastic!", 5, 1),
    ("N", "Too hard!", 6, 3),
    ("P", "Best game ever!", 6, 10),
    ("N", "Rubbish!", 6, 9),
    ("N", "Save your money!", 8, 8),
    ("P", "Must buy!", 10, 3),
    ("P", "Excellent!", 10, 6);

INSERT INTO tags (
	tag_name
)
VALUES
	("Action"),
	("Difficult"),
    ("Fantasy"),
    ("FPS"),
    ("Open World"),
    ("Sports"),
    ("Cars");

INSERT INTO gamesowned (
	fk_user_id,
    fk_game_id
)
VALUES
	(1, 2),
    (1, 4),
    (1, 6),
    (1, 8),
    (2, 1),
    (3, 3),
    (3, 5),
    (5, 2),
    (5, 5),
    (5, 7),
    (6, 9),
    (6, 10),
    (8, 5),
    (9, 1),
    (9, 2),
    (9, 3),
    (10, 5),
    (10, 7),
    (10, 9),
    (10, 10);

INSERT INTO tagsgames (
	fk_tag_id,
    fk_game_id
)
VALUES
	(1, 2),
    (1, 3),
    (1, 4),
    (2, 1),
    (2, 3),
    (3, 1),
    (3, 6),
    (4, 4),
    (5, 4),
    (5, 5),
    (5, 6),
    (5, 7),
    (5, 9),
    (5, 10),
    (6, 8),
    (7, 7);

-- Queries
-- What is the best-selling game?
SELECT 
	title AS "Title",
    copies_sold AS "Sales"
FROM games
WHERE copies_sold = (SELECT MAX(copies_sold) FROM games);

-- Who is the oldest user and what is their age?
SELECT
	username AS "User",
    (SELECT (DATEDIFF(CURDATE(), date_of_birth))/365) AS "Age"
FROM users
WHERE date_of_birth = (SELECT(MIN(date_of_birth)) FROM users);

-- How many users are from each country?
SELECT address_country AS "Country", COUNT(username) AS "Users"
	FROM users
GROUP BY address_country;

-- Views and Joins
-- View showing number of occurences of each tag, ordered by popularity
CREATE VIEW tagpopularity AS
	SELECT tag_name AS "Tag", COUNT(tags.tag_id) AS "No. of Games"
		FROM tags
	JOIN tagsgames
    ON tags.tag_id = tagsgames.fk_tag_id
	GROUP BY tag_name
    ORDER BY COUNT("No. of Games") DESC;
    
SELECT * FROM tagpopularity;
    
-- View showing each user and the number of games they own
CREATE VIEW gamesownedbyusers AS
	SELECT username AS "User", COUNT(users.id) AS "No. of Games"
		FROM users
	JOIN gamesowned
    ON users.id = gamesowned.fk_user_id
    GROUP BY fk_user_id
    ORDER BY COUNT("No. of Games") DESC;
    
SELECT * FROM gamesownedbyusers;

-- View showing score for each game based on positive reviews divided by total reviews
SELECT
	games.title AS Title,
    COUNT(CASE
			WHEN reviews.pos_or_neg = "P"
				THEN reviews.pos_or_neg
			ELSE NULL
            END)
            AS "Positive Reviews",
    COUNT(CASE
			WHEN reviews.pos_or_neg = "N"
				THEN reviews.pos_or_neg
			ELSE NULL
            END)
            AS 'Negative Reviews',
	IFNULL(
		CONCAT(
			COUNT(CASE
					WHEN reviews.pos_or_neg = "P"
						THEN reviews.pos_or_neg
					ELSE NULL
					END)/
				(COUNT(CASE
						WHEN reviews.pos_or_neg = "N"
							THEN reviews.pos_or_neg
						ELSE NULL
						END)
				+
				COUNT(CASE
						WHEN reviews.pos_or_neg = "P"
							THEN reviews.pos_or_neg
						ELSE NULL
						END))
			* 100, '%'),
		"No reviews")
    AS 'Score'
	FROM games
LEFT JOIN reviews
ON (games.game_id = reviews.fk_game_id AND reviews.pos_or_neg = "P")
OR (games.game_id = reviews.fk_game_id AND reviews.pos_or_neg = "N")
GROUP BY games.title;

-- Functions
-- Function to find total amount a user has spent
DROP FUNCTION IF EXISTS amountSpent;

DELIMITER //

CREATE FUNCTION amountSpent(param VARCHAR(30)) RETURNS DECIMAL(5,2)
BEGIN

	DECLARE num DECIMAL(5,2);
    
	SELECT SUM(games.price) INTO num
		FROM games
		JOIN gamesowned
		ON games.game_id = gamesowned.fk_game_id
        JOIN users
        ON users.id = gamesowned.fk_user_id
		WHERE users.username = param
		GROUP BY users.username;
        
        RETURN num;
END //

SELECT amountSpent("JaneMurphy") AS "Amount Spent";

-- Function to find out how much revenue a game generated
DROP FUNCTION IF EXISTS gameRevenue;

DELIMITER //

CREATE FUNCTION gameRevenue(param VARCHAR(255)) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE num DECIMAL(10,2);
		SELECT (games.price * games.copies_sold) INTO num
        FROM games
        WHERE games.title = param;
	
    RETURN num;
    
END //

SELECT gameRevenue("Dark Souls") AS "Total Revenue";

-- Function to find out the total revenue a developer has made
DROP FUNCTION IF EXISTS developerRevenue;

DELIMITER //

CREATE FUNCTION developerRevenue(param VARCHAR(255)) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE num DECIMAL(10,2);
    
		SELECT SUM(games.price) INTO num
			FROM games
		JOIN developers
			ON games.fk_dev_id = developers.dev_id
		JOIN gamesowned
			ON gamesowned.fk_game_id = games.game_id
		WHERE developers.dev_name = param
		GROUP BY developers.dev_name;
            
	RETURN num;
            
END //

SELECT developerRevenue("FromSoftware") AS "Developer Revenue";

-- Stored Procedures
