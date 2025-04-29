create table Power_company(
    power_company_name varchar(100) primary key,
    country_name varchar(100),
    foreign key (country_name) references Country(country_name)
);

create table Wind_farm(
    wind_farm_name varchar(100) primary key,
    on_land boolean,
    foreign key (country_name) references Country(country_name)
);

create table Wind_turbine(
    ID int primary key,
    power_output float,
    foreign key (wind_farm_name) references Wind_farm(wind_farm_name)
);

create table Country(
    country_name varchar(100) primary key,
    population_count int,
);

create table Operation(
    power_company_name varchar(100),
    wind_farm_name varchar(100),
    primary key (power_company_name, wind_farm_name),
    foreign key (power_company_name) references Power_company(power_company_name),
    foreign key (wind_farm_name) references Wind_farm(wind_farm_name)
);