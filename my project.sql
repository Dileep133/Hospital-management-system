-- Create the Database
CREATE DATABASE IF NOT EXISTS HealthcareManagementSystem;
USE DATABASE HealthcareManagementSystem;

-- Create the Schema
CREATE SCHEMA IF NOT EXISTS HealthcareSchema;
USE SCHEMA HealthcareSchema;

-- Create Sequences
CREATE SEQUENCE IF NOT EXISTS PatientSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS DoctorSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS AppointmentSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS PrescriptionSeq START WITH 1 INCREMENT BY 1;

-- Create Patients Table
CREATE OR REPLACE TABLE Patients (
    PatientID INT DEFAULT PatientSeq.NEXTVAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    MedicalHistory TEXT
);

-- Create Doctors Table
CREATE OR REPLACE TABLE Doctors (
    DoctorID INT DEFAULT DoctorSeq.NEXTVAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    OfficeAddress VARCHAR(100)
);

-- Create Appointments Table
CREATE OR REPLACE TABLE Appointments (
    AppointmentID INT DEFAULT AppointmentSeq.NEXTVAL PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate TIMESTAMP,
    ReasonForVisit VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Prescriptions Table
CREATE OR REPLACE TABLE Prescriptions (
    PrescriptionID INT DEFAULT PrescriptionSeq.NEXTVAL PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Medication VARCHAR(100),
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Insert Sample Data into Patients Table
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, MedicalHistory)
VALUES ('John', 'Doe', '1980-05-15', 'Male', 'Vizag', '555-1234', 'john.doe@example.com', 'No known allergies');

-- Insert Sample Data into Doctors Table
INSERT INTO Doctors (FirstName, LastName, Specialty, PhoneNumber, Email, OfficeAddress)
VALUES ('Dr. Mike', 'Smith', 'Cardiology', '1234567891', 'mike.smith@example.com', 'town street');

-- Insert Sample Data into Appointments Table
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, ReasonForVisit, Status)
VALUES (1, 1, '2024-08-10 10:00:00', 'Routine Checkup', 'Scheduled');

-- Insert Sample Data into Prescriptions Table
INSERT INTO Prescriptions (PatientID, DoctorID, Medication, Dosage, Frequency, StartDate, EndDate, Notes)
VALUES (1, 1, 'Aspirin', '100mg', 'Once daily', '2024-08-10', '2024-08-20', 'Take after meals');

-- Query to Get All Patient Records
SELECT * FROM Patients;

-- Query to Get Appointments for a Specific Doctor
SELECT * FROM Appointments WHERE DoctorID = 1;

-- Query to Get Prescriptions for a Specific Patient
SELECT * FROM Prescriptions WHERE PatientID = 1;

-- Join Query: Patients with Appointments
SELECT Patients.FirstName, Patients.LastName, Appointments.AppointmentDate, Appointments.ReasonForVisit
FROM Patients
JOIN Appointments ON Patients.PatientID = Appointments.PatientID
WHERE Appointments.Status = 'Scheduled';

-- Join Query: Doctors with Prescriptions
SELECT Doctors.FirstName, Doctors.LastName, Prescriptions.Medication, Prescriptions.Dosage
FROM Doctors
JOIN Prescriptions ON Doctors.DoctorID = Prescriptions.DoctorID;
