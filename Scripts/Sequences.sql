DROP SEQUENCE AIRCRAFT_SEQ;
DROP SEQUENCE AIRLINE_SEQ;
DROP SEQUENCE AIRPORT_SEQ;
DROP SEQUENCE FLIGHT_SEQ;
DROP SEQUENCE ROUTE_SEQ;
DROP SEQUENCE PASSANGER_SEQ;
DROP SEQUENCE TICKET_SEQ;
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE RESERVATION_SEQ;
DROP SEQUENCE PASSENGER_SEQ;

CREATE SEQUENCE AIRCRAFT_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE AIRLINE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE AIRPORT_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE FLIGHT_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE ROUTE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE PASSANGER_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE TICKET_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE USER_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE RESERVATION_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE PASSENGER_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;