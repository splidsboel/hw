create table wind_turbine_production (
 production_date date,
 turbine_id string,
 power_output double
);


copy wind_turbine_production
from '/Users/jakobeg/Uni/SD/2 sem/db/hw/hw3/wind_turbine_production.csv'
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
select count(*) from (
select * from (
    select *,
    rank() over (
        partition by production_date
        order by power_output desc
    ) as rank_no
    from wind_turbine_production)
where turbine_id = 'WT-001' and rank_no = 1);

--3
with daily_total_power_output as (
    select 
        production_date,
        sum(power_output) as total_output
    from wind_turbine_production
    group by production_date
)
select count(*) from (
    select * from (
        select production_date, total_output,
            coalesce(lag(total_output, 3) over(order by production_date), 0)+ 
            coalesce(lag(total_output, 2) over(order by production_date), 0)+ 
            coalesce(lag(total_output, 1) over(order by production_date), 0)
            as previous_three_days,
        from daily_total_power_output
    )
    where previous_three_days>500
);

--4
with cum_power_output as (
    select 
            turbine_id,
            production_date,
            sum(power_output) over (
                partition by turbine_id
                order by production_date
                rows between unbounded preceding and current row
            )
            as cum_output
        from wind_turbine_production
)

select cum_output from cum_power_output where turbine_id='WT-001' and production_date='2025-01-05';



--RBAC

--creating roles 
create role VP
create role Student
create role Lecturer


--student grant
grant select on table grades to role Student

--lecturer grants
grant insert on table feedback to role Lecturer
grant select on table feedback to role Lecturer
grant update on table feedback to role Lecturer


grant Student to VP;
grant Lecturer to VP;

