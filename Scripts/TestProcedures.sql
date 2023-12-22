-- AIRCRAFTS
        -- ���������� ����˨��
        BEGIN
            AddAircraft(
                p_AModel => 'Boeing 737',
                p_Manufacturer => 'Boeing',
                p_CurrentStatus => 'Available',
                p_DateOfManufacture => TO_DATE('2022-01-01', 'YYYY-MM-DD'),
                p_LastMaintenanceDate => TO_DATE('2022-12-01', 'YYYY-MM-DD'),
                p_ACapacity => 140
                );
                AddAircraft(
                p_AModel => 'Boeing 512',
                p_Manufacturer => 'Boeing',
                p_CurrentStatus => 'Available',
                p_DateOfManufacture => TO_DATE('2022-01-01', 'YYYY-MM-DD'),
                p_LastMaintenanceDate => TO_DATE('2022-12-01', 'YYYY-MM-DD'),
                p_ACapacity => 100
                );
        END;
        /
        select * from Aircrafts;
        -- ���������� ����˨��
        BEGIN
            UpdateAircraft(
                p_AircraftID => 1,
                p_CurrentStatus => 'Disfunctional',
                p_ACapacity => 100
                );
        END;
        /
        select * from Aircrafts;
        -- �������� ����˨��
        BEGIN
            Deleteaircraft(
                p_AircraftID => 2
                );
        END;
        /

-- AIRLINES
        -- ���������� ������������
        BEGIN
            AddAirline(
                p_Name => '���������',
                p_Country => '��������'
                );
            AddAirline(
                p_Name => '���������',
                p_Country => '��������'
                );
            
        END;
        /
        -- ���������� ������������
        BEGIN
            UpdateAirline(
            p_AirlineID => 1,
            p_Name => '�����������',
            p_Country => '������'
            );
            
        END;
        /
        -- �������� ������������
        BEGIN
            DeleteAirline(
            p_AirlineID => 1
            );
            
        END;
        /

-- AIRPORTS
        -- ���������� ���������
        BEGIN
            AddAirport(
            p_Name => '���������� ��������',
            p_City => '������',
            p_Country => '��������'
            );
            AddAirport(
            p_Name => '��������� ��������',
            p_City => '�������',
            p_Country => '��������'
            );
            AddAirport(
            p_Name => '���������� ��������',
            p_City => '������',
            p_Country => '��������'
            );
            AddAirport(
            p_Name => '����������� ��������',
            p_City => '�������',
            p_Country => '������'
            );
        END;
        /
        -- ���������� ���������
        BEGIN
            UpdateAirport(
            p_AirportID => 1, 
            p_Name => '���������� ��������', 
            p_City => '������', 
            p_Country => '��������'
            );
            
        END;
        /
        -- �������� ���������
        BEGIN
            DeleteAirport(
            p_AirportID => 3
            );
            
        END;
        /

-- ROUTES
        -- ���������� ��������
        BEGIN
            AddRoute(
            p_DepartureAirportID => 1,
            p_ArrivalAirportID => 2
            );
            AddRoute(
            p_DepartureAirportID => 4,
            p_ArrivalAirportID => 1
            );
        END;
        /
        -- ���������� ��������
        BEGIN
            UpdateRoute(
            p_RouteID => 1, 
            p_DepartureAirportID => 1, 
            p_ArrivalAirportID => 4
            );
            
            
        END;
        /
        -- �������� ��������
        BEGIN
            DeleteRoute(
            p_RouteID => 2
            );
            
        END;
        /

-- FLIGHTS

        -- ���������� �����
        BEGIN
            AddFlight(
            p_AirlineID => 1,
            p_RouteID => 1,
            p_AircraftID => 1, 
            p_DepartureTime => '01-02-2022 23:03:20', 
            p_ArrivalTime => '02-02-2022 13:03:20');
            
        END;
        /
        -- ���������� �����
        BEGIN
            UpdateFlight(
            p_FlightID => 1,
            p_AirlineID => 1,
            p_RouteID => 2,
            p_AircraftID => 1,
            p_DepartureTime => '01-02-2022 23:03:20',
            p_ArrivalTime => '02-02-2022 13:03:20'
            );
        END;
        /
        -- �������� �����
        BEGIN
            DeleteFlight(
            p_FlightID => 1
            );
            
        END;
        /
        
-- PASSANGERS
        -- ���������� ���������
        BEGIN
            AMS_ADMIN.AddPassenger(
            p_FirstName => '�������',
            p_LastName => '���������',
            p_DateOfBirth => '15-07-2004'
            );
            
        END;
        /
        -- ���������� ���������
        BEGIN
            AMS_ADMIN.UpdatePassenger(
            p_PassengerID => 1, 
            p_FirstName => '������',
            p_LastName => '���������',
            p_DateOfBirth => '15-07-2004'
            );     
            
        END;
        /
        -- �������� ���������
        BEGIN
            AMS_ADMIN.DeletePassenger(
            p_PassengerID => 1
            );   
            
        END;
        /
        
-- TICKETS 
        -- ���������� ������
        BEGIN
            AddTicket(
            p_FlightID => 722,
            p_PassengerID => 697,
            p_SeatNumber => 2,
            p_Price => 1500
            );
            
        END;
        /
        select * from Flights;
        select * from Passengers;
        
        select * from Reservations;
        -- ���������� ������
        BEGIN
            UpdateTicket(
            p_TicketID => 1,
            p_FlightID => 1,
            p_PassengerID => 1,
            p_SeatNumber => 2,
            p_Price => 2000
            );     
            
        END;
        /
        -- �������� ������
        BEGIN
            DeleteTicket(2);   
            
        END;
        /
        
-- USERS
        -- ���������� ������������
        BEGIN
            AddUser(
            p_Username => 'dimaaqqw',
            p_PasswordHash => 'testpassword'
            );
            
        END;
        /
        select * from AMSUsers;
        -- ���������� ������������
        BEGIN
            UpdateUser(
            p_UserID => 9,
            p_Username => 'dimaaqqw',
            p_PasswordHash => 'passwordtest'
            );     
            
        END;
        /
        -- �������� ������������
        BEGIN
            DeleteUser(9);   
            
        END;
        /