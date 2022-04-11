.open db.db
.headers on
.mode line

drop table doctors;
drop table patients;
drop table talons;

create table patients(
    id integer not null primary key,
    insurance_company text not null,
    sfm text not null,
    residence text not null,
    birth date not null,
    sex boolean not null,
    district integer not null,

    foreign key(district) references doctors(district)
);

create table doctors(
    sfm text not null primary key,
    department text not null,
    specialization text not null,
    district integer unique
);

create table talons(
    id integer not null primary key,
    reception date not null,
    doctor text not null,
    patient integer not null,

    foreign key(patient) references patients(id),
    foreign key(doctor) references doctors(sfm)
);

insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(1, "Astra-Metall", "Андреев Лев Тимофеевич",
       "ул. Моторная, дом 4, квартира 651", "1974-01-08", 1, 1);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(2, "Asko-Strakhovaniye", "Голикова Николь Серафимовна",
       "ул. Римского-Корсакова 1-й пер, дом 179, квартира 961", "1987-06-06", 0, 1);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(3, "Asko-Strakhovaniye", "Леонов Павел Владиславович",
       "ул. Осипенко, дом 89, квартира 769", "1991-11-22", 1, 2);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(4, "Astra-Metall", "Рябов Максим Даниилович",
       "ул. Курчатова, дом 173, квартира 324", "1989-04-04", 1, 3);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(5, "Rosno", "Худякова Алиса Тимофеевна",
       "ул. Звонарский пер, дом 188, квартира 205", "1976-09-08", 0, 3);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(6, "Asko-Strakhovaniye", "Назаров Игорь Степанович",
       "ул. Инессы Арманд, дом 59, квартира 352", "1984-10-24", 1, 3);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(7, "Astra-Metall", "Гусева Яна Ивановна",
       "ул. Строительный проезд, дом 168, квартира 455", "1996-12-27", 0, 4);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(8, "Astra-Metall", "Калашников Матвей Кириллович",
       "ул. Николая Химушина, дом 190, квартира 214", "1991-10-28", 1, 5);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(9, "Rosno", "Горелова Полина Алексеевна",
       "ул. Кавказский пер, дом 119, квартира 130", "1973-10-01", 0, 5);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(10, "Rosno", "Куликова Варвара Артемьевна",
       "ул. Красной Сосны 13-я линия, дом 93, квартира 405", "1987-04-13", 0, 6);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(11, "Astra-Metall", "Ершова Таисия Ярославовна",
       "ул. Манежная, дом 191, квартира 174", "1973-11-04", 0, 7);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(12, "Rosno", "Полякова Кристина Сергеевна",
       "ул. Пойма реки Каменки, дом 146, квартира 148", "1975-03-20", 0, 7);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(13, "Asko-Strakhovaniye", "Воробьева Элина Ильинична",
       "ул. Моссельмаш ст, дом 18, квартира 211", "1975-04-04", 0, 7);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(14, "Rosno", "Никитин Святослав Павлович",
       "ул. Гамбургская пл, дом 121, квартира 146", "1985-06-25", 1, 8);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(15, "Astra-Metall", "Коновалова Мария Ивановна",
       "ул. Кржижановского, дом 183, квартира 957", "1999-10-11", 0, 8);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(16, "Rosno", "Захаров Матвей Даниилович",
       "ул. Ростовский 2-й пер, дом 125, квартира 791", "", 1, 9);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(17, "Astra-Metall", "Смирнова Арина Яковлевна",
       "ул. Взлетная, дом 65, квартира 406", "1997-10-01", 0, 10);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(18, "Asko-Strakhovaniye", "Кольцов Алексей Леонович",
       "ул. Нежинская, дом 176, квартира 687", "1971-10-11", 1, 10);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(19, "Astra-Metall", "Сергеева Дарья Максимовна",
       "ул. Нежинская, дом 10, квартира 8", "", 0, 10);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(20, "Astra-Metall", "Софронов Матвей Артёмович",
       "ул. Широкий проезд, дом 103, квартира 375", "1973-09-17", 1, 10);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(21, "Rosno", "Хомякова Александра Платоновна",
       "ул. Манежная, дом 191, квартира 174", "1980-12-01", 0, 7);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(22, "Rosno", "Майорова Кристина Артёмовна",
       "ул. Зеленый пр-кт, дом 95, квартира 848", "1972-12-06", 0, 10);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(23, "Astra-Metall", "Богданов Святослав Владимирович",
       "ул. Новоспасский пер, дом 16, квартира 44", "1972-02-08", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(24, "Rosno", "Муравьев Даниил Адамович",
       "ул. Неверовского, дом 118, квартира 952", "1999-05-08", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(25, "Asko-Strakhovaniye", "Болдырев Леонид Борисович",
       "ул. Михайловский Верхн. 4-й проезд, дом 194, квартира 616", "1984-06-04", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(26, "Asko-Strakhovaniye", "Васильев Георгий Андреевич",
       "ул. Зенитная, дом 32, квартира 24", "1971-04-22", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(27, "Astra-Metall", "Никонов Роман Артёмович",
       "ул. Перова Поля 3-й проезд, дом 81, квартира 732", "1977-07-18", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(28, "Rosno", "Морозов Тимофей Фёдорович",
       "ул. Перова Поля 3-й проезд, дом 1, квартира 56", "2000-02-02", 1, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(29, "Asko-Strakhovaniye", "Покровская Ангелина Дмитриевна",
       "ул. Буденного пр-кт, дом 48, квартира 812", "1975-09-26", 0, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(30, "Rosno", "Попова Зоя Сергеевна",
       "ул. Зенитная, дом 32, квартира 24", "1971-07-08", 0, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(31, "Astra-Metall", "Зайцева София Александровна",
       "ул. Новокуркинское ш, дом 45, квартира 369", "1992-08-10", 0, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(32, "Rosno", "Молчанова Маргарита Егоровна",
       "ул. Каштановая 1-я, дом 182, квартира 940", "1971-03-08", 0, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(33, "Astra-Metall", "Рыбаков Егор Павлович",
       "ул. Ганнушкина наб, дом 124, квартира 783", "1999-10-28", 1, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(34, "Asko-Strakhovaniye", "Кузнецов Владислав Миронович",
       "ул. Почтовая Б., дом 102, квартира 242", "1985-02-05", 1, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(35, "Rosno", "Анисимова Яна Степановна",
       "ул. Гамбургская пл, дом 121, квартира 146", "1973-11-07", 0, 8);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(36, "Astra-Metall", "Романов Михаил Михайлович",
       "ул. Туннельная, дом 7, квартира 100", "1984-07-23", 1, 13);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(37, "Rosno", "Савин Роман Альбертович",
       "ул. Алымова, дом 29, квартира 957", "1999-07-24", 1, 13);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(38, "Asko-Strakhovaniye", "Носов Никита Михайлович",
       "ул. Пушкарсркая Малая, дом 16, квартира 308", "1991-05-20", 1, 13);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(39, "Rosno", "Власов Максим Иванович",
       "ул. Ковенский пер, дом 25, квартира 339", "1972-03-19", 1, 13);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(40, "Asko-Strakhovaniye", "Гаврилова Дарья Григорьевна",
       "ул. Алымова, дом 29, квартира 957", "1983-10-25", 0, 13);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(41, "Asko-Strakhovaniye", "Смирнов Константин Семёнович",
       "ул. Каштановая 1-я, дом 182, квартира 940", "1993-08-09", 1, 12);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(42, "Astra-Metall", "Зуева Тамара Кирилловна",
       "ул. Борьбы пл, дом 75, квартира 705", "1986-04-17", 0, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(43, "Rosno", "Семенов Даниил Иванович",
       "ул. Борьбы пл, дом 75, квартира 704", "1986-04-17", 1, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(44, "Astra-Metall", "Кузьмина Александра Альбертовна",
       "ул. Перуновский пер, дом 177, квартира 697", "1997-10-13", 0, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(45, "Rosno", "Макаров Владислав Робертович",
       "ул. Волжский Бьвар 95-й кв-л, дом 77, квартира 770", "1998-08-21", 1, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(46, "Asko-Strakhovaniye", "Смирнова Александра Данииловна",
       "ул. Прожекторная, дом 187, квартира 730", "1977-03-03", 0, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(47, "Astra-Metall", "Панова Стефания Руслановна",
       "ул. Эрнста Тельмана пл, дом 159, квартира 8", "1974-10-15", 0, 14);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(48, "Asko-Strakhovaniye", "Сидорова Алиса Романовна",
       "ул. Рубиновая, дом 146, квартира 651", "1973-12-13", 0, 15);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(49, "Rosno", "Еремин Илья Кириллович",
       "ул. Полянка Б., дом 56, квартира 288", "1994-09-07", 1, 15);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(50, "Rosno", "Ситников Алексей Ярославович",
       "ул. Шелепихинское ш, дом 23, квартира 570", "1972-07-16", 1, 15);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(51, "Astra-Metall", "Молчанов Руслан Алексеевич",
       "ул. Ростовский 2-й пер, дом 125, квартира 791", "2001-04-11", 1, 9);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(52, "Asko-Strakhovaniye", "Данилова Василиса Кирилловна",
       "ул. Дворцовая Правая аллея, дом 102, квартира 60", "2001-04-11", 0, 15);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(53, "Rosno", "Александрова Анастасия Дмитриевна",
       "ул. Амурская, дом 88, квартира 182", "1989-09-06", 0, 15);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(54, "Astra-Metall", "Фролов Владимир Александрович",
       "ул. Троицкая пл, дом 178, квартира 888", "1998-11-05", 1, 16);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(55, "Astra-Metall", "Гаврилова Аврора Романовна",
       "ул. 9-я Линия линия, дом 4, квартира 666", "1987-02-21", 0, 16);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(56, "Astra-Metall", "Борисов Алексей Николаевич",
       "ул. Днепропетровская (Фрунзенский), дом 108, квартира 1488", "1996-12-20", 1, 16);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(57, "Rosno", "Меркулова Вера Фёдоровна",
       "ул. Неверовского, дом 118, квартира 952", "1996-12-20", 0, 11);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(58, "Astra-Metall", "Фадеев Евгений Леонович",
       "ул. Космонавтов, дом 4, квартира 228", "1989-08-28", 1, 16);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(59, "Asko-Strakhovaniye", "Ершов Савелий Павлович",
       "ул. Манежная, дом 191, квартира 174", "1971-02-14", 1, 7);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(60, "Rosno", "Рыжов Александр Тихонович",
       "ул. Чагинская, дом 142, квартира 629", "1984-06-16", 1, 17);
insert into patients(id, insurance_company, sfm, residence, birth, sex, district)
values(61, "Astra-Metall", "Стасенко Константин Юрьевич",
       "ул. Черского проезд, дом 154, квартира 566", "2002-10-03", 1, 17);

insert into doctors(sfm, department, specialization, district)
values("Демидова Регина Максимовна", "терапевтическое", "врач-участковый", 1);
insert into doctors(sfm, department, specialization, district)
values("Андрианова Анна Львовна", "терапевтическое", "врач-участковый", 2);
insert into doctors(sfm, department, specialization, district)
values("Чистякова Элина Дмитриевна", "терапевтическое", "врач-участковый", 3);
insert into doctors(sfm, department, specialization, district)
values("Гуров Дмитрий Львович", "терапевтическое", "врач-участковый", 4);
insert into doctors(sfm, department, specialization, district)
values("Муравьев Кирилл Степанович", "терапевтическое", "врач-участковый", 5);
insert into doctors(sfm, department, specialization, district)
values("Сахаров Максим Арсенович", "терапевтическое", "врач-участковый", 6);
insert into doctors(sfm, department, specialization, district)
values("Попов Александр Александрович", "терапевтическое", "врач-участковый", 7);
insert into doctors(sfm, department, specialization, district)
values("Чернышева Софья Михайловна", "терапевтическое", "врач-участковый", 8);
insert into doctors(sfm, department, specialization, district)
values("Фомичева Ясмина Никитична", "терапевтическое", "врач-участковый", 9);
insert into doctors(sfm, department, specialization, district)
values("Дружинина Дарья Данииловна", "терапевтическое", "врач-участковый", 10);
insert into doctors(sfm, department, specialization, district)
values("Рыбакова Алёна Михайловна", "терапевтическое", "врач-участковый", 11);
insert into doctors(sfm, department, specialization, district)
values("Соколов Святослав Ильич", "терапевтическое", "врач-участковый", 12);
insert into doctors(sfm, department, specialization, district)
values("Мартынов Никита Захарович", "терапевтическое", "врач-участковый", 13);
insert into doctors(sfm, department, specialization, district)
values("Исаков Арсений Петрович", "терапевтическое", "врач-участковый", 14);
insert into doctors(sfm, department, specialization, district)
values("Данилова Василиса Кирилловна", "терапевтическое", "врач-участковый", 15);
insert into doctors(sfm, department, specialization, district)
values("Алексеева Майя Андреевна", "терапевтическое", "врач-участковый", 16);
insert into doctors(sfm, department, specialization, district)
values("Литвинова Милана Глебовна", "терапевтическое", "врач-участковый", 17);
insert into doctors(sfm, department, specialization, district)
values("Федорова Анна Демидовна", "терапевтическое", "дежурный врач", null);
insert into doctors(sfm, department, specialization, district)
values("Скворцова Есения Дмитриевна", "терапевтическое", "дежурный врач", null);
insert into doctors(sfm, department, specialization, district)
values("Позднякова Дарья Александровна", "хирургическое (гнойное)", "хирург-онколог", null);
insert into doctors(sfm, department, specialization, district)
values("Петровская Валерия Тимофеевна", "хирургическое (гнойное)", "хирург-проктолог", null);
insert into doctors(sfm, department, specialization, district)
values("Симонов Владимир Артёмович", "хирургическое (чистое)", "хирург общего профиля", null);
insert into doctors(sfm, department, specialization, district)
values("Игнатьева Сафия Дмитриевна", "хирургическое (чистое)", "хирург общего профиля", null);
insert into doctors(sfm, department, specialization, district)
values("Пономарев Лев Романович", "гинекологическое", "гинеколог", null);
insert into doctors(sfm, department, specialization, district)
values("Филиппова Арина Богдановна", "ортопедическое", "ортопед", null);
insert into doctors(sfm, department, specialization, district)
values("Волков Игорь Дмитриевич", "кардиологическое", "кардиолог", null);
insert into doctors(sfm, department, specialization, district)
values("Панов Артемий Егорович", "травматологическое", "травматолог", null);
insert into doctors(sfm, department, specialization, district)
values("Бочаров Даниил Святославович", "урологическое", "уролог", null);
insert into doctors(sfm, department, specialization, district)
values("Харитонова Александра Арсентьевна", "стоматологическое", "стоматолог", null);
insert into doctors(sfm, department, specialization, district)
values("Леонов Александр Тимурович", "офтальмологическое", "офтальмолог", null);
insert into doctors(sfm, department, specialization, district)
values("Иванова Александра Данииловна", "анастезиолого-реанимационное", "реаниматолог", null);

insert into talons(id, reception, doctor, patient)
values(1, "2021-10-02 14:55", "Демидова Регина Максимовна", "Андреев Лев Тимофеевич");
insert into talons(id, reception, doctor, patient)
values(2, "2021-10-04 10:20", "Филиппова Арина Богдановна", "Андреев Лев Тимофеевич");
insert into talons(id, reception, doctor, patient)
values(3, "2021-10-15 09:30", "Филиппова Арина Богдановна", "Андреев Лев Тимофеевич");
insert into talons(id, reception, doctor, patient)
values(4, "2021-10-17 13:45", "Демидова Регина Максимовна", "Андреев Лев Тимофеевич");
insert into talons(id, reception, doctor, patient)
values(5, "2021-10-02 10:15", "Демидова Регина Максимовна", "Голикова Николь Серафимовна");
insert into talons(id, reception, doctor, patient)
values(6, "2021-10-01 09:10", "Андрианова Анна Львовна", "Леонов Павел Владиславович");
insert into talons(id, reception, doctor, patient)
values(7, "2021-10-03 11:40", "Андрианова Анна Львовна", "Леонов Павел Владиславович");
insert into talons(id, reception, doctor, patient)
values(8, "2021-10-07 12:20", "Андрианова Анна Львовна", "Леонов Павел Владиславович");
insert into talons(id, reception, doctor, patient)
values(9, "2021-10-03 14:20", "Чистякова Элина Дмитриевна", "Рябов Максим Даниилович");
insert into talons(id, reception, doctor, patient)
values(10, "2021-10-04 12:10", "Петровская Валерия Тимофеевна", "Рябов Максим Даниилович");
insert into talons(id, reception, doctor, patient)
values(11, "2021-10-07 09:35", "Чистякова Элина Дмитриевна", "Рябов Максим Даниилович");
insert into talons(id, reception, doctor, patient)
values(12, "2021-10-11 11:39", "Петровская Валерия Тимофеевна", "Рябов Максим Даниилович");
insert into talons(id, reception, doctor, patient)
values(13, "2021-10-15 15:45", "Чистякова Элина Дмитриевна", "Рябов Максим Даниилович");
insert into talons(id, reception, doctor, patient)
values(14, "", "", "Худякова Алиса Тимофеевна");
insert into talons(id, reception, doctor, patient)
values(15, "", "", "Худякова Алиса Тимофеевна");
insert into talons(id, reception, doctor, patient)
values(16, "", "", "Назаров Игорь Степанович");
insert into talons(id, reception, doctor, patient)
values(17, "", "", "Назаров Игорь Степанович");
insert into talons(id, reception, doctor, patient)
values(18, "", "", "Назаров Игорь Степанович");
insert into talons(id, reception, doctor, patient)
values(19, "", "", "Гусева Яна Ивановна");
insert into talons(id, reception, doctor, patient)
values(20, "", "", "Гусева Яна Ивановна");
insert into talons(id, reception, doctor, patient)
values(21, "", "", "Гусева Яна Ивановна");
insert into talons(id, reception, doctor, patient)
values(22, "", "", "Гусева Яна Ивановна");
insert into talons(id, reception, doctor, patient)
values(23, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(24, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(25, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(26, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(27, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(28, "", "", "Калашников Матвей Кириллович");
insert into talons(id, reception, doctor, patient)
values(29, "", "", "Горелова Полина Алексеевна");
insert into talons(id, reception, doctor, patient)
values(30, "", "", "Горелова Полина Алексеевна");
insert into talons(id, reception, doctor, patient)
values(31, "", "", "Горелова Полина Алексеевна");
insert into talons(id, reception, doctor, patient)
values(32, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(33, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(34, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(35, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(36, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(37, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(38, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(39, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(40, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(41, "", "", "Куликова Варвара Артемьевна");
insert into talons(id, reception, doctor, patient)
values(42, "", "", "Ершова Таисия Ярославовна");
insert into talons(id, reception, doctor, patient)
values(43, "", "", "Ершова Таисия Ярославовна");
insert into talons(id, reception, doctor, patient)
values(44, "", "", "Полякова Кристина Сергеевна");
insert into talons(id, reception, doctor, patient)
values(45, "", "", "Воробьева Элина Ильинична");
insert into talons(id, reception, doctor, patient)
values(46, "", "", "Воробьева Элина Ильинична");
insert into talons(id, reception, doctor, patient)
values(47, "", "", "Воробьева Элина Ильинична");
insert into talons(id, reception, doctor, patient)
values(48, "", "", "Воробьева Элина Ильинична");
insert into talons(id, reception, doctor, patient)
values(49, "", "", "Никитин Святослав Павлович");
insert into talons(id, reception, doctor, patient)
values(50, "", "", "Никитин Святослав Павлович");
insert into talons(id, reception, doctor, patient)
values(51, "", "", "Никитин Святослав Павлович");
insert into talons(id, reception, doctor, patient)
values(52, "", "", "Никитин Святослав Павлович");
insert into talons(id, reception, doctor, patient)
values(53, "", "", "Никитин Святослав Павлович");
insert into talons(id, reception, doctor, patient)
values(54, "", "", "Коновалова Мария Ивановна");
insert into talons(id, reception, doctor, patient)
values(55, "", "", "Коновалова Мария Ивановна");
insert into talons(id, reception, doctor, patient)
values(56, "", "", "Коновалова Мария Ивановна");
insert into talons(id, reception, doctor, patient)
values(57, "", "", "Коновалова Мария Ивановна");
insert into talons(id, reception, doctor, patient)
values(58, "", "", "Захаров Матвей Даниилович");
insert into talons(id, reception, doctor, patient)
values(59, "", "", "Захаров Матвей Даниилович");
insert into talons(id, reception, doctor, patient)
values(60, "", "", "Захаров Матвей Даниилович");
insert into talons(id, reception, doctor, patient)
values(61, "", "", "Захаров Матвей Даниилович");
insert into talons(id, reception, doctor, patient)
values(62, "", "", "Смирнова Арина Яковлевна");
insert into talons(id, reception, doctor, patient)
values(63, "", "", "Смирнова Арина Яковлевна");
insert into talons(id, reception, doctor, patient)
values(64, "", "", "Смирнова Арина Яковлевна");
insert into talons(id, reception, doctor, patient)
values(65, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(66, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(67, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(68, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(69, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(70, "", "", "Кольцов Алексей Леонович");
insert into talons(id, reception, doctor, patient)
values(71, "", "", "Сергеева Дарья Максимовна");
insert into talons(id, reception, doctor, patient)
values(72, "", "", "Софронов Матвей Артёмович");
insert into talons(id, reception, doctor, patient)
values(73, "", "", "Софронов Матвей Артёмович");
insert into talons(id, reception, doctor, patient)
values(74, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(75, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(76, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(77, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(78, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(79, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(80, "", "", "Хомякова Александра Платоновна");
insert into talons(id, reception, doctor, patient)
values(81, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(82, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(83, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(84, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(85, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(86, "", "", "Майорова Кристина Артёмовна");
insert into talons(id, reception, doctor, patient)
values(87, "", "", "Богданов Святослав Владимирович");
insert into talons(id, reception, doctor, patient)
values(88, "", "", "Богданов Святослав Владимирович");
insert into talons(id, reception, doctor, patient)
values(89, "", "", "Богданов Святослав Владимирович");
insert into talons(id, reception, doctor, patient)
values(90, "", "", "Богданов Святослав Владимирович");
insert into talons(id, reception, doctor, patient)
values(91, "", "", "Богданов Святослав Владимирович");
insert into talons(id, reception, doctor, patient)
values(92, "", "", "Муравьев Даниил Адамович");
insert into talons(id, reception, doctor, patient)
values(93, "", "", "Муравьев Даниил Адамович");
insert into talons(id, reception, doctor, patient)
values(94, "", "", "Муравьев Даниил Адамович");
insert into talons(id, reception, doctor, patient)
values(95, "", "", "Муравьев Даниил Адамович");
insert into talons(id, reception, doctor, patient)
values(96, "", "", "Муравьев Даниил Адамович");
insert into talons(id, reception, doctor, patient)
values(97, "", "", "Болдырев Леонид Борисович");
insert into talons(id, reception, doctor, patient)
values(98, "", "", "Болдырев Леонид Борисович");
insert into talons(id, reception, doctor, patient)
values(99, "", "", "Болдырев Леонид Борисович");
insert into talons(id, reception, doctor, patient)
values(100, "", "", "Болдырев Леонид Борисович");
insert into talons(id, reception, doctor, patient)
values(101, "", "", "Васильев Георгий Андреевич");
insert into talons(id, reception, doctor, patient)
values(102, "", "", "Васильев Георгий Андреевич");
insert into talons(id, reception, doctor, patient)
values(103, "", "", "Васильев Георгий Андреевич");
insert into talons(id, reception, doctor, patient)
values(104, "", "", "Васильев Георгий Андреевич");
insert into talons(id, reception, doctor, patient)
values(105, "", "", "Никонов Роман Артёмович");
insert into talons(id, reception, doctor, patient)
values(106, "", "", "Никонов Роман Артёмович");
insert into talons(id, reception, doctor, patient)
values(107, "", "", "Никонов Роман Артёмович");
insert into talons(id, reception, doctor, patient)
values(108, "", "", "Морозов Тимофей Фёдорович");
insert into talons(id, reception, doctor, patient)
values(109, "", "", "Морозов Тимофей Фёдорович");
insert into talons(id, reception, doctor, patient)
values(110, "", "", "Морозов Тимофей Фёдорович");
insert into talons(id, reception, doctor, patient)
values(111, "", "", "Покровская Ангелина Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(112, "", "", "Покровская Ангелина Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(113, "", "", "Покровская Ангелина Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(114, "", "", "Покровская Ангелина Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(115, "", "", "Покровская Ангелина Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(116, "", "", "Попова Зоя Сергеевна");
insert into talons(id, reception, doctor, patient)
values(117, "", "", "Попова Зоя Сергеевна");
insert into talons(id, reception, doctor, patient)
values(118, "", "", "Попова Зоя Сергеевна");
insert into talons(id, reception, doctor, patient)
values(119, "", "", "Попова Зоя Сергеевна");
insert into talons(id, reception, doctor, patient)
values(120, "", "", "Зайцева София Александровна");
insert into talons(id, reception, doctor, patient)
values(121, "", "", "Зайцева София Александровна");
insert into talons(id, reception, doctor, patient)
values(122, "", "", "Зайцева София Александровна");
insert into talons(id, reception, doctor, patient)
values(123, "", "", "Зайцева София Александровна");
insert into talons(id, reception, doctor, patient)
values(124, "", "", "Молчанова Маргарита Егоровна");
insert into talons(id, reception, doctor, patient)
values(125, "", "", "Молчанова Маргарита Егоровна");
insert into talons(id, reception, doctor, patient)
values(126, "", "", "Молчанова Маргарита Егоровна");
insert into talons(id, reception, doctor, patient)
values(127, "", "", "Молчанова Маргарита Егоровна");
insert into talons(id, reception, doctor, patient)
values(128, "", "", "Рыбаков Егор Павлович");
insert into talons(id, reception, doctor, patient)
values(129, "", "", "Рыбаков Егор Павлович");
insert into talons(id, reception, doctor, patient)
values(130, "", "", "Рыбаков Егор Павлович");
insert into talons(id, reception, doctor, patient)
values(131, "", "", "Рыбаков Егор Павлович");
insert into talons(id, reception, doctor, patient)
values(132, "", "", "Кузнецов Владислав Миронович");
insert into talons(id, reception, doctor, patient)
values(133, "", "", "Кузнецов Владислав Миронович");
insert into talons(id, reception, doctor, patient)
values(134, "", "", "Кузнецов Владислав Миронович");
insert into talons(id, reception, doctor, patient)
values(135, "", "", "Кузнецов Владислав Миронович");
insert into talons(id, reception, doctor, patient)
values(136, "", "", "Анисимова Яна Степановна");
insert into talons(id, reception, doctor, patient)
values(137, "", "", "Анисимова Яна Степановна");
insert into talons(id, reception, doctor, patient)
values(138, "", "", "Анисимова Яна Степановна");
insert into talons(id, reception, doctor, patient)
values(139, "", "", "Анисимова Яна Степановна");
insert into talons(id, reception, doctor, patient)
values(140, "", "", "Романов Михаил Михайлович");
insert into talons(id, reception, doctor, patient)
values(141, "", "", "Романов Михаил Михайлович");
insert into talons(id, reception, doctor, patient)
values(142, "", "", "Романов Михаил Михайлович");
insert into talons(id, reception, doctor, patient)
values(143, "", "", "Романов Михаил Михайлович");
insert into talons(id, reception, doctor, patient)
values(144, "", "", "Савин Роман Альбертович");
insert into talons(id, reception, doctor, patient)
values(145, "", "", "Савин Роман Альбертович");
insert into talons(id, reception, doctor, patient)
values(146, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(147, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(148, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(149, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(150, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(151, "", "", "Носов Никита Михайлович");
insert into talons(id, reception, doctor, patient)
values(152, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(153, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(154, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(155, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(156, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(157, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(158, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(159, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(160, "", "", "Власов Максим Иванович");
insert into talons(id, reception, doctor, patient)
values(161, "", "", "Гаврилова Дарья Григорьевна");
insert into talons(id, reception, doctor, patient)
values(162, "", "", "Гаврилова Дарья Григорьевна");
insert into talons(id, reception, doctor, patient)
values(163, "", "", "Смирнов Константин Семёнович");
insert into talons(id, reception, doctor, patient)
values(164, "", "", "Смирнов Константин Семёнович");
insert into talons(id, reception, doctor, patient)
values(165, "", "", "Смирнов Константин Семёнович");
insert into talons(id, reception, doctor, patient)
values(166, "", "", "Зуева Тамара Кирилловна");
insert into talons(id, reception, doctor, patient)
values(167, "", "", "Зуева Тамара Кирилловна");
insert into talons(id, reception, doctor, patient)
values(168, "", "", "Семенов Даниил Иванович");
insert into talons(id, reception, doctor, patient)
values(169, "", "", "Семенов Даниил Иванович");
insert into talons(id, reception, doctor, patient)
values(170, "", "", "Семенов Даниил Иванович");
insert into talons(id, reception, doctor, patient)
values(171, "", "", "Семенов Даниил Иванович");
insert into talons(id, reception, doctor, patient)
values(172, "", "", "Кузьмина Александра Альбертовна");
insert into talons(id, reception, doctor, patient)
values(173, "", "", "Кузьмина Александра Альбертовна");
insert into talons(id, reception, doctor, patient)
values(174, "", "", "Кузьмина Александра Альбертовна");
insert into talons(id, reception, doctor, patient)
values(175, "", "", "Кузьмина Александра Альбертовна");
insert into talons(id, reception, doctor, patient)
values(176, "", "", "Макаров Владислав Робертович");
insert into talons(id, reception, doctor, patient)
values(177, "", "", "Макаров Владислав Робертович");
insert into talons(id, reception, doctor, patient)
values(178, "", "", "Макаров Владислав Робертович");
insert into talons(id, reception, doctor, patient)
values(179, "", "", "Макаров Владислав Робертович");
insert into talons(id, reception, doctor, patient)
values(180, "", "", "Смирнова Александра Данииловна");
insert into talons(id, reception, doctor, patient)
values(181, "", "", "Смирнова Александра Данииловна");
insert into talons(id, reception, doctor, patient)
values(182, "", "", "Смирнова Александра Данииловна");
insert into talons(id, reception, doctor, patient)
values(183, "", "", "Смирнова Александра Данииловна");
insert into talons(id, reception, doctor, patient)
values(184, "", "", "Панова Стефания Руслановна");
insert into talons(id, reception, doctor, patient)
values(185, "", "", "Панова Стефания Руслановна");
insert into talons(id, reception, doctor, patient)
values(186, "", "", "Панова Стефания Руслановна");
insert into talons(id, reception, doctor, patient)
values(187, "", "", "Панова Стефания Руслановна");
insert into talons(id, reception, doctor, patient)
values(188, "", "", "Сидорова Алиса Романовна");
insert into talons(id, reception, doctor, patient)
values(189, "", "", "Сидорова Алиса Романовна");
insert into talons(id, reception, doctor, patient)
values(190, "", "", "Сидорова Алиса Романовна");
insert into talons(id, reception, doctor, patient)
values(191, "", "", "Сидорова Алиса Романовна");
insert into talons(id, reception, doctor, patient)
values(192, "", "", "Еремин Илья Кириллович");
insert into talons(id, reception, doctor, patient)
values(193, "", "", "Еремин Илья Кириллович");
insert into talons(id, reception, doctor, patient)
values(194, "", "", "Еремин Илья Кириллович");
insert into talons(id, reception, doctor, patient)
values(195, "", "", "Еремин Илья Кириллович");
insert into talons(id, reception, doctor, patient)
values(196, "", "", "Ситников Алексей Ярославович");
insert into talons(id, reception, doctor, patient)
values(197, "", "", "Ситников Алексей Ярославович");
insert into talons(id, reception, doctor, patient)
values(198, "", "", "Ситников Алексей Ярославович");
insert into talons(id, reception, doctor, patient)
values(199, "", "", "Молчанов Руслан Алексеевич");
insert into talons(id, reception, doctor, patient)
values(200, "", "", "Молчанов Руслан Алексеевич");
insert into talons(id, reception, doctor, patient)
values(201, "", "", "Молчанов Руслан Алексеевич");
insert into talons(id, reception, doctor, patient)
values(202, "", "", "Молчанов Руслан Алексеевич");
insert into talons(id, reception, doctor, patient)
values(203, "", "", "Молчанов Руслан Алексеевич");
insert into talons(id, reception, doctor, patient)
values(204, "", "", "Данилова Василиса Кирилловна");
insert into talons(id, reception, doctor, patient)
values(205, "", "", "Данилова Василиса Кирилловна");
insert into talons(id, reception, doctor, patient)
values(206, "", "", "Данилова Василиса Кирилловна");
insert into talons(id, reception, doctor, patient)
values(207, "", "", "Данилова Василиса Кирилловна");
insert into talons(id, reception, doctor, patient)
values(208, "", "", "Александрова Анастасия Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(209, "", "", "Александрова Анастасия Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(210, "", "", "Александрова Анастасия Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(211, "", "", "Александрова Анастасия Дмитриевна");
insert into talons(id, reception, doctor, patient)
values(212, "", "", "Фролов Владимир Александрович");
insert into talons(id, reception, doctor, patient)
values(213, "", "", "Фролов Владимир Александрович");
insert into talons(id, reception, doctor, patient)
values(214, "", "", "Фролов Владимир Александрович");
insert into talons(id, reception, doctor, patient)
values(215, "", "", "Фролов Владимир Александрович");
insert into talons(id, reception, doctor, patient)
values(216, "", "", "Гаврилова Аврора Романовна");
insert into talons(id, reception, doctor, patient)
values(217, "", "", "Гаврилова Аврора Романовна");
insert into talons(id, reception, doctor, patient)
values(218, "", "", "Гаврилова Аврора Романовна");
insert into talons(id, reception, doctor, patient)
values(219, "", "", "Гаврилова Аврора Романовна");
insert into talons(id, reception, doctor, patient)
values(220, "", "", "Борисов Алексей Николаевич");
insert into talons(id, reception, doctor, patient)
values(221, "", "", "Борисов Алексей Николаевич");
insert into talons(id, reception, doctor, patient)
values(222, "", "", "Борисов Алексей Николаевич");
insert into talons(id, reception, doctor, patient)
values(223, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(224, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(225, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(226, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(227, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(228, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(229, "", "", "Меркулова Вера Фёдоровна");
insert into talons(id, reception, doctor, patient)
values(230, "", "", "Фадеев Евгений Леонович");
insert into talons(id, reception, doctor, patient)
values(231, "", "", "Фадеев Евгений Леонович");
insert into talons(id, reception, doctor, patient)
values(232, "", "", "Ершов Савелий Павлович");
insert into talons(id, reception, doctor, patient)
values(233, "", "", "Ершов Савелий Павлович");
insert into talons(id, reception, doctor, patient)
values(234, "", "", "Ершов Савелий Павлович");
insert into talons(id, reception, doctor, patient)
values(235, "", "", "Ершов Савелий Павлович");
insert into talons(id, reception, doctor, patient)
values(236, "", "", "Рыжов Александр Тихонович");
insert into talons(id, reception, doctor, patient)
values(237, "", "", "Рыжов Александр Тихонович");
insert into talons(id, reception, doctor, patient)
values(238, "", "", "Рыжов Александр Тихонович");
insert into talons(id, reception, doctor, patient)
values(239, "", "", "Стасенко Константин Юрьевич");
insert into talons(id, reception, doctor, patient)
values(240, "", "", "Стасенко Константин Юрьевич");
insert into talons(id, reception, doctor, patient)
values(241, "", "", "Стасенко Константин Юрьевич");
insert into talons(id, reception, doctor, patient)
values(242, "", "", "Стасенко Константин Юрьевич");
insert into talons(id, reception, doctor, patient)
values(243, "", "", "Стасенко Константин Юрьевич");

-- -- запрос пациентов по диагнозу
-- select P.sfm, P.diagnose, D.sfm
-- from patients as P join doctors as D
-- on D.id = P.doctor
-- where diagnose == "расстройство";
--
-- -- запрос пациентов по доктору
-- select P.sfm, P.diagnose, D.sfm
-- from patients as P join doctors as D
-- on P.doctor = D.id
-- where doctor == 10;
--
-- -- запрос имен врачей, экспертов и пациентов с их диагнозами в случае инфаркта или инсульта
-- select D.sfm, Ex.sfm, P.sfm, P.diagnose, E.incident
-- from expertise as E join doctors as D join patients as P join experts as Ex
-- where E.incident in ("инфаркт", "инсульт") and E.doctor == D.id and E.patient == P.id and E.expert == Ex.id;
--
-- -- запрос невыписанных пациентов с их диагнозами и имен их врачей
-- select D.sfm, P.sfm, P.diagnose, P.admission
-- from doctors as D join patients as P
-- on D.id = P.doctor
-- where P.discharge is NULL;
--
-- -- запрос пациентов положенных в больницу до начала третьего тысячелетия, имен их врачей и их диагнозы
-- select D.sfm, P.sfm, P.diagnose, P.admission, P.discharge
-- from doctors as D join patients as P
-- on D.id = P.doctor
-- where P.admission < "2000-01-01";
--
-- -- запрос докторов, пациентов, инцидентов и экспертов 2-го уровня
-- select D.sfm, P.sfm, P.diagnose, Ex.sfm, E.incident
-- from doctors as D join patients as P join experts as Ex join expertise as E
-- where Ex.level == 2 and D.id == E.doctor and P.id == E.patient and Ex.id == E.expert;
--
-- -- запрос докторов, инцидентов и пациентов женского пола
-- select D.sfm, P.sfm, P.diagnose, E.incident
-- from doctors as D join patients as P join expertise as E
-- where P.sex != 0 and E.incident == "инфаркт" and D.id == E.doctor and P.id == E.patient
-- order by P.diagnose;
--
-- -- запрос пациентов с именами заканчивающимися на "а"
-- select P.sfm, P.diagnose
-- from patients as P
-- where P.sfm like "%а";
--
-- -- запрос докторов и пациентов из одного отделения
-- select D.sfm, P.sfm, P.diagnose, P.department
-- from doctors as D join patients as P
-- where P.department == D.department and D.id == P.doctor
-- order by P.department;
--
-- -- запрос пациентов и докторов специализирующихся на онкологии
-- select D.sfm, D.specialization, P.sfm, P.diagnose, P.department
-- from doctors as D join patients as P
-- where D.id == P.doctor and D.specialization == "онколог"
-- order by P.department;
