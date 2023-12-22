create role admin_role;

GRANT CREATE SESSION TO admin_role;

GRANT EXECUTE ON AddAircraft TO admin_role;
GRANT EXECUTE ON DeleteAircraft TO admin_role;
GRANT EXECUTE ON UpdateAircraft TO admin_role;

GRANT EXECUTE ON AddAirport TO admin_role;
GRANT EXECUTE ON DeleteAirport TO admin_role;
GRANT EXECUTE ON UpdateAirport TO admin_role;

GRANT EXECUTE ON AddAirline TO admin_role;
GRANT EXECUTE ON DeleteAirline TO admin_role;
GRANT EXECUTE ON UpdateAirline TO admin_role;

GRANT EXECUTE ON AddFlight TO admin_role;
GRANT EXECUTE ON DeleteFlight TO admin_role;
GRANT EXECUTE ON UpdateFlight TO admin_role;

GRANT EXECUTE ON AddRoute TO admin_role;
GRANT EXECUTE ON DeleteRoute TO admin_role;
GRANT EXECUTE ON UpdateRoute TO admin_role;

GRANT EXECUTE ON AddUser TO admin_role;
GRANT EXECUTE ON DeleteUser TO admin_role;
GRANT EXECUTE ON UpdateUser TO admin_role;

GRANT EXECUTE ON AddTicket TO admin_role;
GRANT EXECUTE ON DeleteTicket TO admin_role;
GRANT EXECUTE ON UpdateTicket TO admin_role;

GRANT EXECUTE ON AddPassenger TO admin_role;
GRANT EXECUTE ON DeletePassenger TO admin_role;
GRANT EXECUTE ON UpdatePassenger TO admin_role;

GRANT EXECUTE ON GetNumberOfTicketsSold TO admin_role;
GRANT EXECUTE ON GetPopularRoutes TO admin_role;
GRANT EXECUTE ON GetTotalAvailableFlightsFromCurrentDate TO admin_role;
GRANT EXECUTE ON GetTotalAvailableFlights TO admin_role;
GRANT EXECUTE ON DisplayAvailableFlights TO admin_role;

create user AMS_ADMIN identified by 1234;
grant admin_role to AMS_ADMIN;

CREATE ROLE user_role; 
GRANT CREATE SESSION to user_role;

GRANT EXECUTE ON AddPassenger TO user_role;
GRANT EXECUTE ON DeletePassenger TO user_role;
GRANT EXECUTE ON UpdatePassenger TO user_role;

GRANT EXECUTE ON AddUser TO user_role;
GRANT EXECUTE ON DeleteUser TO user_role;
GRANT EXECUTE ON UpdateUser TO user_role;

GRANT EXECUTE ON AddTicket TO user_role;
GRANT EXECUTE ON DeleteTicket TO user_role;
GRANT EXECUTE ON UpdateTicket TO user_role;

GRANT EXECUTE ON GetTotalAvailableFlightsFromCurrentDate TO user_role;
GRANT EXECUTE ON DisplayAvailableFlights TO user_role;

create user AMS_USER identified by 1234;
grant user_role to AMS_USER;




