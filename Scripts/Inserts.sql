-- AIRCRAFTS
    INSERT INTO Aircrafts (AircraftID, AModel, Manufacturer, CurrentStatus, DateOfManufacture, LastMaintenanceDate, ACapacity)
    SELECT
        AIRCRAFT_SEQ.NEXTVAL,
        'Model' || TO_CHAR(LEVEL),
        'Manufacturer' || TO_CHAR(LEVEL),
        'Available',
        TO_DATE('2022-01-01', 'YYYY-MM-DD'),
        TO_DATE('2022-01-01', 'YYYY-MM-DD'),
        ROUND(DBMS_RANDOM.VALUE(100, 500))
    FROM DUAL
    CONNECT BY LEVEL <= 100000;
    
-- AIRLINES
    INSERT INTO Airlines (AirlineID, Name, Country)
    SELECT
        AIRLINE_SEQ.NEXTVAL,
        'Airline' || TO_CHAR(LEVEL),
        'Country' || TO_CHAR(LEVEL)
    FROM DUAL
    CONNECT BY LEVEL <= 100000;
    
-- AIRPORTS
    INSERT INTO Airports (AirportID, Name, City, Country)
    SELECT
        AIRPORT_SEQ.NEXTVAL,
        'Airport' || TO_CHAR(LEVEL),
        'City' || TO_CHAR(LEVEL),
        'Country' || TO_CHAR(LEVEL)
    FROM DUAL
    CONNECT BY LEVEL <= 100000;
    
-- ROUTES
    INSERT INTO Routes (RouteID, DepartureAirportID, ArrivalAirportID)
    SELECT
        ROUTE_SEQ.NEXTVAL,
        MOD(LEVEL, 10) + 1, -- Departure Airport ID (Assuming 10 airports in the example)
        MOD(LEVEL + 1, 10) + 1 -- Arrival Airport ID (Assuming 10 airports in the example)
    FROM DUAL
    CONNECT BY LEVEL <= 100000;

-- FLIGHTS
    INSERT INTO Flights (FlightID, AirlineID, AircraftID, RouteID, DepartureTime, ArrivalTime)
    SELECT
        FLIGHT_SEQ.NEXTVAL,
        MOD(LEVEL, 5) + 1, -- AirlineID (Assuming 5 airlines in the example)
        MOD(LEVEL, 10) + 1, -- AircraftID (Assuming 10 aircrafts in the example)
        MOD(LEVEL, 10) + 1, -- RouteID (Assuming 10 routes in the example)
        SYSTIMESTAMP + INTERVAL '1' HOUR * LEVEL, -- DepartureTime
        SYSTIMESTAMP + INTERVAL '2' HOUR * LEVEL  -- ArrivalTime
    FROM DUAL
    CONNECT BY LEVEL <= 100000;

-- PASSENGERS
    INSERT INTO Passengers (PassengerID, FirstName, LastName, DateOfBirth)
    SELECT
        PASSENGER_SEQ.NEXTVAL,
        'FirstName' || TO_CHAR(LEVEL),
        'LastName' || TO_CHAR(LEVEL),
        TO_DATE('01-01-1990', 'DD-MM-YYYY') + LEVEL - 1 -- Adjust the birthdate based on your preference
    FROM DUAL
    CONNECT BY LEVEL <= 50000; -- Assuming 50,000 passengers in the example

-- TICKETS
    INSERT INTO Tickets (TicketID, FlightID, PassengerID, SeatNumber, Price)
    SELECT
        TICKET_SEQ.NEXTVAL,
        MOD(LEVEL, 100000) + 1, -- FlightID (Assuming 100,000 flights in the example)
        MOD(LEVEL, 50000) + 1, -- PassengerID (Assuming 50,000 passengers in the example)
        'Seat' || TO_CHAR(LEVEL),
        ROUND(DBMS_RANDOM.VALUE(50, 500), 2) -- Price
    FROM DUAL
    CONNECT BY LEVEL <= 100000;
