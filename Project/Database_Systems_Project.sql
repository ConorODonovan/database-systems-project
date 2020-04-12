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
    address_country CHAR(2) NOT NULL,
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
    billing_address_country CHAR(2) NOT NULL,
    billing_address_postcode VARCHAR(10) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
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
    dev_id INT,
    pub_id INT,
    FOREIGN KEY(dev_id) REFERENCES developers(dev_id),
    FOREIGN KEY(pub_id) REFERENCES publishers(pub_id)
);

CREATE TABLE reviews (
	review_id INT AUTO_INCREMENT PRIMARY KEY,
    pos_or_neg CHAR(1),
    review_text VARCHAR(4096),
    user_id INT,
    game_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(game_id) REFERENCES games(game_id)
);

CREATE TABLE tags (
	tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(64)
);

CREATE TABLE screenshots (
	screenshot_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    game_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(game_id) REFERENCES games(game_id)
);

CREATE TABLE gamesowned (
	id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    game_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(game_id) REFERENCES games(game_id)
);

CREATE TABLE tagsgames (
	id INT AUTO_INCREMENT PRIMARY KEY,
    tag_id INT,
    game_id INT,
    FOREIGN KEY(tag_id) REFERENCES tags(tag_id),
    FOREIGN KEY(game_id) REFERENCES games(game_id)
);
