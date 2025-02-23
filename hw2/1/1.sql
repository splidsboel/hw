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