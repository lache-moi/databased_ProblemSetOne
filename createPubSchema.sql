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
   month int,
   volume text,
   number int,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table book (
   pubid int,
   pubkey text,
   title text,
   year int,
   publisher text,
   isbn int,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table incollection (
   pubid int,
   pubkey text,
   title text,
   year int,
   booktitle text,
   publisher text,
   isbn int,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table inproceedings (
   pubid int,
   pubkey text,
   title text,
   year int,
   booktitle text,
   editor text,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);

create table authored (
   id int,
   pubkey text,
   title text,
   year int,
   pubid int,
   FOREIGN KEY (id) REFERENCES author (id),
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
