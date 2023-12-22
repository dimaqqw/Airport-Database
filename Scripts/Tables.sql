--DROPS
drop table Reservations;
drop table AMSUsers;
drop table Tickets;
drop table Passengers;
drop table Flights;
drop table Routes;
drop table Airports;
drop table Airlines;
drop table Aircrafts;
--TABLES

--Самолёты
CREATE TABLE Aircrafts (
    AircraftID INT primary key ,
    AModel varchar(255) not null,
    Manufacturer varchar(255) not null,
    CurrentStatus varchar(20) DEFAULT 'Available' CHECK (CurrentStatus IN ('Assigned', 'Available', 'Disfunctional')),
    DateOfManufacture date not null,
    LastMaintenanceDate date not null,
    ACapacity INT not null
);
--Авиакомпании
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY,
    Name VARCHAR(255),
    Country VARCHAR(255)
);
--Аэропорты
CREATE TABLE Airports (
    AirportID INT PRIMARY KEY,
    Name VARCHAR(255),
    City VARCHAR(255),
    Country VARCHAR(255)
);
--Маршруты
CREATE TABLE Routes (
    RouteID INT PRIMARY KEY,
    DepartureAirportID INT,
    ArrivalAirportID INT,
    FOREIGN KEY (DepartureAirportID) REFERENCES Airports(AirportID) ON DELETE CASCADE,
    FOREIGN KEY (ArrivalAirportID) REFERENCES Airports(AirportID) ON DELETE CASCADE
);
--Рейсы
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    AircraftID INT,
    AirlineID INT,
    RouteID INT,
    DepartureTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ArrivalTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID) ON DELETE CASCADE,
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID) ON DELETE CASCADE,
    FOREIGN KEY (AircraftID) REFERENCES Aircrafts(AircraftID) ON DELETE CASCADE
);

--Пасажиры
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    DateOfBirth DATE
);
--Билеты
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY,
    FlightID INT,
    PassengerID INT,
    SeatNumber VARCHAR(10),
    Price DECIMAL(10, 2),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID) ON DELETE CASCADE, 
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID) ON DELETE CASCADE
);

--Пользователи
CREATE TABLE AMSUsers (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255) UNIQUE,
    PasswordHash VARCHAR(255)
);
--Резервирование рейсов
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    TicketID INT,
    ReservationDate DATE,
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID) ON DELETE CASCADE
);


