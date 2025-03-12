create table wind_turbine_production (
 production_date date,
 turbine_id string,
 power_output double
);


copy wind_turbine_production
from '/Users/jakobeg/Downloads/wind_turbine_production.csv'
with (header 'true');


--1
with less_than as (
    select 
        case 
            when power_output-lag(power_output, 1) over (partition by turbine_id order by production_date)<0 then TRUE
            else FALSE
        END as less_than_previous_day
    from wind_turbine_production
    where turbine_id = 'WT-001'
)

select count(*) from less_than where less_than_previous_day = true;


--2
