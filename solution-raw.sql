
-- 2.4.1
SELECT p publication_type, COUNT(*)
FROM pub
GROUP BY publication_type;

/* 
	publication_type |  count  
	------------------+---------
	article          | 2671164
	book             |   18998
	incollection     |   67371
	inproceedings    | 2894088
	mastersthesis    |      12
	phdthesis        |   81783
	proceedings      |   48477
	www              | 2841998
	(8 rows)
*/

-- 2.4.2
create table publication_attributes as (select distinct pub.p pub_type, field.p attr from pub join field on field.k=pub.k); 
 
select distinct attr from publication_attributes except (
	select distinct attr from(
		select pub_type, attr from 
			(select distinct attr from publication_attributes) as temp_table_one cross join (select distinct pub.p pub_type from pub) as temp_table_two
		except 
			select pub_type, attr from publication_attributes
		) as temp_table_three
	);

drop table if exists publication_attributes cascade

/*
	attr  
	--------
	year
	title
	ee
	note
	author
	(5 rows)
*/

-- 2.4.3
create index pubkey_p on pub(k);
create index pubkey_f on field(k);

