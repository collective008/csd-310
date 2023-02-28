/*
    Title: db_init.sql
    Author: Jerime LeBlanc
    Date: 28 February 2023
    Description: whatabook database initialization script.
*/
-- create and use whatabook database
CREATE DATABASE whatabook;
USE whatabook;

-- drop user if exists 
DROP USER IF EXISTS 'whatabook_user'@'localhost';

-- create whatabook_user and grant them all privileges to the whatabook database 
CREATE USER 'whatabook_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'MySQL8IsGreat!';
 
GRANT ALL PRIVILEGES ON whatabook.* TO'whatabook_user'@'localhost';

-- grant all privileges to the whatabook database to user whatabook_user on localhost
ALTER TABLE wishlist DROP FOREIGN KEY fk_book;
ALTER TABLE wishlist DROP FOREIGN KEY fk_user;

-- drop tables if present
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS user;

-- create user table
CREATE TABLE user (
    user_id   INT               NOT NULL       AUTO_INCREMENT,
    first_name  VARCHAR(75)     NOT NULL,
    last_name   VARCHAR(75)     NOT NULL,
    PRIMARY KEY(user_id)
);

-- create book table 
CREATE TABLE book (
    book_id      INT           NOT NULL        AUTO_INCREMENT,
    book_name    VARCHAR(200)  NOT NULL,
    details      VARCHAR(500),
    author       VARCHAR(200)  NOT NULL,
    PRIMARY KEY(book_id)
);

-- create store table 
CREATE TABLE store (
    store_id   INT             NOT NULL        AUTO_INCREMENT,
    locale     VARCHAR(500)    NOT NULL,
    store_hours VARCHAR(500)    NOT NULL,
    PRIMARY KEY(store_id)
);

-- create wishlist table
CREATE TABLE wishlist (
    wishlist_id   INT           NOT NULL        AUTO_INCREMENT,
    user_id       INT           NOT NULL,
    book_id       INT           NOT NULL,
    PRIMARY KEY(wishlist_id),
    CONSTRAINT fk_book
        FOREIGN KEY(book_id)
        REFERENCES book(book_id),
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
        REFERENCES user(user_id)
);

-- insert store records
INSERT INTO store(locale)
    VALUES('311 East Main Street, Waukesha, Wisconsin, 53189');
INSERT INTO store(store_hours)
    VALUES('Monday thru Saturday, 8 AM to 6 PM');

-- insert book records
INSERT INTO book(book_name, author, details)
    VALUES('YoYo 101', 'M. Duncan', 'Lets Play YoYos!');
INSERT INTO book(book_name, author, details)
    VALUES('Build a Plastic World', 'Ole Kirk Kristiansen', 'How to use Legos to build great things');
INSERT INTO book(book_name, author, details)
    VALUES('GI Joe 1983-1990', 'Mark Belomo', 'Ultimate Guide to Vintage GI Joe');
INSERT INTO book(book_name, author)
    VALUES('Python 101', 'Joe Smith');
INSERT INTO book(book_name, author)
    VALUES('MySQL', 'Brad Pitt');
INSERT INTO book(book_name, author)
    VALUES('Cats!', 'John Garfield');
INSERT INTO book(book_name, author)
    VALUES('Dogs', 'D. Lassie');
INSERT INTO book(book_name, author)
    VALUES('Lizads', 'T. Rex');
INSERT INTO book(book_name, author)
    VALUES('Bugs', 'A. A. Ant');

-- insert user records
INSERT INTO user(first_name, last_name) 
    VALUES('John', 'Doe');
INSERT INTO user(first_name, last_name)
    VALUES('Jane', 'Doe');
INSERT INTO user(first_name, last_name)
    VALUES('Abraham', 'Lincon');

-- insert wishlist records
INSERT INTO wishlist(user_id, book_id) 
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'John'), 
        (SELECT book_id FROM book WHERE book_name = 'YoYo 101')
    );
INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Jane'),
        (SELECT book_id FROM book WHERE book_name = 'build a Plastic World')
    );
INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Abraham'),
        (SELECT book_id FROM book WHERE book_name = 'GI Joe 1983-1990')
    );