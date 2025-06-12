CREATE DATABASE Huashan_hospital_database;
USE Huashan_hospital_database;

CREATE TABLE patients(
	patient_id INT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    date_of_birth DATE,
    gender VARCHAR(5),
    address VARCHAR(100),
    city VARCHAR(20),
    state VARCHAR(20),
    zip_code INT,
    phone BIGINT UNIQUE,
    email VARCHAR(50) UNIQUE,
    insurance_provider VARCHAR(25),
    registration_date DATE 
);

INSERT INTO patients VALUES 
	(1,'John','Smith','1985-03-15','M','123 Main St','Boston','MA',02108,6175550101,'john.smith@email.com','BlueCross','2025-01-10'),
    (2,'Mary','Johnson','1972-07-22','F','456 Oak Ave','Cambridge','MA',02139,6175550202,'mary.j@email.com','Aetna','2024-05-15'),
	(3,'Robert','Williams','1990-11-30','M','789 Pine Rd','Somerville','MA',02143,6175550303,'rob.williams@email.com','Medicare','2025-02-20'),
	(4,'Jennifer','Brown','1982-09-05','F','321 Elm St','Quincy','MA',02169,6175550404,'jbrown82@email.com','UnitedHealth','2023-11-03'),
	(5,'Micheal','Davis','1975-12-18','M','654 Maple Dr','Boston','MA',02115,6175550505,'micheal.d@email.com','BlueCross','2025-07-22'),
	(6,'Sarah','Miller','1988-04-25','F','987 Cedar Ln','Brookline','MA',02445,6175550606,'sarah.miller@email.com','Tufts Health','2025-03-18'),
	(7,'David','Wilson','1965-08-12','M','135 Birch Blvd','Boston','MA',02458,6175550707,'david.wilson@email.com','Medicare','2022-09-09'),
	(8,'Lisa','Moore','1993-01-07','F','246 Walnut St','Newton','MA',02458,6175550808,'lisa.moore@email.com','Aetna','2025-01-05'),
	(9,'James','Taylor','1978-06-19','M','369 Spruce Ave','Boston','MA',02118,6175550909,'james.t@email.com','UnitedHealth','2024-08-14'),
	(10,'Emily','Anderson','1980-10-31','F','159 Aspen Way','Cambridge','MA',02140,6175551010,'emily.anderson@email.com','BlueCRoss','2025-04-30'),
	(11,'Daniel','Thomas','1995-02-14','M','753 Redwood Dr','Somerville','MA',02144,6175551111,'dan.thomas@email.com','Medicaid','2025-11-22'),
	(12,'Jessica','Jackson','1970-05-27','F','852 Willow Ln','Boston','MA',02114,6175551212,'jess.jackson@email.com','Medicare','2023-06-17'),
    (13,'Matthew','White','1987-07-08','M','963 Sycamore Rd','Quincy','MA',02170,6175551313,'matt.white@email.com','Aetna','2025-09-25'),
	(14,'Amanda','Harris','1991-12-03','F','147 Magnolia St','Boston','MA',02128,6175551414,'amanda.h@email.com','Tufts Health','2025-07-11'),
	(15,'Christopher','Martin','1968-09-21','M','258 Dogwood Ave','Brookline','MA',02446,6175551515,'chris.martin@email.com','Medicare','2024-04-05');


SELECT FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)AS Age, COUNT(*) AS Number_of_patients FROM patients
WHERE date_of_birth IS NOT NULL
GROUP BY Age
ORDER BY Age;

SELECT insurance_provider, COUNT(patient_id)AS Number_of_patients FROM patients
GROUP BY insurance_provider
ORDER BY Number_of_patients DESC;

SELECT YEAR(registration_date)AS YEAR, COUNT(*)AS Number_of_registrations FROM patients
WHERE registration_date<'2025-01-01'
GROUP BY YEAR;

SELECT CONCAT(FLOOR(DATEDIFF('2025-12-31',date_of_birth)/10/365.25)*10,'s')  AS Age_group,gender, COUNT(*) FROM patients
GROUP BY Age_group,gender
ORDER BY Age_group,gender;

SELECT MONTH(registration_date) AS MONTH, COUNT(*)AS Number_of_Registration FROM patients
WHERE registration_date>'2024-12-31'
GROUP BY MONTH;

SELECT city, COUNT(*) AS Patients FROM patients
GROUP BY city
ORDER BY Patients DESC;

SELECT insurance_provider, ROUND(AVG(DATEDIFF('2025-12-31',date_of_birth)/365.25),2) AS Average_age FROM patients
GROUP BY insurance_provider;

SELECT insurance_provider, COUNT(CASE WHEN FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)>=65 THEN 1 END)*100/COUNT(*) AS Elderly_percentage FROM patients
GROUP BY  insurance_provider
ORDER BY Elderly_percentage DESC
LIMIT 2;

SELECT insurance_provider,gender,COUNT(*)AS TOTAL_PATIENTS FROM patients
GROUP BY insurance_provider,gender
ORDER BY TOTAL_PATIENTS,gender;

SELECT insurance_provider, COUNT(YEAR(registration_date)) AS Registrations FROM patients
WHERE YEAR(registration_date)='2025'
GROUP BY insurance_provider
ORDER BY Registrations DESC
LIMIT 3;

SELECT 
	SUM(CASE  WHEN email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$' THEN 1 ELSE 0 END) AS valid_email,
	SUM(CASE WHEN (email IS NULL OR NOT email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$') 
    AND phone IS NOT NULL THEN 1 ELSE 0 END) AS only_phone
    FROM patients;

SELECT zip_code, COUNT(*) AS Patients FROM patients
GROUP BY zip_code
ORDER BY Patients DESC
LIMIT 2;

SELECT 
	SUM(CASE WHEN city='BOSTON' THEN 1 END) *100/COUNT(*) AS Boston_percentage,
	SUM(CASE WHEN city!='Boston' THEN 1 END)*100/COUNT(*) AS Other_cities_percentage
FROM patients;

SELECT COUNT(*) AS Patients,
	CASE 
		WHEN MONTH(registration_date)<=3 THEN 'First Quarter' 
		WHEN MONTH(registration_date) BETWEEN 4 AND 6 THEN 'Second Quarter'
        ELSE NULL
	END AS Quarter FROM patients
WHERE YEAR(registration_date)='2025' AND MONTH(registration_date) BETWEEN 1 AND 6
GROUP BY Quarter;

SELECT CONCAT(FLOOR(YEAR(date_of_birth)/10)*10,'s') AS Birth_Decade, COUNT(*) AS Patients FROM patients
GROUP BY Birth_Decade;
    
SELECT MONTH(registration_date) AS MONTH , COUNT(*) AS Total_patients FROM patients
GROUP BY MONTH
ORDER BY Total_patients DESC
LIMIT 2;