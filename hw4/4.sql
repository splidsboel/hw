--a
select windfarmid
from windfarmownership group by windfarmid
having SUM(sharepercentage) !=100.0;

--b
select 