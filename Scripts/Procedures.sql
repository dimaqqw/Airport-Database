--DROP ALL PROCEDURES
drop procedure AddAircraft;
drop procedure DeleteAircraft;
drop procedure UpdateAircraft;

drop procedure AddAirport;
drop procedure DeleteAirport;
drop procedure UpdateAirport;

drop procedure AddAirline;
drop procedure DeleteAirline;
drop procedure UpdateAirline;

drop procedure AddFlight;
drop procedure DeleteFlight;
drop procedure UpdateFlight;

drop procedure AddRoute;
drop procedure DeleteRoute;
drop procedure UpdateRoute;

drop procedure AddUser;
drop procedure DeleteUser;
drop procedure UpdateUser;

drop procedure AddTicket;
drop procedure DeleteTicket;
drop procedure UpdateTicket;

drop procedure AddPassenger;
drop procedure DeletePassenger;
drop procedure UpdatePassenger;

drop procedure DisplayAvailableFlights;

-- AIRCRAFTS

        CREATE OR REPLACE PROCEDURE AddAircraft (
            p_AModel IN Aircrafts.AModel%TYPE,
            p_Manufacturer IN Aircrafts.Manufacturer%TYPE,
            p_CurrentStatus IN Aircrafts.CurrentStatus%TYPE,
            p_DateOfManufacture IN Aircrafts.DateOfManufacture%TYPE,
            p_LastMaintenanceDate IN Aircrafts.LastMaintenanceDate%TYPE,
            p_ACapacity IN Aircrafts.ACapacity%TYPE
        ) AS
            v_AircraftID Aircrafts.AircraftID%TYPE;
        BEGIN
            BEGIN
            -- Check if p_AircraftID is NULL
            IF p_AModel IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AModel cannot be NULL.');
            END IF;
    
            -- Check if p_ACapacity is NULL
            IF p_Manufacturer IS NULL THEN
                RAISE_APPLICATION_ERROR(-20005, 'Manufacturer cannot be NULL.');
            END IF;
    
            -- Check if p_CurrentStatus is NULL
            IF p_CurrentStatus IS NULL THEN
                RAISE_APPLICATION_ERROR(-20006, 'CurrentStatus cannot be NULL.');
            END IF;
            
            IF p_DateOfManufacture IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DateOfManufacture cannot be NULL.');
            END IF;
            
            IF p_LastMaintenanceDate IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'LastMaintenanceDate cannot be NULL.');
            END IF;
            
            IF p_ACapacity IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ACapacity cannot be NULL.');
            END IF;
            IF p_CurrentStatus NOT IN ('Assigned', 'Available', 'Disfunctional') THEN
                RAISE_APPLICATION_ERROR(-20003, 'Invalid CurrentStatus. Allowed values are Assigned, Available, Disfunctional.');
            END IF;
            IF p_ACapacity < 0 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Aircraft capacity cannot be negative.');
            END IF;
            SELECT AIRCRAFT_SEQ.NEXTVAL INTO v_AircraftID FROM DUAL;
            
            INSERT INTO Aircrafts (AircraftID, AModel, Manufacturer, CurrentStatus, DateOfManufacture, LastMaintenanceDate, ACapacity)
            VALUES (v_AircraftID, p_AModel, p_Manufacturer, p_CurrentStatus, p_DateOfManufacture, p_LastMaintenanceDate, p_ACapacity);
            DBMS_OUTPUT.PUT_LINE('������ ������� ��������.');
            COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ����˨��
        CREATE OR REPLACE PROCEDURE DeleteAircraft (
            p_AircraftID IN Aircrafts.AircraftID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AircraftID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AircraftID cannot be NULL.');
            END IF;
            DELETE FROM Aircrafts
            WHERE AircraftID = p_AircraftID;
            IF SQL%ROWCOUNT = 0 THEN
                    -- Raise an exception if no rows were affected (AircraftID not found)
                    RAISE_APPLICATION_ERROR(-20001, '������� � ID ' || p_AircraftID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������ ������� �����.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ����˨��
        CREATE OR REPLACE PROCEDURE UpdateAircraft (
            p_AircraftID in Aircrafts.AircraftID%TYPE,
            p_CurrentStatus IN Aircrafts.CurrentStatus%TYPE,
            p_ACapacity IN Aircrafts.ACapacity%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AircraftID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AircraftID cannot be NULL.');
            END IF;
            IF p_CurrentStatus IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'CurrentStatus cannot be NULL.');
            END IF;
            IF p_ACapacity IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ACapacity cannot be NULL.');
            END IF;
            IF p_ACapacity < 0 THEN
                RAISE_APPLICATION_ERROR(-20002, 'Aircraft capacity cannot be negative.');
            END IF;
            IF p_CurrentStatus NOT IN ('Assigned', 'Available', 'Disfunctional') THEN
                RAISE_APPLICATION_ERROR(-20003, 'Invalid CurrentStatus. Allowed values are Assigned, Available, Disfunctional.');
            END IF;
            UPDATE Aircrafts
            SET CurrentStatus = p_CurrentStatus,
                ACapacity = p_ACapacity
            WHERE AircraftID = p_AircraftID;
            IF SQL%ROWCOUNT = 0 THEN
                    -- Raise an exception if no rows were affected (AircraftID not found)
                    RAISE_APPLICATION_ERROR(-20001, '������� � ID ' || p_AircraftID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������ � ������� ������� ���������');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

-- AIRLINES
        -- ��������� ��� ���������� ������������
        CREATE OR REPLACE PROCEDURE AddAirline (
            p_Name IN Airlines.Name%TYPE,
            p_Country IN Airlines.Country%TYPE
        ) AS
            v_AirlineID Airlines.AirlineID%TYPE;
        BEGIN
            BEGIN
            IF p_Name IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Name cannot be NULL.');
            END IF;
            IF p_Country IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Country cannot be NULL.');
            END IF;
                SELECT AIRLINE_SEQ.NEXTVAL INTO v_AirlineID FROM DUAL;
                INSERT INTO Airlines (AirlineID, Name, Country)
                VALUES (v_AirlineID, p_Name, p_Country);
                COMMIT;
                DBMS_OUTPUT.PUT_LINE('������������ ������� ���������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ������������
        CREATE OR REPLACE PROCEDURE DeleteAirline (
            p_AirlineID IN Airlines.AirlineID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AirlineID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirlineID cannot be NULL.');
            END IF;
            DELETE FROM Airlines
            WHERE AirlineID = p_AirlineID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������������ � ID ' || p_AirlineID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������������ ������� �������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ������������
        CREATE OR REPLACE PROCEDURE UpdateAirline (
            p_AirlineID IN Airlines.AirlineID%TYPE,
            p_Name IN Airlines.Name%TYPE,
            p_Country IN Airlines.Country%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AirlineID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirlineID cannot be NULL.');
            END IF;
            IF p_Name IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Name cannot be NULL.');
            END IF;
            IF p_Country IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Country cannot be NULL.');
            END IF;
            UPDATE Airlines
            SET Name = p_Name, Country = p_Country
            WHERE AirlineID = p_AirlineID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������������ � ID ' || p_AirlineID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������������ ������� ���������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

-- AIRPORTS
        -- ��������� ��� ���������� ���������
        CREATE OR REPLACE PROCEDURE AddAirport (
            p_Name IN Airports.Name%TYPE,
            p_City IN Airports.City%TYPE,
            p_Country IN Airports.Country%TYPE
        ) AS
            v_AirportID Airports.AirportID%TYPE;
        BEGIN
            BEGIN
            IF p_Name IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Name cannot be NULL.');
            END IF;
            IF p_City IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'City cannot be NULL.');
            END IF;
            IF p_Country IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Country cannot be NULL.');
            END IF;
            SELECT AIRPORT_SEQ.NEXTVAL INTO v_AirportID FROM DUAL;
            INSERT INTO Airports (AirportID, Name, City, Country)
            VALUES (v_AirportID, p_Name, p_City, p_Country);
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('�������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ���������
        CREATE OR REPLACE PROCEDURE DeleteAirport (
            p_AirportID IN Airports.AirportID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirportID cannot be NULL.');
            END IF;
            DELETE FROM Airports
            WHERE AirportID = p_AirportID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '��������� � ID ' || p_AirportID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('�������� ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ����������� ���������
        CREATE OR REPLACE PROCEDURE UpdateAirport (
            p_AirportID IN Airports.AirportID%TYPE,
            p_Name IN Airports.Name%TYPE,
            p_City IN Airports.City%TYPE,
            p_Country IN Airports.Country%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_AirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirportID cannot be NULL.');
            END IF;
            IF p_Name IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Name cannot be NULL.');
            END IF;
            IF p_City IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'City cannot be NULL.');
            END IF;
            IF p_Country IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Country cannot be NULL.');
            END IF;
            UPDATE Airports
            SET Name = p_Name, City = p_City, Country = p_Country
            WHERE AirportID = p_AirportID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '��������� � ID ' || p_AirportID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('�������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        
-- ROUTES
        -- ��������� ��� ���������� ��������
        CREATE OR REPLACE PROCEDURE AddRoute (
            p_DepartureAirportID IN Routes.DepartureAirportID%TYPE,
            p_ArrivalAirportID IN Routes.ArrivalAirportID%TYPE
        ) AS
            v_RouteID Routes.RouteID%TYPE;
            v_DepartureAirportExists INT;
            v_ArrivalAirportExists INT;
        BEGIN
            BEGIN
            IF p_DepartureAirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DepartureAirportID cannot be NULL.');
            END IF;
            IF p_ArrivalAirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ArrivalAirportID cannot be NULL.');
            END IF;
            -- Check if DepartureAirportID exists
            SELECT COUNT(*) INTO v_DepartureAirportExists
            FROM Airports
            WHERE AirportID = p_DepartureAirportID;
        
            IF v_DepartureAirportExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'DepartureAirportID does not exist.');
            END IF;
        
            -- Check if ArrivalAirportID exists
            SELECT COUNT(*) INTO v_ArrivalAirportExists
            FROM Airports
            WHERE AirportID = p_ArrivalAirportID;
        
            IF v_ArrivalAirportExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'ArrivalAirportID does not exist.');
            END IF;

            SELECT ROUTE_SEQ.NEXTVAL INTO v_RouteID FROM DUAL;
            INSERT INTO Routes (RouteID, DepartureAirportID, ArrivalAirportID)
            VALUES (v_RouteID, p_DepartureAirportID, p_ArrivalAirportID);
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ��������
        CREATE OR REPLACE PROCEDURE DeleteRoute (
            p_RouteID IN Routes.RouteID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_RouteID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'RouteID cannot be NULL.');
            END IF;
            DELETE FROM Routes
            WHERE RouteID = p_RouteID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '�������� � ID ' || p_RouteID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������� ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ��������
        CREATE OR REPLACE PROCEDURE UpdateRoute (
            p_RouteID IN Routes.RouteID%TYPE,
            p_DepartureAirportID IN Routes.DepartureAirportID%TYPE,
            p_ArrivalAirportID IN Routes.ArrivalAirportID%TYPE
        ) AS
            v_DepartureAirportExists INT;
            v_ArrivalAirportExists INT;
        BEGIN
            BEGIN
            IF p_RouteID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'RouteID cannot be NULL.');
            END IF;
            IF p_DepartureAirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DepartureAirportID cannot be NULL.');
            END IF;
            IF p_ArrivalAirportID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ArrivalAirportID cannot be NULL.');
            END IF;
            -- Check if DepartureAirportID exists
            SELECT COUNT(*) INTO v_DepartureAirportExists
            FROM Airports
            WHERE AirportID = p_DepartureAirportID;
        
            IF v_DepartureAirportExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'DepartureAirportID does not exist.');
            END IF;
        
            -- Check if ArrivalAirportID exists
            SELECT COUNT(*) INTO v_ArrivalAirportExists
            FROM Airports
            WHERE AirportID = p_ArrivalAirportID;
        
            IF v_ArrivalAirportExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'ArrivalAirportID does not exist.');
            END IF;
            UPDATE Routes
            SET DepartureAirportID = p_DepartureAirportID, ArrivalAirportID = p_ArrivalAirportID
            WHERE RouteID = p_RouteID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '�������� � ID ' || p_RouteID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

-- FLIGHTS
        -- ��������� ��� ���������� �����
        CREATE OR REPLACE PROCEDURE AddFlight (
            p_AirlineID IN Flights.AirlineID%TYPE,
            p_RouteID IN Flights.RouteID%TYPE,
            p_AircraftID IN Flights.AircraftID%TYPE,
            p_DepartureTime IN Flights.DepartureTime%TYPE,
            p_ArrivalTime IN Flights.ArrivalTime%TYPE
        ) AS
            v_FlightID Flights.FlightID%TYPE;
            v_DepartureTime TIMESTAMP;
            v_ArrivalTime TIMESTAMP;
            v_AirlineExists INT;
            v_RouteExists INT;
            v_AircraftExists INT;
        BEGIN
            BEGIN
            IF p_AirlineID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirlineID cannot be NULL.');
            END IF;
            IF p_RouteID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'RouteID cannot be NULL.');
            END IF;
            IF p_AircraftID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AircraftID cannot be NULL.');
            END IF;
            IF p_DepartureTime IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DepartureTime cannot be NULL.');
            END IF;
            IF p_ArrivalTime IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ArrivalTime cannot be NULL.');
            END IF;
            -- Check if AirlineID exists
            SELECT COUNT(*) INTO v_AirlineExists
            FROM Airlines
            WHERE AirlineID = p_AirlineID;
        
            IF v_AirlineExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'AirlineID does not exist.');
            END IF;
        
            -- Check if RouteID exists
            SELECT COUNT(*) INTO v_RouteExists
            FROM Routes
            WHERE RouteID = p_RouteID;
        
            IF v_RouteExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'RouteID does not exist.');
            END IF;
        
            -- Check if AircraftID exists
            SELECT COUNT(*) INTO v_AircraftExists
            FROM Aircrafts
            WHERE AircraftID = p_AircraftID;
        
            IF v_AircraftExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'AircraftID does not exist.');
            END IF;
            BEGIN
                v_DepartureTime := TO_TIMESTAMP(p_DepartureTime, 'DD-MM-YYYY HH24:MI:SS');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20005, 'Invalid DepartureTime. Please provide a valid timestamp.');
            END;
        
            -- Check if ArrivalTime is a valid timestamp
            BEGIN
                v_ArrivalTime := TO_TIMESTAMP(p_ArrivalTime, 'DD-MM-YYYY HH24:MI:SS');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20006, 'Invalid ArrivalTime. Please provide a valid timestamp.');
            END;
            SELECT FLIGHT_SEQ.NEXTVAL INTO v_FlightID FROM DUAL;
            INSERT INTO Flights (FlightID, AirlineID, AircraftID, RouteID, DepartureTime, ArrivalTime)
            VALUES (v_FlightID, p_AirlineID, p_AircraftID, p_RouteID, v_DepartureTime, v_ArrivalTime);
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('���� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� �����
        CREATE OR REPLACE PROCEDURE DeleteFlight (
            p_FlightID IN Flights.FlightID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_FlightID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'FlightID cannot be NULL.');
            END IF;
            DELETE FROM Flights
            WHERE FlightID = p_FlightID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '����� � ID ' || p_FlightID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('���� ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� �����
        CREATE OR REPLACE PROCEDURE UpdateFlight (
            p_FlightID IN Flights.FlightID%TYPE,
            p_AirlineID IN Flights.AirlineID%TYPE,
            p_RouteID IN Flights.RouteID%TYPE,
            p_AircraftID IN Flights.AircraftID%TYPE,
            p_DepartureTime IN Flights.DepartureTime%TYPE,
            p_ArrivalTime IN Flights.ArrivalTime%TYPE
        ) AS
            v_DepartureTime TIMESTAMP;
            v_ArrivalTime TIMESTAMP;
            v_AirlineExists INT;
            v_RouteExists INT;
            v_AircraftExists INT;
        BEGIN
            BEGIN
            IF p_FlightID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'FlightID cannot be NULL.');
            END IF;
            IF p_AirlineID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AirlineID cannot be NULL.');
            END IF;
            IF p_RouteID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'RouteID cannot be NULL.');
            END IF;
            IF p_AircraftID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'AircraftID cannot be NULL.');
            END IF;
            IF p_DepartureTime IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DepartureTime cannot be NULL.');
            END IF;
            IF p_ArrivalTime IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'ArrivalTime cannot be NULL.');
            END IF;
            -- Check if AirlineID exists
            SELECT COUNT(*) INTO v_AirlineExists
            FROM Airlines
            WHERE AirlineID = p_AirlineID;
        
            IF v_AirlineExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'AirlineID does not exist.');
            END IF;
        
            -- Check if RouteID exists
            SELECT COUNT(*) INTO v_RouteExists
            FROM Routes
            WHERE RouteID = p_RouteID;
        
            IF v_RouteExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'RouteID does not exist.');
            END IF;
        
            -- Check if AircraftID exists
            SELECT COUNT(*) INTO v_AircraftExists
            FROM Aircrafts
            WHERE AircraftID = p_AircraftID;
        
            IF v_AircraftExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'AircraftID does not exist.');
            END IF;
            BEGIN
                v_DepartureTime := TO_TIMESTAMP(p_DepartureTime, 'DD-MM-YYYY HH24:MI:SS');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20005, 'Invalid DepartureTime. Please provide a valid timestamp.');
            END;
        
            -- Check if ArrivalTime is a valid timestamp
            BEGIN
                v_ArrivalTime := TO_TIMESTAMP(p_ArrivalTime, 'DD-MM-YYYY HH24:MI:SS');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20006, 'Invalid ArrivalTime. Please provide a valid timestamp.');
            END;
            UPDATE Flights
            SET AirlineID = p_AirlineID, RouteID = p_RouteID, AircraftID = p_AircraftID,
            DepartureTime = v_DepartureTime, ArrivalTime = v_ArrivalTime
            WHERE FlightID = p_FlightID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '����� � ID ' || p_FlightID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('���� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

-- PASSANGERS
        -- ��������� ��� ���������� ���������
        CREATE OR REPLACE PROCEDURE AddPassenger (
            p_FirstName IN Passengers.FirstName%TYPE,
            p_LastName IN Passengers.LastName%TYPE,
            p_DateOfBirth IN Passengers.DateOfBirth%TYPE
        ) AS
            v_PassengerID Passengers.PassengerID%TYPE;
            v_DateOfBirth DATE;
        BEGIN
            BEGIN
            IF p_FirstName IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'FirstName cannot be NULL.');
            END IF;
            IF p_LastName IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'LastName cannot be NULL.');
            END IF;
            IF p_DateOfBirth IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DateOfBirth cannot be NULL.');
            END IF;
            -- Check if DateOfBirth is a valid date
            BEGIN
                v_DateOfBirth := TO_DATE(p_DateOfBirth, 'DD-MM-YYYY');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20006, 'Invalid DateOfBirth. Please provide a valid date.');
            END;
            SELECT PASSANGER_SEQ.NEXTVAL INTO v_PassengerID FROM DUAL;
            INSERT INTO Passengers (PassengerID, FirstName, LastName, DateOfBirth)
            VALUES (v_PassengerID, p_FirstName, p_LastName, p_DateOfBirth);
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('�������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ���������
        CREATE OR REPLACE PROCEDURE DeletePassenger (
            p_PassengerID IN Passengers.PassengerID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_PassengerID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'PassengerID cannot be NULL.');
            END IF;
            DELETE FROM Passengers
            WHERE PassengerID = p_PassengerID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '��������� � ID ' || p_PassengerID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('�������� ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ���������
        CREATE OR REPLACE PROCEDURE UpdatePassenger (
            p_PassengerID IN Passengers.PassengerID%TYPE,
            p_FirstName IN Passengers.FirstName%TYPE,
            p_LastName IN Passengers.LastName%TYPE,
            p_DateOfBirth IN Passengers.DateOfBirth%TYPE
        ) AS
            v_DateOfBirth DATE;
        BEGIN
            BEGIN
            IF p_PassengerID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'PassengerID cannot be NULL.');
            END IF;
            IF p_FirstName IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'FirstName cannot be NULL.');
            END IF;
            IF p_LastName IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'LastName cannot be NULL.');
            END IF;
            IF p_DateOfBirth IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'DateOfBirth cannot be NULL.');
            END IF;
            -- Check if DateOfBirth is a valid date
            BEGIN
                v_DateOfBirth := TO_DATE(p_DateOfBirth, 'DD-MM-YYYY');
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20006, 'Invalid DateOfBirth. Please provide a valid date.');
            END;
            UPDATE Passengers
            SET FirstName = p_FirstName, LastName = p_LastName, DateOfBirth = v_DateOfBirth
            WHERE PassengerID = p_PassengerID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '��������� � ID ' || p_PassengerID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('�������� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

--TICKETS
        -- ��������� ��� ���������� ������
        CREATE OR REPLACE PROCEDURE AddTicket (
            p_FlightID IN Tickets.FlightID%TYPE,
            p_PassengerID IN Tickets.PassengerID%TYPE,
            p_SeatNumber IN Tickets.SeatNumber%TYPE,
            p_Price IN Tickets.Price%TYPE
        ) AS
            v_TicketID Tickets.TicketID%TYPE;
            v_FlightExists INT;
            v_PassengerExists INT;
        BEGIN
            -- Check if there is already a ticket for the specified flight and seat
            BEGIN
            -- Check for invalid values
                IF p_FlightID IS NULL THEN
                    RAISE_APPLICATION_ERROR(-20002, 'FlightID cannot be NULL.');
                END IF;
            
                IF p_PassengerID IS NULL THEN
                    RAISE_APPLICATION_ERROR(-20002, 'PassengerID cannot be NULL.');
                END IF;
            
                IF p_SeatNumber IS NULL OR LENGTH(p_SeatNumber) > 10 THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Invalid SeatNumber. It cannot be NULL and must be up to 10 characters.');
                END IF;
                IF p_Price IS NULL OR p_Price <= 0 THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Invalid Price. It must be not null or a positive value.');
                END IF;
                -- Check if FlightID exists
                SELECT COUNT(*) INTO v_FlightExists
                FROM Flights
                WHERE FlightID = p_FlightID;
            
                IF v_FlightExists = 0 THEN
                    RAISE_APPLICATION_ERROR(-20003, 'FlightID does not exist.');
                END IF;
            
                -- Check if PassengerID exists
                SELECT COUNT(*) INTO v_PassengerExists
                FROM Passengers
                WHERE PassengerID = p_PassengerID;
            
                IF v_PassengerExists = 0 THEN
                    RAISE_APPLICATION_ERROR(-20003, 'PassengerID does not exist.');
                END IF;
                SELECT TicketID
                INTO v_TicketID
                FROM Tickets
                WHERE FlightID = p_FlightID AND SeatNumber = p_SeatNumber;
        
                -- If a ticket already exists, raise an exception
                RAISE_APPLICATION_ERROR(-20001, '����� �� ���� ���� � ����� ������ ��� ����');
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                -- If no ticket is found, proceed with inserting a new ticket
                    BEGIN
                        SELECT TICKET_SEQ.NEXTVAL INTO v_TicketID FROM DUAL;
                        INSERT INTO Tickets (TicketID, FlightID, PassengerID, SeatNumber, Price)
                        VALUES (v_TicketID, p_FlightID, p_PassengerID, p_SeatNumber, p_Price);
                        COMMIT;
                        DBMS_OUTPUT.PUT_LINE('����� ������� ��������.');
                    EXCEPTION
                        WHEN OTHERS THEN
                            ROLLBACK;
                            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
                    END;
            END;
        END;
        /
        -- ��������� ��� �������� ������
        CREATE OR REPLACE PROCEDURE DeleteTicket (
            p_TicketID IN Tickets.TicketID%TYPE
        ) AS
        BEGIN
            BEGIN
            
            IF p_TicketID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'TicketID cannot be NULL.');
            END IF;
            DELETE FROM Tickets
            WHERE TicketID = p_TicketID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������ � ID ' || p_TicketID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('����� ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ������
        CREATE OR REPLACE PROCEDURE UpdateTicket (
            p_TicketID IN Tickets.TicketID%TYPE,
            p_FlightID IN Tickets.FlightID%TYPE,
            p_PassengerID IN Tickets.PassengerID%TYPE,
            p_SeatNumber IN Tickets.SeatNumber%TYPE,
            p_Price IN Tickets.Price%TYPE
        ) AS
            v_FlightExists INT;
            v_PassengerExists INT;
        BEGIN
            BEGIN
            -- Check for invalid values
                IF p_TicketID IS NULL THEN
                    RAISE_APPLICATION_ERROR(-20002, 'TicketID cannot be NULL.');
                END IF;
                IF p_FlightID IS NULL THEN
                    RAISE_APPLICATION_ERROR(-20002, 'FlightID cannot be NULL.');
                END IF;
            
                IF p_PassengerID IS NULL THEN
                    RAISE_APPLICATION_ERROR(-20002, 'PassengerID cannot be NULL.');
                END IF;
            
                IF p_SeatNumber IS NULL OR LENGTH(p_SeatNumber) > 10 THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Invalid SeatNumber. It cannot be NULL and must be up to 10 characters.');
                END IF;
                IF p_Price IS NULL OR p_Price <= 0 THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Invalid Price. It must be not null or a positive value.');
                END IF;
                -- Check if FlightID exists
            SELECT COUNT(*) INTO v_FlightExists
            FROM Flights
            WHERE FlightID = p_FlightID;
        
            IF v_FlightExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'FlightID does not exist.');
            END IF;
        
            -- Check if PassengerID exists
            SELECT COUNT(*) INTO v_PassengerExists
            FROM Passengers
            WHERE PassengerID = p_PassengerID;
        
            IF v_PassengerExists = 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'PassengerID does not exist.');
            END IF;
            UPDATE Tickets
            SET FlightID = p_FlightID, PassengerID = p_PassengerID, SeatNumber = p_SeatNumber, Price = p_Price
            WHERE TicketID = p_TicketID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������ � ID ' || p_TicketID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('����� ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
            END; 
           /

