CREATE DATABASE us_accidents_db;
USE us_accidents_db;

CREATE TABLE location (
    Location_ID INT PRIMARY KEY,
    Start_Lat DOUBLE,
    Start_Lng DOUBLE,
    Street VARCHAR(255),
    City VARCHAR(100),
    County VARCHAR(100),
    State VARCHAR(10),
    Zipcode VARCHAR(15),
    Timezone VARCHAR(50)
);

CREATE TABLE weather (
    Weather_ID INT PRIMARY KEY,
    Weather_Timestamp DATETIME,
    Temperature FLOAT,
    Humidity FLOAT,
    Pressure FLOAT,
    Visibility FLOAT,
    Wind_Direction VARCHAR(20),
    Wind_Speed FLOAT,
    Weather_Condition VARCHAR(100)
);


CREATE TABLE road (
    Road_ID INT PRIMARY KEY,
    Bump BOOLEAN,
    Crossing BOOLEAN,
    Junction BOOLEAN,
    Railway BOOLEAN,
    Roundabout BOOLEAN,
    Stop_Sign BOOLEAN,
    Traffic_Calming BOOLEAN,
    Traffic_Signal BOOLEAN
);

CREATE TABLE accidents (
    ID VARCHAR(20) PRIMARY KEY,
    Severity INT,
    Start_Time DATETIME,
    End_Time DATETIME,
    Distance FLOAT,
    Descriptions TEXT,
    Sunrise_Sunset VARCHAR(10),
    Location_ID INT,
    Weather_ID INT,
    Road_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES location(Location_ID),
    FOREIGN KEY (Weather_ID) REFERENCES weather(Weather_ID),
    FOREIGN KEY (Road_ID) REFERENCES road(Road_ID)
);