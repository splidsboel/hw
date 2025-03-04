--1a
select count(*) from (
    select Name from countries 
    where Code in 
        (select CountryCode from empires 
        where Empire = 'Iberian'));


--1b
select count(*) from (
    select CountryCode
    from countries_continents
    group by CountryCode
    having 
        count(*) > 1
        AND SUM(CASE WHEN Continent = 'Europe' THEN 1 ELSE 0 END) > 0  
);


--1c
SELECT SUM(countries.Population * countries_languages.Percentage / 100) AS Spanish_Speakers
FROM countries
LEFT JOIN countries_languages ON countries.Code = countries_languages.CountryCode
LEFT JOIN countries_continents ON countries.Code = countries_continents.CountryCode
WHERE countries_continents.Continent = 'Europe'
AND countries.Population > 50000000
AND countries_languages.Language = 'Spanish'; 

--1d
WITH DanishEmpireCountries AS (
    -- Get all country codes for the Danish Empire
    SELECT CountryCode
    FROM empires
    WHERE Empire = 'Danish Empire'
),
LanguagesInDanishEmpire AS (
    -- Get languages spoken in countries of Danish Empire
    SELECT cl.Language
    FROM countries_languages cl
    JOIN DanishEmpireCountries dec ON cl.CountryCode = dec.CountryCode
    GROUP BY cl.Language
    HAVING COUNT(DISTINCT cl.CountryCode) = (SELECT COUNT(*) FROM DanishEmpireCountries)
)
-- Count the number of languages spoken in all countries of Danish Empire
SELECT count(*) AS LanguagesSpokenInAllDanishEmpireCountries
FROM LanguagesInDanishEmpire;


select * from empires;
select * from countries_languages;

--2c
--Person(PID, PN, S)
--House(HID, HS, HZ)
--Location(HZ, HC)

create table person(
    PID int PRIMARY KEY,
    PN varchar(50) not null,
    S int not null
);
insert into person
select distinct PID, PN, S 
from Rentals;

create table House (
    HID int primary key,
    HS varchar(50) not null,
    HZ int not null,
    foreign key (HZ) references Location(HZ)
)
insert into House
select distinct HID, HS, HZ 
from Rentals;

create table Location (
    HZ int primary key,
    HC varchar(50) not null
)
insert into Location
select HZ, HC 
from Rentals;

select * from empires where Empire = 'Danish Empire';