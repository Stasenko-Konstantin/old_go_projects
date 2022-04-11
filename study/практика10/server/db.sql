.open db.db
.headers on

drop table clients;
drop table librarians;
drop table givings;
drop table cassettes;
drop table films;

create table clients
(
    id        integer not null primary key,
    sfm       text    not null,
    residence text    not null
);

create table librarians
(
    id  integer not null primary key,
    sfm text    not null
);

create table films
(
    name     text    not null,
    year     text    not null,
    director text    not null,
    genre    text    not null,
    timeline integer not null,
    studio   text    not null,

    primary key (name, year)
);

create table cassettes
(
    id    integer not null primary key,
    price float   not null,
    film  text    not null,
    year  integer not null,

    foreign key (film, year) references films (name, year)
);

create table givings
(
    id       integer not null primary key,
    client   integer not null,
    cassette integer not null,
    issued   integer not null,

    foreign key (client) references clients (id),
    foreign key (cassette) references cassettes (id),
    foreign key (issued) references librarians (id)
);

insert into clients(id, sfm, residence)
values (1, "Тимофеев Алексей Васильевич", "ул. Напрудная 2-я, дом 76, квартира 266");
insert into clients(id, sfm, residence)
values (2, "Дидиченко Лилия Антоновна", "ул. Дуси Ковальчук, дом 131, квартира 161");
insert into clients(id, sfm, residence)
values (3, "Львов Фотий Васильевич", "ул. Черкасова, дом 193, квартира 996");
insert into clients(id, sfm, residence)
values (4, "Махов Аникита Вадимович", "ул. Бабаевская, дом 188, квартира 520");
insert into clients(id, sfm, residence)
values (5, "Сульженко Горислава Владиславовна", "ул. Мира 2-й пер, дом 196, квартира 444");
insert into clients(id, sfm, residence)
values (6, "Снежная Яна Геннадиевна", "ул. Демонстрационный проезд, дом 60, квартира 545");
insert into clients(id, sfm, residence)
values (7, "Романова Рада Платоновна", "ул. Кетчерская, дом 8, квартира 841");
insert into clients(id, sfm, residence)
values (8, "Прохорова Нинель Игоревна", "ул. Амурский 3-й пер, дом 80, квартира 215");
insert into clients(id, sfm, residence)
values (9, "Шершова Дина Михайловна", "ул. Чигорина, дом 75, квартира 828");
insert into clients(id, sfm, residence)
values (10, "Чудин Марк Иванович", "ул. Новоухтомское ш, дом 156, квартира 88");
insert into clients(id, sfm, residence)
values (11, "Шершов Кирилл Геннадиевич", "ул. Богайчука, дом 34, квартира 679");
insert into clients(id, sfm, residence)
values (12, "Пименова Викторина Сергеевна", "ул. Поперечная 3-я (Ново-Ковалево), дом 40, квартира 379");
insert into clients(id, sfm, residence)
values (13, "Быкова Любомила Валентиновна", "ул. Семеновская 2-я (Приморский), дом 102, квартира 24");
insert into clients(id, sfm, residence)
values (14, "Кожевников Юлий Семенович", "ул. Даля, дом 30, квартира 935");
insert into clients(id, sfm, residence)
values (15, "Максимчук Мира Григорьевна", "ул. Жерновская 4-я, дом 125, квартира 680");
insert into clients(id, sfm, residence)
values (16, "Редкий Эрнест Макарович", "Ермилов Доброслав Григорьевич");
insert into clients(id, sfm, residence)
values (17, "Царев Радован Русланович", "ул. Ямского Поля 1-я, дом 104, квартира 200");
insert into clients(id, sfm, residence)
values (18, "Журавель Марианна Ивановна", "ул. Сивашский 1-й пер, дом 70, квартира 989");
insert into clients(id, sfm, residence)
values (19, "Швец Катерина Ильинична", "ул. Неопалимовский 1-й пер, дом 45, квартира 71");
insert into clients(id, sfm, residence)
values (20, "Островская Марианна Иосифовна", "ул. Предпортовый 2-й проезд, дом 53, квартира 656");
insert into clients(id, sfm, residence)
values (21, "Алтырева Ганна Владиславовна", "ул. Радиальная 3-я, дом 80, квартира 756");
insert into clients(id, sfm, residence)
values (22, "Чапко Эрика Владимировна", "ул. Курляндская, дом 10, квартира 493");
insert into clients(id, sfm, residence)
values (23, "Сморчкова Аделаида Григорьевна", "ул. Российский пер, дом 91, квартира 810");
insert into clients(id, sfm, residence)
values (24, "Вострикова Ирина Геннадиевна", "ул. Академика Сахарова пр-кт, дом 73, квартира 693");
insert into clients(id, sfm, residence)
values (25, "Кондратьев Дементий Николаевич", "ул. Канонерский остров, дом 69, квартира 568");
insert into clients(id, sfm, residence)
values (26, "Валинин Фадей Эдуардович", "ул. Алексеевская 2-я, дом 39, квартира 672");
insert into clients(id, sfm, residence)
values (27, "Фомин Ефрем Денисович", "ул. Реки Большой Невки наб, дом 30, квартира 877");
insert into clients(id, sfm, residence)
values (28, "Пенкин Климент Иванович", "ул. Реки Каменки наб, дом 143, квартира 570");
insert into clients(id, sfm, residence)
values (29, "Аверина Ольга Николаевна", "ул. Павла Андреева, дом 11, квартира 643");
insert into clients(id, sfm, residence)
values (30, "Куколевский Болеслав Константинович",
        "ул. Центральный Хорошевского Серебряного Бор проезд, дом 180, квартира 16");

