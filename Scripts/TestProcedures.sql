-- AIRCRAFTS
        -- ДОБАВЛЕНИЕ САМОЛЁТА
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
        -- ОБНОВЛЕНИЕ САМОЛЁТА
        BEGIN
            UpdateAircraft(
                p_AircraftID => 1,
                p_CurrentStatus => 'Disfunctional',
                p_ACapacity => 100
                );
        END;
        /
        select * from Aircrafts;
        -- УДАЛЕНИЕ САМОЛЁТА
        BEGIN
            Deleteaircraft(
                p_AircraftID => 2
                );
        END;
        /

-- AIRLINES
        -- ДОБАВЛЕНИЕ АВИАКОМПАНИИ
        BEGIN
            AddAirline(
                p_Name => 'МинскАвиа',
                p_Country => 'Беларусь'
                );
            AddAirline(
                p_Name => 'МинскАвиа',
                p_Country => 'Беларусь'
                );
            
        END;
        /
        -- ОБНОВЛЕНИЕ АВИАКОМПАНИИ
        BEGIN
            UpdateAirline(
            p_AirlineID => 1,
            p_Name => 'МоскоуПортс',
            p_Country => 'Россия'
            );
            
        END;
        /
        -- УДАЛЕНИЕ АВИАКОМПАНИИ
        BEGIN
            DeleteAirline(
            p_AirlineID => 1
            );
            
        END;
        /

-- AIRPORTS
        -- ДОБАВЛЕНИЕ АЭРОПОРТА
        BEGIN
            AddAirport(
            p_Name => 'Могилёвский Аэропорт',
            p_City => 'Могилёв',
            p_Country => 'Беларусь'
            );
            AddAirport(
            p_Name => 'Витебский Аэропорт',
            p_City => 'Витебск',
            p_Country => 'Беларусь'
            );
            AddAirport(
            p_Name => 'Гомельский Аэропорт',
            p_City => 'Гомель',
            p_Country => 'Беларусь'
            );
            AddAirport(
            p_Name => 'Воронежский Аэропорт',
            p_City => 'Воронеж',
            p_Country => 'Россия'
            );
        END;
        /
        -- ОБНОВЛЕНИЕ АЭРОПОРТА
        BEGIN
            UpdateAirport(
            p_AirportID => 1, 
            p_Name => 'Могилёвский Аэропорт', 
            p_City => 'Могилёв', 
            p_Country => 'Беларусь'
            );
            
        END;
        /
        -- УДАЛЕНИЕ АЭРОПОРТА
        BEGIN
            DeleteAirport(
            p_AirportID => 3
            );
            
        END;
        /

-- ROUTES
        -- ДОБАВЛЕНИЕ МАРШРУТА
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
        -- ОБНОВЛЕНИЕ МАРШРУТА
        BEGIN
            UpdateRoute(
            p_RouteID => 1, 
            p_DepartureAirportID => 1, 
            p_ArrivalAirportID => 4
            );
            
            
        END;
        /
        -- УДАЛЕНИЕ МАРШРУТА
        BEGIN
            DeleteRoute(
            p_RouteID => 2
            );
            
        END;
        /

-- FLIGHTS

        -- ДОБАВЛЕНИЕ РЕЙСА
        BEGIN
            AddFlight(
            p_AirlineID => 1,
            p_RouteID => 1,
            p_AircraftID => 1, 
            p_DepartureTime => '01-02-2022 23:03:20', 
            p_ArrivalTime => '02-02-2022 13:03:20');
            
        END;
        /
        -- ОБНОВЛЕНИЕ РЕЙСА
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
        -- УДАЛЕНИЕ РЕЙСА
        BEGIN
            DeleteFlight(
            p_FlightID => 1
            );
            
        END;
        /
        
-- PASSANGERS
        -- ДОБАВЛЕНИЕ ПАССАЖИРА
        BEGIN
            AMS_ADMIN.AddPassenger(
            p_FirstName => 'Дмитрий',
            p_LastName => 'Денисенко',
            p_DateOfBirth => '15-07-2004'
            );
            
        END;
        /
        -- ОБНОВЛЕНИЕ ПАССАЖИРА
        BEGIN
            AMS_ADMIN.UpdatePassenger(
            p_PassengerID => 1, 
            p_FirstName => 'Валуев',
            p_LastName => 'Александр',
            p_DateOfBirth => '15-07-2004'
            );     
            
        END;
        /
        -- УДАЛЕНИЕ ПАССАЖИРА
        BEGIN
            AMS_ADMIN.DeletePassenger(
            p_PassengerID => 1
            );   
            
        END;
        /
        
-- TICKETS 
        -- ДОБАВЛЕНИЕ БИЛЕТА
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
        -- ОБНОВЛЕНИЕ БИЛЕТА
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
        -- УДАЛЕНИЕ БИЛЕТА
        BEGIN
            DeleteTicket(2);   
            
        END;
        /
        
-- USERS
        -- ДОБАВЛЕНИЕ ПОЛЬЗОВАТЕЛЯ
        BEGIN
            AddUser(
            p_Username => 'dimaaqqw',
            p_PasswordHash => 'testpassword'
            );
            
        END;
        /
        select * from AMSUsers;
        -- ОБНОВЛЕНИЕ ПОЛЬЗОВАТЕЛЯ
        BEGIN
            UpdateUser(
            p_UserID => 9,
            p_Username => 'dimaaqqw',
            p_PasswordHash => 'passwordtest'
            );     
            
        END;
        /
        -- УДАЛЕНИЕ ПОЛЬЗОВАТЕЛЯ
        BEGIN
            DeleteUser(9);   
            
        END;
        /