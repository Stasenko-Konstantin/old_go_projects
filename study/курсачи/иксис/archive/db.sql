.open db.db

drop table if exists users;
drop table if exists games;

create table users
(
    name     text    not null primary key,
    is_admin integer not null,
    password text    not null
);

create table games
(
    id integer not null primary key,
    genre text not null
);

insert into users
values ("root", 1, "1111");
insert into users
values ("Говард Лавкрафт", 0, "нъярлатхотеп");
insert into users
values ("Амброз Бирс", 0, "12345");

insert into games
values (1, "rpg");
insert into games
values (2, "beat em up");
insert into games
values (3, "arcade");
insert into games
values (4, "arcade");
insert into games
values (5, "beat em up");
insert into games
values (6, "beat em up");
insert into games
values (7, "beat em up");
insert into games
values (8, "platform");
insert into games
values (9, "platform");
insert into games
values (10, "platform");
insert into games
values (11, "run and gun");
insert into games
values (12, "run and gun");
insert into games
values (13, "platform");
insert into games
values (14, "platform");
insert into games
values (15, "platform");
insert into games
values (16, "platform");
insert into games
values (17, "platform");
insert into games
values (18, "platform");