insert into librarians(id, sfm)
values (1, "Калинина Агата Васильевна");
insert into librarians(id, sfm)
values (2, "Пономарев Михаил Максимович");
insert into librarians(id, sfm)
values (3, "Терентьев Ярослав Ильич");
insert into librarians(id, sfm)
values (4, "Воронцова Ульяна Тиграновна");
insert into librarians(id, sfm)
values (5, "Павлов Ярослав Егорович");
insert into librarians(id, sfm)
values (6, "Федотова Аиша Максимовна");
insert into librarians(id, sfm)
values (7, "Артамонова Александра Максимовна");
insert into librarians(id, sfm)
values (8, "Панкратова София Львовна");
insert into librarians(id, sfm)
values (9, "Антонова Кристина Львовна");
insert into librarians(id, sfm)
values (10, "Соловьев Артур Михайлович");

insert into films(name, year, director, genre, timeline, studio)
values ("Маяк", 2019, "Роберт Эггерс", "ужасы", 109, "А24");
insert into films(name, year, director, genre, timeline, studio)
values ("Драйв", 2011, "Николас Виндинг Рефн", "криминал", 100, "Sierra Affinity");
insert into films(name, year, director, genre, timeline, studio)
values ("Ведьма", 2015, "Роберт Эггерс", "ужасы", 92, "А24");
insert into films(name, year, director, genre, timeline, studio)
values ("Неоновый демон", 2016, "Николас Виндинг Рефн", "драма", 117, "Gaumont");
insert into films(name, year, director, genre, timeline, studio)
values ("Сталкер", 1979, "Андрей Тарковский", "фантастика", 163, "Мосфильм");
insert into films(name, year, director, genre, timeline, studio)
values ("Солярис", 1972, "Андрей Тарковский", "фантастика", 169, "Мосфильм");
insert into films(name, year, director, genre, timeline, studio)
values ("Голова-ластик", 1977, "Дэвид Линч", "ужасы", 90, "Absurda");
insert into films(name, year, director, genre, timeline, studio)
values ("Внутренняя империя", 2006, "Дэвид Линч", "фэнтези", 180, "Canal");
insert into films(name, year, director, genre, timeline, studio)
values ("Телохранитель", 1961, "Акира Куросава", "боевик", 110, "Janus Films");
insert into films(name, year, director, genre, timeline, studio)
values ("Яйцо ангела", 1985, "Мамору Осии", "фантастика", 71, "DEEN");

