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

-------------
/* ARTICLE */
-------------
-- Get articles from publication table
CREATE TABLE temp1 AS(
    SELECT 
        pubid,
        pubkey,
        title,
        year
    FROM
        publication
    WHERE
        type = 'article'
);
​
-- Pubkey-journal list
CREATE TABLE journals AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as journal
    FROM
        field
    WHERE
        p = 'journal'
);
​
-- Pubkey-month list
CREATE TABLE months AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as month
    FROM
        field
    WHERE
        p = 'month'
);

-- Pubkey-volume list
CREATE TABLE volumes AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as volume
    FROM
        field
    WHERE
        p = 'volume'
);

-- Pubkey-number list
CREATE TABLE numbers AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as number
    FROM
        field
    WHERE
        p = 'number'
);

​
-- Join in article attrributes
CREATE TABLE temp2 AS(
    SELECT
        pubid,
        temp1.pubkey,
        title,
        year,
        journal,
        month, 
        volume,
        number
    FROM temp1 LEFT JOIN journals ON temp1.pubkey = journals.pubkey
               LEFT JOIN months ON temp1.pubkey = months.pubkey
               LEFT JOIN volumes ON temp1.pubkey = volumes.pubkey
               LEFT JOIN numbers ON temp1.pubkey = numbers.pubkey
);
​
-- Drop foreign key and insert article data into article table
ALTER TABLE article DROP CONSTRAINT article_fk CASCADE;
INSERT INTO article (SELECT pubid, pubkey, title, year, journal, month, volume, number FROM temp2);
​
-- Reinsert foreign key constraint
ALTER TABLE article ADD CONSTRAINT article_fk FOREIGN KEY (pubid) REFERENCES publication (pubid);
​
DROP TABLE IF EXISTS temp1, temp2, journals, months, volumes, numbers CASCADE;

----------
/* BOOK */
----------

-- Get incollections from publication table
CREATE TABLE temp1 AS(
    SELECT 
        pubid,
        pubkey,
        title,
        year
    FROM
        publication
    WHERE
        type = 'incollection'
);
​
​
-- Pubkey-booktitle list
CREATE TABLE collectionbooks AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as booktitle
    FROM
        field
    WHERE
        p = 'booktitle'
);
​
-- Join booktitles
CREATE TABLE temp2 AS(
    SELECT
        pubid,
        temp1.pubkey,
        title,
        year,
        booktitle
    FROM 
        temp1 LEFT JOIN collectionbooks ON temp1.pubkey = collectionbooks.pubkey
);
​
-- Create a temp table where we merge the book table and publication table so we can get the names of the books
-- If two books have the same title, drop one
CREATE TABLE temp3 AS(
    SELECT DISTINCT ON (publication.title)
        book.pubid,
        book.publisher,
        book.isbn,
        publication.title as booktitle
    FROM
        book
    LEFT JOIN publication
        ON book.pubid = publication.pubid
);
​
-- Join tables to get isbn and publisher
CREATE TABLE temp4 AS(
    SELECT
        temp2.pubid,
        temp2.pubkey,
        temp2.title,
        temp2.year,
        temp2.booktitle,
        temp3.isbn,
        temp3.publisher
    FROM
        temp2
    LEFT JOIN temp3
        ON temp2.booktitle = temp3.booktitle
);
​
-- Drop foreign key and insert book data into book table
ALTER TABLE incollection DROP CONSTRAINT incollection_fk CASCADE;
INSERT INTO incollection (SELECT pubid, pubkey, title, year, booktitle, publisher, isbn FROM iwannamakeanironmaidenreference);
​
-- Reinsert foreign key constraint
ALTER TABLE incollection ADD CONSTRAINT incollection_fk FOREIGN KEY (pubid) REFERENCES publication (pubid);
​
DROP TABLE IF EXISTS temp1, temp2, temp3, temp4, collectionbooks CASCADE;

-------------------
/* INPROCEEDINGS */
-------------------

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
        type = 'inproceedings'
);
​
-- Pubkey-Booktitle List
CREATE TABLE collectionbooks AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as booktitle
    FROM
        field
    WHERE
        p = 'booktitle'
);
​
-- Join in booktitle
CREATE TABLE temp2 AS(
    SELECT
        pubid,
        temp1.pubkey,
        title, 
        year,
        booktitle
    FROM 
        temp1
    LEFT JOIN collectionbooks
        ON temp1.pubkey = collectionbooks.pubkey
);
​
-- Pubkey-editor list
CREATE TABLE editors AS(
    SELECT DISTINCT ON (k)
        k as pubkey,
        v as editor
    FROM
        field
    WHERE
        p = 'editor'
);
​
-- Determine editors of booktitles
-- Dropping duplicate booktitles since each booktitle has one editor but an editor can edit multiple booktitles
CREATE TABLE temp3 AS(
    SELECT DISTINCT ON (field.v)
        editor,
        editors.pubkey,
        field.v AS booktitle
    FROM
        editors
    LEFT JOIN field ON editors.pubkey = field.k
);
​
-- Join tables by booktitle
CREATE TABLE temp4 AS(
    SELECT
        temp2.pubid,
        temp2.pubkey,
        temp2.title, 
        temp2.year,
        temp2.booktitle,
        temp3.editor
    FROM
        temp2
    LEFT JOIN temp3
        ON temp2.booktitle = temp3.booktitle
);
​​
-- Drop foreign key and insert book data into book table
ALTER TABLE inproceedings DROP CONSTRAINT inproceedings_fk CASCADE;
INSERT INTO inproceedings (SELECT pubid, pubkey, title, year, booktitle, editor FROM temp4);
​
-- Reinsert foreign key constraint
ALTER TABLE inproceedings ADD CONSTRAINT inproceedings_fk FOREIGN KEY (pubid) REFERENCES publication (pubid);
​
DROP TABLE IF EXISTS temp1, temp2, temp3, temp4, editors, collectionbooks CASCADE;

--------------
/* AUTHORED */
--------------
​
-- Extract pubkey-author pairs
CREATE TABLE temp1 AS(
    SELECT
        k AS pubkey,
        v AS name
    FROM
        field
    WHERE
        p = 'author'
);
​
-- Join author ids
CREATE TABLE temp2 AS(
    SELECT
        temp1.pubkey,
        temp1.name,
        author.id
    FROM
        temp1 LEFT JOIN author ON temp1.name = author.name
);
​
-- Join pubid using the pubkey
CREATE TABLE temp3 AS(
    SELECT
        temp2.id,
        publication.pubid
    FROM
        temp2 LEFT JOIN publication ON temp2.pubkey = publication.pubkey
);
​  
ALTER TABLE authored DROP CONSTRAINT authored_author_fk;
ALTER TABLE authored DROP CONSTRAINT authored_publication_fk;
INSERT INTO authored (SELECT id, pubid FROM temp3);
ALTER TABLE authored ADD CONSTRAINT authored_author_fk FOREIGN KEY (id) REFERENCES author (id);
ALTER TABLE authored ADD CONSTRAINT authored_publication_fk FOREIGN KEY (pubid) REFERENCES publication (pubid);
​
DROP TABLE IF EXISTS temp1, temp2, temp3 CASCADE;