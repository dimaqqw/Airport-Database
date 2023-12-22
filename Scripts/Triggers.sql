-- Trigger for Aircrafts table
    CREATE OR REPLACE TRIGGER update_maintenance_date
    BEFORE UPDATE ON Aircrafts
    FOR EACH ROW
    BEGIN
       :new.LastMaintenanceDate := SYSDATE;
    END;
    /

-- Trigger for Tickets table
    CREATE OR REPLACE TRIGGER CheckAircraftCapacity
    BEFORE INSERT ON Tickets
    FOR EACH ROW
    DECLARE
        v_AircraftCapacity INT;
        v_CurrentPassengerCount INT;
    BEGIN
    
        SELECT ACapacity INTO v_AircraftCapacity
        FROM Aircrafts
        WHERE AircraftID = (
            SELECT AircraftID
            FROM Flights
            WHERE FlightID = :new.FlightID
        );
    
        SELECT COUNT(*) INTO v_CurrentPassengerCount
        FROM Tickets
        WHERE FlightID = :new.FlightID;
    
        -- Check if adding or updating the ticket exceeds the aircraft capacity
        IF (v_CurrentPassengerCount + 1 > v_AircraftCapacity) THEN
            -- Raise an exception to prevent the operation
            RAISE_APPLICATION_ERROR(-20001, '���������� ������ ���������� ��-�� ���������� ����������� �������.');
        END IF;
    END;
    /

CREATE OR REPLACE TRIGGER ReserveTicket
AFTER INSERT ON Tickets
FOR EACH ROW
DECLARE
    v_ReservationID Reservations.ReservationID%TYPE;
BEGIN
    -- Generate a new ReservationID
    SELECT RESERVATION_SEQ.NEXTVAL INTO v_ReservationID FROM DUAL;

    -- Insert reservation information
    INSERT INTO Reservations (ReservationID, TicketID, ReservationDate)
    VALUES (v_ReservationID, :NEW.TicketID, SYSTIMESTAMP);
    
    DBMS_OUTPUT.PUT_LINE('Ticket reserved. Reservation ID: ' || v_ReservationID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END ReserveTicket;
/

CREATE OR REPLACE TRIGGER UpdateReservation
AFTER UPDATE ON Tickets
FOR EACH ROW
BEGIN
    -- Update reservation information when a ticket is updated
    IF :OLD.TicketID IS NOT NULL AND :NEW.TicketID IS NOT NULL THEN
        UPDATE Reservations
        SET TicketID = :NEW.TicketID
        WHERE TicketID = :OLD.TicketID;

        DBMS_OUTPUT.PUT_LINE('Ticket information updated. Reservation updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: TicketID cannot be NULL.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UpdateReservation;
/

drop trigger update_maintenance_date;
drop trigger CheckAircraftCapacity;
drop trigger ReserveTicket;
drop trigger UpdateReservation;
