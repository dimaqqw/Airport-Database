drop function GetNumberOfTicketsSold;
drop function GetPopularRoutes;
drop function GetTotalAvailableFlightsFromCurrentDate;
drop function GetTotalAvailableFlights;
drop function GetFlightRevenue;
drop function GetAverageTicketPricePerAirline;
drop function GetTopNFlightsByRevenue;

-- ??????? ????????? ???-?? ???????? ???????
    CREATE OR REPLACE FUNCTION GetNumberOfTicketsSold(
        p_FlightID IN Flights.FlightID%TYPE) RETURN NUMBER IS
        v_NumTickets NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_NumTickets
        FROM Tickets
        WHERE FlightID = p_FlightID;
    
        RETURN v_NumTickets;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END;
    /
    -- TEST
    SELECT GetNumberOfTicketsSold(1) AS NumTicketsSold FROM DUAL;

-- ??????? ????????? ?????????? ?????????
    CREATE OR REPLACE FUNCTION GetPopularRoutes RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT
                R.RouteID,
                A1.City || ' to ' || A2.City AS Route,
                COUNT(T.TicketID) AS TicketsSold
            FROM
                Routes R
                JOIN Flights F ON R.RouteID = F.RouteID
                JOIN Tickets T ON F.FlightID = T.FlightID
                JOIN Airports A1 ON R.DepartureAirportID = A1.AirportID
                JOIN Airports A2 ON R.ArrivalAirportID = A2.AirportID
            GROUP BY
                R.RouteID, A1.City, A2.City
            ORDER BY
                TicketsSold DESC;
    
        RETURN v_Cursor;
    END;
    /
    -- TEST
    DECLARE
        popularRoutesCursor SYS_REFCURSOR;
        routeID NUMBER;
        routeDescription VARCHAR2(255);
        ticketsSold NUMBER;
    BEGIN
        popularRoutesCursor := GetPopularRoutes;
    
        LOOP
            FETCH popularRoutesCursor INTO routeID, routeDescription, ticketsSold;
            EXIT WHEN popularRoutesCursor%NOTFOUND;
    
            -- Do something with the retrieved data, such as printing or processing
            DBMS_OUTPUT.PUT_LINE('Route ID: ' || routeID || ', Route: ' || routeDescription || ', Tickets Sold: ' || ticketsSold);
        END LOOP;
    
        CLOSE popularRoutesCursor;
    END;
    /

-- ??????? ????????? ????? ????????? ?????? ?? ??????? ????
    CREATE OR REPLACE FUNCTION GetTotalAvailableFlightsFromCurrentDate RETURN NUMBER IS
        v_TotalFlights NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_TotalFlights
        FROM Flights
        WHERE DepartureTime >= SYSDATE;
    
        RETURN v_TotalFlights;
    END;
    /
    -- TEST
    DECLARE
    totalAvailableFlights NUMBER;
    BEGIN
        totalAvailableFlights := GetTotalAvailableFlightsFromCurrentDate;
    
        -- Do something with the totalAvailableFlights, such as printing or processing
        DBMS_OUTPUT.PUT_LINE('Total Available Flights from Current Date: ' || totalAvailableFlights);
    END;
    /
    
-- ??????? ????????? ????? ????????? ?????? ?? ????????? ??????? 
    CREATE OR REPLACE FUNCTION GetTotalAvailableFlights (
        p_StartDate IN DATE,
        p_EndDate   IN DATE
    ) RETURN NUMBER IS
        v_TotalFlights NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_TotalFlights
        FROM Flights
        WHERE DepartureTime BETWEEN p_StartDate AND p_EndDate;
    
        RETURN v_TotalFlights;
    END;
    /
    -- TEST
    DECLARE
        totalAvailableFlights NUMBER;
    BEGIN
        totalAvailableFlights := GetTotalAvailableFlights('01-01-2020', '01-01-2024');
    
        -- Do something with the totalAvailableFlights, such as printing or processing
        DBMS_OUTPUT.PUT_LINE('Total Available Flights: ' || totalAvailableFlights);
    END;
    /

-- ??????? ????????? ???????? ??????? ?? ?????
    CREATE OR REPLACE FUNCTION GetFlightRevenue(p_FlightID INT) RETURN DECIMAL
    AS
        v_TotalRevenue DECIMAL;
    BEGIN
        SELECT COALESCE(SUM(Price), 0) INTO v_TotalRevenue
        FROM Tickets
        WHERE FlightID = p_FlightID;
    
        RETURN v_TotalRevenue;
    END GetFlightRevenue;
    /
    -- TEST
    DECLARE
        v_TotalRevenue DECIMAL;
        v_param NUMBER := 1;
    BEGIN
        v_TotalRevenue := GetFlightRevenue(v_param);
        DBMS_OUTPUT.PUT_LINE('Total Revenue for Flight ' || v_param || ': ' v_TotalRevenue);
    END;
    /

-- ??????? ????????? ??????? ???? ?????? ?? ????????????
    CREATE OR REPLACE FUNCTION GetAverageTicketPricePerAirline RETURN VARCHAR2
    AS
        v_Result VARCHAR2(1000);
    BEGIN
        FOR rec IN (SELECT AirlineID, AVG(Price) AS AvgTicketPrice
                    FROM Tickets t
                    JOIN Flights f ON t.FlightID = f.FlightID
                    GROUP BY AirlineID)
        LOOP
            v_Result := v_Result || 'Airline ' || rec.AirlineID || ': Average Ticket Price - ' || rec.AvgTicketPrice || CHR(10);
        END LOOP;
    
        RETURN v_Result;
    END GetAverageTicketPricePerAirline;
    /
    -- TEST
    DECLARE
        v_AirlineInfo VARCHAR2(1000);
    BEGIN
        v_AirlineInfo := GetAverageTicketPricePerAirline;
        DBMS_OUTPUT.PUT_LINE(v_AirlineInfo);
    END;
    /

-- ??????? ????????? ????(N) ?????? ?? ?????????   
    CREATE OR REPLACE FUNCTION GetTopNFlightsByRevenue(p_TopN INT) RETURN VARCHAR2
    AS
        v_Result VARCHAR2(1000);
    BEGIN
        FOR rec IN (SELECT f.FlightID, SUM(t.Price) AS TotalRevenue
                    FROM Flights f
                    LEFT JOIN Tickets t ON f.FlightID = t.FlightID
                    GROUP BY f.FlightID
                    ORDER BY TotalRevenue DESC
                    FETCH FIRST p_TopN ROWS ONLY)
        LOOP
            v_Result := v_Result || 'Flight ' || rec.FlightID || ': Total Revenue - ' || rec.TotalRevenue || CHR(10);
        END LOOP;
    
        RETURN v_Result;
    END GetTopNFlightsByRevenue;
    /
    -- TEST
    DECLARE
        v_TopNFlights VARCHAR2(1000);
    BEGIN
        v_TopNFlights := GetTopNFlightsByRevenue(3);
        DBMS_OUTPUT.PUT_LINE(v_TopNFlights);
    END;
    /