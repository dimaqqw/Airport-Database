-- Директория экспорта/импорта
CREATE OR REPLACE DIRECTORY UTL_DIR AS 'C:/JSON';
GRANT READ, WRITE ON DIRECTORY UTL_DIR TO public;

-- Процедура экспорта в json
CREATE OR REPLACE PROCEDURE ExportToJSON
    IS
        v_file UTL_FILE.FILE_TYPE;
        v_row Flights%ROWTYPE;
    BEGIN
        v_file := UTL_FILE.FOPEN('UTL_DIR','Flights.json','W');
        UTL_FILE.PUT_LINE(v_file, '[');
        FOR v_row in (select JSON_OBJECT(
            FlightID, AircraftID, AirlineID, RouteID, DepartureTime, ArrivalTime
        ) as json_data from Flights)
        LOOP
            UTL_FILE.PUT_LINE(v_file ,v_row.json_data ||  ',');
        END LOOP;
        UTL_FILE.PUT_LINE(v_file, ']');
        UTL_FILE.FCLOSE(v_file);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
        RAISE;
    END;
    -- TEST
    BEGIN
        ExportToJSON();
    END;
    /

-- Процедура импорта из json
CREATE OR REPLACE PROCEDURE IMPORT_JSON
    IS
    BEGIN
    FOR json_rec IN (
            SELECT FlightID, AircraftID, AirlineID, RouteID, DepartureTime, ArrivalTime
            FROM JSON_TABLE(BFILENAME('UTL_DIR', 'Flights.json'), '$[*]' COLUMNS (
                FlightID INT PATH '$.FlightID',
                AircraftID INT PATH '$.AircraftID',
                AirlineID INT PATH '$.AirlineID',
                RouteID INT PATH '$.RouteID',
                DepartureTime TIMESTAMP PATH '$.DepartureTime',
                ArrivalTime TIMESTAMP PATH '$.ArrivalTime'
            ))
        )
        LOOP
            BEGIN
                INSERT INTO Flights (FlightID, AircraftID, AirlineID, RouteID, DepartureTime, ArrivalTime)
                VALUES (json_rec.FlightID, json_rec.AircraftID, json_rec.AirlineID, json_rec.RouteID, json_rec.DepartureTime, json_rec.ArrivalTime);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Flights with the id already exists.');
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE('Error inserting Flight: ' || SQLERRM);
                    RAISE;
            END;
        END LOOP;
    END;
    -- TEST
    BEGIN
        IMPORT_JSON();
    END;
    /