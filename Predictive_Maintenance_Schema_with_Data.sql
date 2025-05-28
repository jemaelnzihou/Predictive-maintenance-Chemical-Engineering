
-- Database: Predictive_Maintenance

CREATE DATABASE IF NOT EXISTS Predictive_Maintenance;
USE Predictive_Maintenance;

-- Table: Assets
CREATE TABLE Assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_name VARCHAR(100),
    asset_type VARCHAR(50),
    manufacturer VARCHAR(100),
    install_date DATE
);

-- Table: Sensors
CREATE TABLE Sensors (
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_type VARCHAR(50),
    unit VARCHAR(20),
    location VARCHAR(100)
);

-- Table: Sensor_Readings
CREATE TABLE Sensor_Readings (
    reading_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT,
    asset_id INT,
    timestamp DATETIME,
    value DECIMAL(10, 2),
    FOREIGN KEY (sensor_id) REFERENCES Sensors(sensor_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

-- Table: Maintenance_Logs
CREATE TABLE Maintenance_Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT,
    maintenance_type VARCHAR(50),
    downtime_hrs DECIMAL(5, 2),
    performed_by INT,
    date DATE,
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

-- Table: Technicians
CREATE TABLE Technicians (
    tech_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    certification VARCHAR(100),
    assigned_zone VARCHAR(50)
);

-- Table: Failure_Events
CREATE TABLE Failure_Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT,
    failure_cause TEXT,
    failure_type VARCHAR(100),
    failure_date DATE,
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

-- Add foreign key to Maintenance_Logs
ALTER TABLE Maintenance_Logs
ADD CONSTRAINT fk_maintenance_technician FOREIGN KEY (performed_by) REFERENCES Technicians(tech_id) ON DELETE CASCADE;

-- Insert sample data
INSERT INTO Technicians (name, certification, assigned_zone) VALUES
('Alex Morgan', 'Certified Reliability Engineer', 'Zone A'),
('Jamie Rivera', 'Industrial Maintenance Specialist', 'Zone B'),
('Taylor Chen', 'Lean Six Sigma Black Belt', 'Zone C');

INSERT INTO Assets (asset_name, asset_type, manufacturer, install_date) VALUES
('Pump A01', 'Centrifugal Pump', 'GE Power', '2021-06-15'),
('Valve V09', 'Control Valve', 'Emerson', '2020-03-10'),
('Boiler B12', 'Steam Boiler', 'Siemens', '2019-12-01');

INSERT INTO Sensors (sensor_type, unit, location) VALUES
('Vibration', 'mm/s', 'Plant Floor A'),
('Temperature', '°C', 'Plant Floor B'),
('Pressure', 'bar', 'Boiler Room');

INSERT INTO Sensor_Readings (sensor_id, asset_id, timestamp, value) VALUES
(1, 1, '2025-05-27 08:00:00', 3.4),
(2, 2, '2025-05-27 08:05:00', 78.6),
(3, 3, '2025-05-27 08:10:00', 6.1),
(1, 1, '2025-05-27 09:00:00', 3.6),
(2, 2, '2025-05-27 09:05:00', 79.2);

INSERT INTO Maintenance_Logs (asset_id, maintenance_type, downtime_hrs, performed_by, date) VALUES
(1, 'Preventive', 2.5, 1, '2025-05-25'),
(2, 'Corrective', 4.0, 2, '2025-05-26'),
(3, 'Inspection', 1.2, 3, '2025-05-24');

INSERT INTO Failure_Events (asset_id, failure_cause, failure_type, failure_date) VALUES
(1, 'Bearing wear-out', 'Mechanical', '2025-05-15'),
(2, 'Sensor short circuit', 'Electrical', '2025-05-20'),
(3, 'Overpressure', 'Safety Triggered Shutdown', '2025-05-22');
