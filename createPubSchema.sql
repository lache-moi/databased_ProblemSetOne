drop table if exists author, publication, article, book, incollection, inproceedings, authored cascade;

create table author (
   id int,
   name text,
   homepage text,
   CONSTRAINT author_pk PRIMARY KEY (id)
);
 
create table publication (
   pubid int,
   pubkey text,
   title text,
   year int,
   type text,
   CONSTRAINT publication_pk PRIMARY KEY (pubid),
   CONSTRAINT publication_ak UNIQUE (pubkey)
);
 
create table article (
   pubid int,
   pubkey text,
   title text,
   year int,
   journal text,
   month text,
   volume text,
   number text,
   CONSTRAINT article_pk PRIMARY KEY (pubid),
   CONSTRAINT article_ak UNIQUE (pubkey),
   CONSTRAINT article_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table book (
   pubid int,
   pubkey text,
   title text,
   year int,
   publisher text,
   isbn text,
   CONSTRAINT book_pk PRIMARY KEY (pubid),
   CONSTRAINT book_ak UNIQUE (pubkey),
   CONSTRAINT book_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table incollection (
   pubid int,
   pubkey text,
   title text,
   year int,
   booktitle text,
   publisher text,
   isbn text,
   CONSTRAINT incollection_pk PRIMARY KEY (pubid),
   CONSTRAINT incollection_ak UNIQUE (pubkey),
   CONSTRAINT incollection_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table inproceedings (
   pubid int,
   pubkey text,
   title text,
   year int,
   booktitle text,
   editor text,
   CONSTRAINT inproceedings_pk PRIMARY KEY (pubid),
   CONSTRAINT inproceedings_ak UNIQUE (pubkey),
   CONSTRAINT inproceedings_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);

create table authored (
   id int,
   pubid int,
   CONSTRAINT authored_author_fk FOREIGN KEY (id) REFERENCES author (id),
   CONSTRAINT authored_publication_fk FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
