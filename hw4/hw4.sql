create or replace table countries (
  countryid int,
  name string,
  capitalcity string,
  continent string,
  populationcount int
);

create or replace table powercompanies (
  companyid int,
  name string,
  headquarterscountryid int,
);

create or replace table windfarms (
  windfarmid int,
  name string,
  countryid int,
  locationtype string, -- 'land' or 'sea'
);

create or replace table windturbines (
  windturbineid int,
  windfarmid int,
  poweroutputkw int
);

create or replace table windfarmownership (
  windfarmid int,
  companyid int,
  sharepercentage float
);

insert into countries values
(1, 'USA', 'Washington D.C.', 'North America', 331000000),
(2, 'Canada', 'Ottawa', 'North America', 38000000),
(3, 'Germany', 'Berlin', 'Europe', 83000000),
(4, 'France', 'Paris', 'Europe', 67000000),
(5, 'Spain', 'Madrid', 'Europe', 47000000),
(6, 'Australia', 'Canberra', 'Oceania', 26000000),
(7, 'Brazil', 'Brasília', 'South America', 213000000),
(8, 'India', 'New Delhi', 'Asia', 1393000000),
(9, 'Japan', 'Tokyo', 'Asia', 126000000),
(10, 'South Africa', 'Pretoria', 'Africa', 60000000);

insert into powercompanies values
(1, 'GreenEnergy Corp', 1),
(2, 'WindPower Inc', 2),
(3, 'EcoWind Solutions', 3),
(4, 'Renewable Energy Ltd', 4),
(5, 'Sustainable Power Co', 10),
(6, 'CleanEnergy Pty', 6),
(7, 'Vento Verde', 7),
(8, 'Asian Wind Power', 5);

insert into windfarms values
(1, 'WindFarm Alpha', 1, 'Land'),
(2, 'WindFarm Beta', 2, 'Sea'),
(3, 'WindFarm Gamma', 9, 'Land'),
(4, 'WindFarm Delta', 4, 'Sea'),
(5, 'WindFarm Epsilon', 5, 'Land'),
(6, 'WindFarm Zeta', 5, 'Sea'),
(7, 'WindFarm Eta', 7, 'Land'),
(8, 'WindFarm Theta', 8, 'Sea'),
(9, 'WindFarm Iota', 9, 'Land'),
(10, 'WindFarm Kappa', 7, 'Sea'),
(11, 'WindFarm Lambda', 1, 'Land'),
(12, 'WindFarm Mu', 2, 'Sea'),
(13, 'WindFarm Nu', 2, 'Land'),
(14, 'WindFarm Xi', 4, 'Sea'),
(15, 'WindFarm Omicron', 5, 'Land');

insert into windturbines values
(1, 1, 2000), (2, 1, 2100), (3, 1, 2200), (4, 1, 2300), (5, 1, 2400),
(6, 2, 2500), (7, 2, 2600), (8, 2, 2700), (9, 2, 2800), (10, 2, 2900),
(11, 3, 3000), (12, 3, 3100), (13, 3, 3200), (14, 3, 3300), (15, 3, 3400),
(16, 4, 3500), (17, 4, 3600), (18, 4, 3700), (19, 4, 3800), (20, 4, 3900),
(21, 5, 4000), (22, 5, 4100), (23, 5, 4200), (24, 5, 4300), (25, 5, 4400),
(26, 6, 4500), (27, 6, 4600), (28, 6, 4700), (29, 6, 4800), (30, 6, 4900),
(31, 7, 5000), (32, 7, 5100), (33, 7, 5200), (34, 7, 5300), (35, 7, 5400),
(36, 8, 5500), (37, 8, 5600), (38, 8, 5700), (39, 8, 5800), (40, 8, 5900),
(41, 9, 6000), (42, 9, 6100), (43, 9, 6200), (44, 9, 6300), (45, 9, 6400),
(46, 10, 6500), (47, 10, 6600), (48, 10, 6700), (49, 10, 6800), (50, 10, 6900),
(51, 11, 7000), (52, 11, 7100), (53, 11, 7200), (54, 11, 7300), (55, 11, 7400),
(56, 12, 7500), (57, 12, 7600), (58, 12, 7700), (59, 12, 7800), (60, 12, 7900),
(61, 13, 8000), (62, 13, 8100), (63, 13, 8200), (64, 13, 8300), (65, 13, 8400),
(66, 14, 8500), (67, 14, 8600), (68, 14, 8700), (69, 14, 8800), (70, 14, 8900),
(71, 15, 9000), (72, 15, 9100), (73, 15, 9200), (74, 15, 9300), (75, 15, 9400),
(76, 1, 9500), (77, 2, 9600), (78, 3, 9700), (79, 4, 9800), (80, 5, 9900),
(81, 6, 10000), (82, 7, 10100), (83, 8, 10200), (84, 9, 10300), (85, 10, 10400),
(86, 11, 10500), (87, 12, 10600), (88, 13, 10700), (89, 14, 10800), (90, 15, 10900),
(91, 1, 11000), (92, 2, 11100), (93, 3, 11200), (94, 4, 11300), (95, 5, 11400),
(96, 6, 11500), (97, 7, 11600), (98, 8, 11700), (99, 9, 11800), (100, 10, 11900);

-- insert sample data into the windfarmownership table
insert into windfarmownership (windfarmid, companyid, sharepercentage) values
(1, 1, 100.0), 
(2, 1, 50.0), (2, 2, 30.0), (2, 3, 20.0),
(3, 1, 70.0), (3, 4, 30.0),
(4, 4, 100.0),
(5, 4, 65.0), (5, 5, 35.0),
(6, 6, 75.0), (6, 7, 25.0),
(7, 7, 80.0), (7, 8, 20.0),
(8, 8, 50.0), (8, 1, 50.0),
(9, 1, 100.0),
(10, 2, 55.0), (10, 3, 20.0), (10, 4, 20.0), (10, 5, 5.0),
(11, 3, 100.0),
(12, 4, 100.0),
(13, 5, 65.0), (13, 6, 35.0),
(14, 6, 75.0), (14, 7, 15.0),
(15, 7, 80.0), (15, 8, 20.0);