-- USERS
        -- ��������� ��� ���������� ������������
        CREATE OR REPLACE PROCEDURE AddUser (
            p_Username IN AMSUSERS.Username%TYPE,
            p_PasswordHash IN AMSUSERS.PasswordHash%TYPE
        ) AS
            v_UserID AMSUSERS.UserID%TYPE;
        BEGIN
            BEGIN
            IF p_Username IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Username cannot be NULL.');
            END IF;
            IF p_PasswordHash IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'PasswordHash cannot be NULL.');
            END IF;
            SELECT TICKET_SEQ.NEXTVAL INTO v_UserID FROM DUAL;
            INSERT INTO AMSUSERS (UserID, Username, PasswordHash)
            VALUES (v_UserID, p_Username, p_PasswordHash);
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('������������ ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� �������� ������������
        CREATE OR REPLACE PROCEDURE DeleteUser (
            p_UserID IN AMSUSERS.UserID%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_UserID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'UserID cannot be NULL.');
            END IF;
            DELETE FROM AMSUSERS
            WHERE UserID = p_UserID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������������ � ID ' || p_UserID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������������ ������� ������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /
        -- ��������� ��� ���������� ������������
        CREATE OR REPLACE PROCEDURE UpdateUser (
            p_UserID IN AMSUSERS.UserID%TYPE,
            p_Username IN AMSUSERS.Username%TYPE,
            p_PasswordHash IN AMSUSERS.PasswordHash%TYPE
        ) AS
        BEGIN
            BEGIN
            IF p_UserID IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'UserID cannot be NULL.');
            END IF;
            IF p_Username IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Username cannot be NULL.');
            END IF;
            IF p_PasswordHash IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'PasswordHash cannot be NULL.');
            END IF;
            UPDATE AMSUSERS
            SET Username = p_Username, PasswordHash = p_PasswordHash
            WHERE UserID = p_UserID;
            IF SQL%ROWCOUNT = 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, '������������ � ID ' || p_UserID || ' �� ����������.');
                END IF;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('������������ ������� ��������.');
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            END;
        END;
        /

-- Процедура вывода доступных рейсов
        CREATE OR REPLACE PROCEDURE DisplayAvailableFlights
            IS
                CURSOR flights_cursor IS
                    SELECT FlightID, DepartureTime, ArrivalTime
                    FROM Flights
                    WHERE DepartureTime >= SYSTIMESTAMP;
            BEGIN
                FOR flight_rec IN flights_cursor LOOP
                    DBMS_OUTPUT.PUT_LINE('Flight ID: ' || flight_rec.FlightID);
                    DBMS_OUTPUT.PUT_LINE('Departure Time: ' || TO_CHAR(flight_rec.DepartureTime, 'YYYY-MM-DD HH24:MI:SS'));
                    DBMS_OUTPUT.PUT_LINE('Arrival Time: ' || TO_CHAR(flight_rec.ArrivalTime, 'YYYY-MM-DD HH24:MI:SS'));
                    DBMS_OUTPUT.PUT_LINE('------------------------');
                END LOOP;
            END DisplayAvailableFlights;
            /
            

