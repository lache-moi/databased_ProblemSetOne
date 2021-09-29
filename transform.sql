/* AUTHOR */
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
