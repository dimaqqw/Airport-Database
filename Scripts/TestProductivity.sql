select count(*) from Flights;

select * from Flights;

select * from Flights 
where RouteId = 10 and AircraftId = 10;

explain plan for select *
from Flights
where RouteId = 10 and AircraftId = 10;
select * from table(DBMS_XPLAN.DISPLAY());

CREATE INDEX idx_RouteID ON Flights(RouteID);