insert into cassettes (id, price, film, year)
values (1, 100, "Маяк", 2019);
insert into cassettes (id, price, film, year)
values (2, 100, "Маяк", 2019);
insert into cassettes (id, price, film, year)
values (3, 100, "Маяк", 2019);
insert into cassettes (id, price, film, year)
values (4, 100, "Маяк", 2019);
insert into cassettes (id, price, film, year)
values (5, 100, "Драйв", 2011);
insert into cassettes (id, price, film, year)
values (6, 100, "Драйв", 2011);
insert into cassettes (id, price, film, year)
values (7, 100, "Драйв", 2011);
insert into cassettes (id, price, film, year)
values (8, 100, "Драйв", 2011);
insert into cassettes (id, price, film, year)
values (9, 100, "Драйв", 2011);
insert into cassettes (id, price, film, year)
values (10, 150, "Ведьма", 2015);
insert into cassettes (id, price, film, year)
values (11, 150, "Ведьма", 2015);
insert into cassettes (id, price, film, year)
values (12, 150, "Ведьма", 2015);
insert into cassettes (id, price, film, year)
values (13, 150, "Неоновый демон", 2016);
insert into cassettes (id, price, film, year)
values (14, 150, "Неоновый демон", 2016);
insert into cassettes (id, price, film, year)
values (15, 150, "Неоновый демон", 2016);
insert into cassettes (id, price, film, year)
values (16, 150, "Сталкер", 1979);
insert into cassettes (id, price, film, year)
values (17, 150, "Сталкер", 1979);
insert into cassettes (id, price, film, year)
values (18, 150, "Сталкер", 1979);
insert into cassettes (id, price, film, year)
values (19, 150, "Сталкер", 1979);
insert into cassettes (id, price, film, year)
values (20, 150, "Сталкер", 1979);
insert into cassettes (id, price, film, year)
values (21, 200, "Солярис", 1972);
insert into cassettes (id, price, film, year)
values (22, 200, "Солярис", 1972);
insert into cassettes (id, price, film, year)
values (23, 200, "Солярис", 1972);
insert into cassettes (id, price, film, year)
values (24, 200, "Солярис", 1972);
insert into cassettes (id, price, film, year)
values (25, 200, "Голова-ластик", 1977);
insert into cassettes (id, price, film, year)
values (26, 200, "Голова-ластик", 1977);
insert into cassettes (id, price, film, year)
values (27, 200, "Голова-ластик", 1977);
insert into cassettes (id, price, film, year)
values (28, 200, "Голова-ластик", 1977);
insert into cassettes (id, price, film, year)
values (29, 200, "Внутренняя империя", 2006);
insert into cassettes (id, price, film, year)
values (30, 200, "Внутренняя империя", 2006);
insert into cassettes (id, price, film, year)
values (31, 250, "Внутренняя империя", 2006);
insert into cassettes (id, price, film, year)
values (32, 250, "Внутренняя империя", 2006);
insert into cassettes (id, price, film, year)
values (33, 250, "Телохранитель", 1961);
insert into cassettes (id, price, film, year)
values (34, 250, "Телохранитель", 1961);
insert into cassettes (id, price, film, year)
values (35, 250, "Телохранитель", 1961);
insert into cassettes (id, price, film, year)
values (36, 250, "Телохранитель", 1961);
insert into cassettes (id, price, film, year)
values (37, 250, "Яйцо ангела", 1985);
insert into cassettes (id, price, film, year)
values (38, 250, "Яйцо ангела", 1985);
insert into cassettes (id, price, film, year)
values (39, 250, "Яйцо ангела", 1985);
insert into cassettes (id, price, film, year)
values (40, 250, "Яйцо ангела", 1985);

