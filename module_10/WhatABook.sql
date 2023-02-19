CREATE DATABASE whatabook;
USE whatabook;

DROP USER IF EXISTS 'whatabook_user'@'localhost';

CREATE USER 'whatabook_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'MySQL8IsGreat!';
 
GRANT ALL PRIVILEGES ON whatabook.* TO'whatabook_user'@'localhost';

ALTER TABLE wishlist DROP FOREIGN KEY fk_book;
ALTER TABLE wishlist DROP FOREIGN KEY fk_user;

DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
    user_id   INT               NOT NULL        AUTO_INCREMENT,
    first_name  VARCHAR(75)     NOT NULL,
    last_name   VARCHAR(75)     NOT NULL,
    PRIMARY KEY(user_id)
);
CREATE TABLE book (
    book_id       INT           NOT NULL        AUTO_INCREMENT,
    book_names    VARCHAR(200)  NOT NULL,
    details       VARCHAR(500),
    author        VARCHAR(200)  NOT NULL,
    PRIMARY KEY(book_id)
);
CREATE TABLE store (
    store_id   INT              NOT NULL,
    locale    VARCHAR(500)      NOT NULL,
    PRIMARY KEY(store_id)
);
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

--store
INSERT INTO store(locale)
    VALUES('311 East Main Street, Waukesha, Wisconsin, 53189');

--books
INSERT INTO book(book_name, author, details)
    VALUES('YoYo 101', 'M. Duncan', 'Lets Play YoYos!');
INSERT INTO book(book_name, author, details)
    VALUES('Build a Plastic World', 'Ole Kirk Kristiansen', 'How to use Legos to build great things');
INSERT INTO book(book_name, author, details)
    VALUES('GI Joe 1983-1990', 'Mark Belomo', "Ultimate Guide to Vintage GI Joe");
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
--name
INSERT INTO user(first_name, last_name) 
    VALUES('John', 'Doe');
INSERT INTO user(first_name, last_name)
    VALUES('Jane', 'Doe');
INSERT INTO user(first_name, last_name)
    VALUES('Abraham', 'Lincon');
--wishlist
INSERT INTO wishlist(user_id, book_id) 
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'John'), 
        (SELECT book_id FROM book WHERE book_name = 'YoYo 101')
    );
INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Jane'),
        (SELECT book_id FROM book WHERE book_name = 'Build a Plastic World')
    );
INSERT INTO wishlist(user_id, book_id)
    VALUES (
        (SELECT user_id FROM user WHERE first_name = 'Abraham'),
        (SELECT book_id FROM book WHERE book_name = 'GI Joe 1983-1990')
    );