create table author (
   id int not null,
   name text not null,
   homepage text not null,
   CONSTRAINT author_pk PRIMARY KEY (id)
);
 
create table publication (
   pubid int not null,
   pubkey text not null,
   title text not null,
   year int not null,
   type text not null,
   CONSTRAINT publication_pk PRIMARY KEY (pubid),
   CONSTRAINT publication_ak UNIQUE (pubkey)
);
 
create table article (
   pubid int not null,
   journal text not null,
   month int not null,
   volume text not null,
   number int not null,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table book (
   pubid int not null,
   publisher text not null,
   isbn int not null,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table incollection (
   pubid int not null,
   booktitle text not null,
   publisher text not null,
   isbn int not null,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
 
create table inproceedings (
   pubid int not null,
   booktitle text not null,
   editor text not null,
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);

create table authored (
   id int not null,
   pubid int not null,
   FOREIGN KEY (id) REFERENCES author (id),
   FOREIGN KEY (pubid) REFERENCES publication (pubid)
);
