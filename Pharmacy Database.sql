

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Patients CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Orders CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Insurance CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Prescriptions CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Pharmacists CASCADE CONSTRAINTS';
EXECUTE IMMEDIATE 'DROP TABLE Medications CASCADE CONSTRAINTS';


-- Create tables
CREATE TABLE Medications (
MedicationID NUMBER PRIMARY KEY,
Amount NUMBER,
MedicineName VARCHAR(50)
);

CREATE TABLE Insurance (
InsuranceID NUMBER PRIMARY KEY,
InsuranceName VARCHAR(50),
AmountCovered NUMBER
);

CREATE TABLE Patients (
PatientID NUMBER PRIMARY KEY,
PatientName VARCHAR(50),
PatientAddress VARCHAR(255),
InsuranceID NUMBER,
CONSTRAINT fk_InsuranceID FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID)
);

CREATE TABLE Pharmacists (
PharmacistID NUMBER PRIMARY KEY,
PharmacistName VARCHAR(50),
PharmacistAddress VARCHAR(255)
);

CREATE TABLE Prescriptions (
PrescriptionID NUMBER PRIMARY KEY,
PrescriptionStatus VARCHAR(20) CHECK(PrescriptionStatus IN ('Filled', 'Unfilled')),
PatientID NUMBER,
PharmacistID NUMBER,
MedicationID NUMBER,
CONSTRAINT fk_MedicationID FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID),
CONSTRAINT fk_PatientID FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Orders (
OrderID NUMBER PRIMARY KEY,
OrderDate DATE,
OrderCost NUMBER,
OrderStatus VARCHAR(20) CHECK(OrderStatus IN ('Pending', 'Filled', 'Shipped', 'Delivered')),
PatientID NUMBER,
PrescriptionID NUMBER,
CONSTRAINT fk_PatID FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
CONSTRAINT fk_PrescriptionID FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID)
);

-- Insert data into tables
INSERT INTO Insurance (InsuranceID, InsuranceName, AmountCovered) VALUES (1, 'Kaiser', 100.00);
INSERT INTO Insurance (InsuranceID, InsuranceName, AmountCovered) VALUES (2, 'Cigna', 80.00);
INSERT INTO Insurance (InsuranceID, InsuranceName, AmountCovered) VALUES (3, 'Anthem', 60.00);

INSERT INTO Medications (MedicationID, Amount, MedicineName) VALUES (1, 1000, 'Ibuprofen');
INSERT INTO Medications (MedicationID, Amount, MedicineName) VALUES (2, 600, 'Insulin');
INSERT INTO Medications (MedicationID, Amount, MedicineName) VALUES (3, 800, 'Lipitor');
INSERT INTO Medications (MedicationID, Amount, MedicineName) VALUES (4, 500, 'Zoloft');
INSERT INTO Medications (MedicationID, Amount, MedicineName) VALUES (5, 1200, 'Adderall');

INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID) VALUES (1, 'John Smith', '12 Main Street', 2);
INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID) VALUES (2, 'Jane Doe', '1234 Cedar Road', 1);
INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID) VALUES (3, 'Tom Brown', '36 Maple Lane', 2);
INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID) VALUES (4, 'Dave Johnson', '104 Oasis Street', 3);
INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID) VALUES (5, 'Samantha Green', '7501 Redwood Avenue', 1);

INSERT INTO Pharmacists (PharmacistID, PharmacistName, PharmacistAddress) VALUES (1, 'Mary Sue', '13 Pine Court');
INSERT INTO Pharmacists (PharmacistID, PharmacistName, PharmacistAddress) VALUES (2, 'Jack Jones', '1502 Cherry Hill Road');
INSERT INTO Pharmacists (PharmacistID, PharmacistName, PharmacistAddress) VALUES (3, 'Sarah Parker', '110 New Cut Road');

INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (1, 'Filled', 3, 1, 4);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (2, 'Filled', 2, 2, 1);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (3, 'Unfilled', 4, 3, 3);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (4, 'Filled', 1, 2, 2);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (5, 'Unfilled', 5, 1, 2);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (6, 'Unfilled', 1, 2, 3);
INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID) VALUES (7, 'Unfilled', 3, 3, 5);

INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (1, TO_DATE('2024-11-21', 'YYYY-MM-DD'), 100, 'Delivered', 1, 4);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (2, TO_DATE('2024-11-30', 'YYYY-MM-DD'), 50, 'Shipped', 1, 6);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (3, TO_DATE('2024-10-19', 'YYYY-MM-DD'), 80, 'Delivered', 3, 1);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (4, TO_DATE('2024-12-08', 'YYYY-MM-DD'), 75, 'Pending', 3, 7);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (5, TO_DATE('2024-12-06', 'YYYY-MM-DD'), 120, 'Pending', 2, 2);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (6, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 55, 'Filled', 4, 3);
INSERT INTO Orders (OrderID, OrderDate, OrderCost, OrderStatus, PatientID, PrescriptionID) VALUES (7, TO_DATE('2024-11-27', 'YYYY-MM-DD'), 90, 'Shipped', 5, 5);

-- Functionalities

-- Insert
INSERT INTO Patients (PatientID, PatientName, PatientAddress, InsuranceID)
VALUES (6, 'Dan Cooper', '313 Kennedy Street', 3);

INSERT INTO Prescriptions (PrescriptionID, PrescriptionStatus, PatientID, PharmacistID, MedicationID)
VALUES (8, 'Unfilled', 6, 1, 2);

-- Update
UPDATE Prescriptions
SET PrescriptionStatus = 'Filled'
WHERE PrescriptionId = 3;

-- Find number of orders per patient
SELECT
pa.PatientName,
COUNT(o.OrderID)
FROM
Patients pa
INNER JOIN
Orders o ON pa.PatientID = o.PatientID
GROUP BY
pa.PatientName;

-- Show
SELECT
ph.PharmacistName,
p.PrescriptionID,
p.PrescriptionStatus
FROM
Pharmacists ph
INNER JOIN
Prescriptions p ON ph.PharmacistID = p.PharmacistID
ORDER BY
ph.PharmacistID ASC;


-- Find unfilled prescriptions
SELECT
PrescriptionID
FROM
Prescriptions
WHERE
PrescriptionStatus = 'Unfilled';

-- Find orders that have shipped
SELECT
OrderID
FROM
Orders
WHERE
OrderStatus = 'Shipped';

-- Find all prescriptions assigned to a pharmacist
SELECT
ph.PharmacistName,
p.PrescriptionID,
p.PrescriptionStatus
FROM
Pharmacists ph
INNER JOIN
Prescriptions p ON ph.PharmacistID = p.PharmacistID
ORDER BY
PharmacistID ASC;

-- Find total prescriptions filled by each pharmacist
SELECT
ph.PharmacistName,
COUNT(p.PrescriptionID) AS TotalPrescriptions
FROM
Pharmacists ph
INNER JOIN
Prescriptions p ON ph.PharmacistID = p.PharmacistID
GROUP BY
ph.PharmacistName;

-- Find total number of orders placed by each patient
SELECT
    pa.PatientName,
    COUNT(o.OrderID)
FROM
    Patients pa
INNER JOIN
    Orders o ON pa.PatientID = o.PatientID
GROUP BY
    pa.PatientName; -- update of the code it had some errors from spelling