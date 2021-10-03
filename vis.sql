-----------
/* 4.2.1 */
-----------
CREATE TABLE temp1 as (
	SELECT DISTINCT a.id aid, b.id bid
	FROM authored a, authored b 
	WHERE a.pubid=b.pubid 
);

CREATE TABLE temp2 as (
	SELECT aid, COUNT(*)-1 cnt
	FROM temp1
	GROUP BY aid
);

CREATE TABLE collab_histo as (
    SELECT cnt collaborators, COUNT(*) tally
    FROM temp2
    GROUP BY collaborators
);

\copy collab_histo to 'collab_tally.csv' csv header;
DROP TABLE IF EXISTS temp1, temp2, collab_histo CASCADE;

-----------
/* 4.2.1 */
-----------
CREATE TABLE pub_tally as (
    SELECT id, COUNT(*) as cnt 
    FROM authored
    GROUP BY id 
);
\copy pub_tally to 'pub_tally.csv' csv header;
DROP TABLE IF EXISTS pub_tally