insert into givings(id, client, cassette, issued)
values (1, 1, 1, 1);
insert into givings(id, client, cassette, issued)
values (2, 2, 2, 1);
insert into givings(id, client, cassette, issued)
values (3, 3, 5, 1);
insert into givings(id, client, cassette, issued)
values (4, 4, 7, 1);
insert into givings(id, client, cassette, issued)
values (5, 5, 10, 2);
insert into givings(id, client, cassette, issued)
values (6, 6, 11, 2);
insert into givings(id, client, cassette, issued)
values (7, 7, 12, 2);
insert into givings(id, client, cassette, issued)
values (8, 8, 15, 2);
insert into givings(id, client, cassette, issued)
values (9, 9, 16, 3);
insert into givings(id, client, cassette, issued)
values (10, 10, 19, 3);
insert into givings(id, client, cassette, issued)
values (11, 11, 21, 3);
insert into givings(id, client, cassette, issued)
values (12, 12, 23, 3);
insert into givings(id, client, cassette, issued)
values (13, 13, 25, 4);
insert into givings(id, client, cassette, issued)
values (14, 14, 26, 4);
insert into givings(id, client, cassette, issued)
values (15, 15, 27, 4);
insert into givings(id, client, cassette, issued)
values (16, 16, 29, 4);
insert into givings(id, client, cassette, issued)
values (17, 17, 30, 5);
insert into givings(id, client, cassette, issued)
values (18, 18, 32, 5);
insert into givings(id, client, cassette, issued)
values (19, 19, 33, 10);
insert into givings(id, client, cassette, issued)
values (20, 10, 35, 5);
insert into givings(id, client, cassette, issued)
values (21, 21, 37, 6);
insert into givings(id, client, cassette, issued)
values (22, 22, 38, 6);
insert into givings(id, client, cassette, issued)
values (23, 23, 39, 6);
insert into givings(id, client, cassette, issued)
values (24, 24, 13, 6);
insert into givings(id, client, cassette, issued)
values (25, 25, 14, 7);
insert into givings(id, client, cassette, issued)
values (26, 26, 8, 9);
insert into givings(id, client, cassette, issued)
values (27, 27, 9, 7);
insert into givings(id, client, cassette, issued)
values (28, 28, 24, 7);
insert into givings(id, client, cassette, issued)
values (29, 29, 28, 8);
insert into givings(id, client, cassette, issued)
values (30, 30, 18, 8);

-- запрос фильмов по цене
select cs.id, f.name, f.year, f.director, cs.price
from cassettes as cs
         join films as f
              on cs.film = f.name and cs.year = f.year
where cs.price > N;

-- запрос фильмов по хронометражу
select cs.price, f.name, f.year, f.director, f.genre
from films as f
         join cassettes as cs
              on f.name = cs.film and f.year = cs.year
where f.timeline > N;

-- запрос фильмов по жанрам
select cs.price, f.name, f.year, f.director, f.genre
from films as f
         join cassettes as cs
              on f.name = cs.film and f.year = cs.year
where f.genre == N;

-- запрос фильмов по годам
select cs.price, f.name, f.year, f.director, f.genre
from films as f
         join cassettes as cs
              on f.name = cs.film and f.year = cs.year
where f.year > N;

-- запрос фильмов по режиссерам
select cs.price, f.name, f.year, f.director, f.genre
from films as f
         join cassettes as cs
              on f.name = cs.film and f.year = cs.year
where f.director == N;

-- запрос невыданных кассет
select cs.id, cs.price, f.name, f.year, f.director
from cassettes as cs
         join films as f
              on cs.film = f.name and cs.year = f.year
where cs.id not in (select g.cassette from givings as g);

-- запрос выданных кассет
select cs.id, cs.price, cs.film, cs.year, c.sfm
from cassettes as cs
         join clients as c
         join givings as g
              on g.client = c.id and g.cassette = cs.id;

-- запрос кассет по библиотекарям
select l.sfm, cs.price, c.sfm, cs.film, cs.year
from librarians as l
         join givings as g
         join cassettes as cs
         join clients as c
              on l.id = g.issued and c.id = g.client and g.cassette = cs.id
where l.id == N;