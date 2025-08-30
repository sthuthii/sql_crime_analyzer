
-- DROP tables if they exist (for re-run safety)
DROP TABLE IF EXISTS Crime_Reports;
DROP TABLE IF EXISTS Crimes;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Officers;
DROP TABLE IF EXISTS Suspects;

-- Table: Locations
CREATE TABLE Locations (
    location_id INTEGER PRIMARY KEY,
    area_name TEXT,
    city TEXT,
    state TEXT
);

-- Table: Crimes
CREATE TABLE Crimes (
    crime_id INTEGER PRIMARY KEY,
    crime_type TEXT,
    description TEXT,
    date_reported DATE,
    status TEXT
);

-- Table: Officers
CREATE TABLE Officers (
    officer_id INTEGER PRIMARY KEY,
    name TEXT,
    rank TEXT,
    station TEXT
);

-- Table: Suspects
CREATE TABLE Suspects (
    suspect_id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    gender TEXT,
    last_known_location TEXT
);

-- Table: Crime_Reports
CREATE TABLE Crime_Reports (
    report_id INTEGER PRIMARY KEY,
    crime_id INTEGER,
    location_id INTEGER,
    officer_id INTEGER,
    suspect_id INTEGER,
    report_date DATE,
    FOREIGN KEY (crime_id) REFERENCES Crimes(crime_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (officer_id) REFERENCES Officers(officer_id),
    FOREIGN KEY (suspect_id) REFERENCES Suspects(suspect_id)
);

-- Sample Data for Locations
INSERT INTO Locations VALUES (1, 'MG Road', 'Bangalore', 'Karnataka');
INSERT INTO Locations VALUES (2, 'Connaught Place', 'Delhi', 'Delhi');
INSERT INTO Locations VALUES (3, 'Bandra', 'Mumbai', 'Maharashtra');
INSERT INTO Locations VALUES (4, 'Anna Nagar', 'Chennai', 'Tamil Nadu');

-- Sample Data for Crimes
INSERT INTO Crimes VALUES (1, 'Robbery', 'Armed robbery at jewelry shop', '2024-03-15', 'Open');
INSERT INTO Crimes VALUES (2, 'Assault', 'Physical altercation in a bar', '2024-02-10', 'Closed');
INSERT INTO Crimes VALUES (3, 'Murder', 'Homicide in residential area', '2024-01-05', 'Open');
INSERT INTO Crimes VALUES (4, 'Cybercrime', 'Phishing scam reported', '2024-06-01', 'Under Investigation');
INSERT INTO Crimes VALUES (5, 'Theft', 'Mobile phone stolen in bus', '2024-05-20', 'Closed');

-- Sample Data for Officers
INSERT INTO Officers VALUES (1, 'Aarav Mehta', 'Inspector', 'Bangalore Central');
INSERT INTO Officers VALUES (2, 'Neha Sharma', 'Sub-Inspector', 'Delhi South');
INSERT INTO Officers VALUES (3, 'Ravi Iyer', 'Head Constable', 'Mumbai East');

-- Sample Data for Suspects
INSERT INTO Suspects VALUES (1, 'Rohan Singh', 34, 'M', 'Mumbai');
INSERT INTO Suspects VALUES (2, 'Anita Desai', 28, 'F', 'Delhi');
INSERT INTO Suspects VALUES (3, 'Vikram Rao', 45, 'M', 'Chennai');

-- Sample Data for Crime_Reports
INSERT INTO Crime_Reports VALUES (1, 1, 1, 1, 1, '2024-03-15');
INSERT INTO Crime_Reports VALUES (2, 2, 2, 2, 2, '2024-02-10');
INSERT INTO Crime_Reports VALUES (3, 3, 3, 1, 3, '2024-01-05');
INSERT INTO Crime_Reports VALUES (4, 4, 2, 2, 1, '2024-06-01');
INSERT INTO Crime_Reports VALUES (5, 5, 1, 3, 2, '2024-05-20');
