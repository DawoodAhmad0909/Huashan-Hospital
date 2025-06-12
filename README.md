# Huashan-Hospital
Objective: Analyze Patients' data
Database: Huashan_hospital_database

CREATE DATABASE Huashan_hospital_database;

Overview

This database is designed to help Huashan Hospital keep track of its patients and understand key trends in its patient population. It contains a single, detailed table called patients in which the data of each patient is stored.


Table: patients 

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

Key Queries 
1. What is the age distribution of our patients in 2025?  
'''sql
SELECT        FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)AS Age, COUNT(*) AS Number_of_patients FROM patients
WHERE date_of_birth IS NOT NULL
GROUP BY Age
ORDER BY Age;

2. Which insurance providers do most of our patients use?  

SELECT insurance_provider, COUNT(patient_id)AS Number_of_patients FROM patients
GROUP BY insurance_provider
ORDER BY Number_of_patients DESC;

3. How many patients registered each year leading up to 2025?  

SELECT YEAR(registration_date)AS YEAR, COUNT(*)AS Number_of_registrations FROM patients
WHERE registration_date<'2025-01-01'
GROUP BY YEAR;

4. What is the gender distribution across different age groups?  

SELECT CONCAT(FLOOR(DATEDIFF('2025-12-31',date_of_birth)/10/365.25)*10,'s')  AS Age_group,gender, COUNT(*) FROM patients
GROUP BY Age_group,gender
ORDER BY Age_group,gender;

5. How has patient registration grown month-over-month in 2025?  

SELECT MONTH(registration_date) AS MONTH, COUNT(*)AS Number_of_Registration FROM patients
WHERE registration_date>'2024-12-31'
GROUP BY MONTH;

6. Which cities do most of our patients come from?  

SELECT city, COUNT(*) AS Patients FROM patients
GROUP BY city
ORDER BY Patients DESC;

7. What is the average age of patients by insurance provider?  

SELECT insurance_provider, ROUND(AVG(DATEDIFF('2025-12-31',date_of_birth)/365.25),2) AS Average_age FROM patients
GROUP BY insurance_provider;

8. Which insurance providers have the highest percentage of elderly patients (65+)?  

SELECT insurance_provider, COUNT(CASE WHEN FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)>=65 THEN 1 END)*100/COUNT(*) AS Elderly_percentage FROM patients
GROUP BY  insurance_provider
ORDER BY Elderly_percentage DESC
LIMIT 2;

9. What is the distribution of insurance providers by patient gender? 

SELECT insurance_provider,gender,COUNT(*)AS TOTAL_PATIENTS FROM patients
GROUP BY insurance_provider,gender
ORDER BY TOTAL_PATIENTS,gender;

10. Which insurance providers have seen the most new registrations in 2025?  

SELECT insurance_provider, COUNT(YEAR(registration_date)) AS Registrations FROM patients
WHERE YEAR(registration_date)='2025'
GROUP BY insurance_provider
ORDER BY Registrations DESC
LIMIT 3;
 
11. How many patients have valid email addresses vs. only phone numbers?  

SELECT 
        SUM(CASE  WHEN email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$' THEN 1 ELSE 0 END) AS valid_email,
        SUM(CASE WHEN (email IS NULL OR NOT email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$') 
    AND phone IS NOT NULL THEN 1 ELSE 0 END) AS only_phone
    FROM patients;

12. Which zip codes are most common among our patients?  

SELECT zip_code, COUNT(*) AS Patients FROM patients
GROUP BY zip_code
ORDER BY Patients DESC
LIMIT 2;
13. What percentage of patients are from Boston vs. other cities?  

SELECT 
        SUM(CASE WHEN city='BOSTON' THEN 1 END) *100/COUNT(*) AS Boston_percentage,
        SUM(CASE WHEN city!='Boston' THEN 1 END)*100/COUNT(*) AS Other_cities_percentage
FROM patients;

14. How many patients registered in Q1 2025 vs. Q2 2025? 

SELECT COUNT(*) AS Patients,
        CASE 
                WHEN MONTH(registration_date)<=3 THEN 'First Quarter' 
                WHEN MONTH(registration_date) BETWEEN 4 AND 6 THEN 'Second Quarter'
        ELSE NULL
        END AS Quarter FROM patients
WHERE YEAR(registration_date)='2025' AND MONTH(registration_date) BETWEEN 1 AND 6
GROUP BY Quarter;

15. What is the breakdown of patients by decade of birth (e.g., 1970s, 1980s)?  

SELECT CONCAT(FLOOR(YEAR(date_of_birth)/10)*10,'s') AS Birth_Decade, COUNT(*) AS Patients FROM patients
GROUP BY Birth_Decade;

16. Which months see the highest patient registrations historically?

SELECT MONTH(registration_date) AS MONTH , COUNT(*) AS Total_patients FROM patients
GROUP BY MONTH
ORDER BY Total_patients DESC
LIMIT 2;

# 📊 Patient Database Queries (2025)

This document outlines key SQL queries used to analyze patient data from a healthcare database, focusing on demographics, insurance usage, registration trends, and contact analysis.

---

## 1. 📈 General Patient Demographics

### 1. Age distribution of patients in 2025
```sql
SELECT age(date_of_birth) AS age, COUNT(*) AS Number_of_patients 
FROM patients
WHERE date_of_birth IS NOT NULL
GROUP BY age
ORDER BY age;