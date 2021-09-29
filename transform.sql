------------
/* AUTHOR */
------------

-- List of all pubkeys which refer to homepages
CREATE TABLE temp1 AS(
    SELECT DISTINCT
        k AS pubkey
    FROM
        field
    WHERE
        p = 'title' AND
        v = 'Home Page'
);
​
-- Join homepage pubkeys to corresponding URLs 
CREATE TABLE temp2 AS(
    SELECT 
        k as pubkey,
        v as homepage
    FROM 
        field JOIN temp1 ON field.k = temp1.pubkey
    WHERE 
        p = 'url'
);
​
-- List of all unique author names with a homepage URL
CREATE TABLE temp3 AS(
    SELECT DISTINCT ON (v)
        v as name,
        homepage 
    FROM 
        field LEFT JOIN temp2 ON field.k = temp2.pubkey
    WHERE 
        p='author'
);
​
-- Insert author data into author table
CREATE SEQUENCE q; 
INSERT INTO author (select nextval('q') as id, name, homepage from temp3);
DROP SEQUENCE q;
​
-- Drop temporary tables
DROP TABLE IF EXISTS temp1, temp2, temp3 cascade;

-----------------
/* PUBLICATION */
-----------------
​
-- List of publications which are not homepages
CREATE TABLE truepubs AS(
    SELECT DISTINCT ON (k)
        k AS pubkey,
        v AS title
    FROM
        field
    WHERE 
        p = 'title' AND
        v <> 'Home Page'
);

-- Join truepubs with pub for publication type
CREATE TABLE temp1 AS(
    SELECT DISTINCT ON (pubkey)
        pubkey,
        title,
        pub.p AS type
    FROM
        truepubs LEFT JOIN pub ON truepubs.pubkey = pub.k  
);
​
-- Pubkey-year list
CREATE TABLE temp2 AS(
    SELECT
        k as pubkey,
        v AS year
    FROM
        field
    WHERE
        p = 'year'
);
​
-- Join in year
CREATE TABLE temp3 AS(
    SELECT DISTINCT ON (temp1.pubkey)
        temp1.pubkey,
        title,
        year,
        type
    FROM
        temp1 LEFT JOIN temp2 ON temp1.pubkey = temp2.pubkey  
);

-- Insert publication data into publication table
CREATE SEQUENCE q;
INSERT INTO publication (select nextval('q') as pubid, pubkey, title, CAST (year AS INTEGER), type from temp3);
​DROP SEQUENCE q; 
​
DROP TABLE IF EXISTS truepubs, temp1, temp2, temp3 cascade;

----------
/* BOOK */
----------
/*
create table book (
   pubid int,
   pubkey text,
   title text,
   year int,
   publisher text,
   isbn int,
   CONSTRAINT book_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
*/

-- Get books from publication table
CREATE TABLE temp1 AS(
    SELECT 
        pubid,
        pubkey,
        title,
        year
    FROM
        publication
    WHERE
        type = 'book'
);
​
-- Pubkey-isbn list
CREATE TABLE isbns AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as isbn
    FROM
        field
    WHERE
        p = 'isbn'
);
​
-- Join in isbn
CREATE TABLE temp2 AS(
    SELECT
        pubid,
        temp1.pubkey,
        title,
        year,
        isbn
    FROM 
        temp1 LEFT JOIN isbns ON temp1.pubkey = isbns.pubkey
);
​
-- Pubkey-publisher list
CREATE TABLE publishers AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as publisher
    FROM
        field
    WHERE
        p = 'publisher'
);
​
-- Join in publisher
CREATE TABLE temp3 AS(
    SELECT
        pubid,
        temp2.pubkey,
        title,
        year,
        isbn,
        publisher
    FROM 
        temp2 LEFT JOIN publishers ON temp2.pubkey = publishers.pubkey
);
​
-- Drop foreign key and insert book data into book table
ALTER TABLE book DROP CONSTRAINT book_fk CASCADE;
INSERT INTO book (SELECT pubid, pubkey, title, year, publisher, isbn FROM temp3);
​
-- Reinsert foreign key constraint
ALTER TABLE book ADD CONSTRAINT book_fk FOREIGN KEY (pubid) REFERENCES publication (pubid);
​
DROP TABLE temp1, temp2, temp3, isbns, publishers CASCADE;