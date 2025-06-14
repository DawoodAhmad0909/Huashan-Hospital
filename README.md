# Huashan Hospital Shanghai
## Database:
  #### Huashan_hospital_database
```sql
CREATE DATABASE Huashan_hospital_database;
```
## Objectives:
   #### Analyze Patients' data 
   #### Analyze Demographics
   #### Track Registration Trends
   #### Evaluate Insurance Provider Impact
   #### Assess Geographic Reach
   
## Overview

This database is designed to help Huashan Hospital keep track of its patients and understand key trends in its patient population. It contains a single, detailed table called patients in which the data of each patient is stored.


## Table: patients 
```sql
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
```
## Key Queries 
### 1.Write a query to find the age distribution of our patients in 2025? 
 ```sql
SELECT        FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)AS Age, COUNT(*) AS Number_of_patients FROM patients
WHERE date_of_birth IS NOT NULL
GROUP BY Age
ORDER BY Age;
```
### 2.Write a query to find which insurance providers do most of our patients use?  
```sql
SELECT insurance_provider, COUNT(patient_id)AS Number_of_patients FROM patients
GROUP BY insurance_provider
ORDER BY Number_of_patients DESC;
```
### 3.Write a query to find how many patients registered each year leading up to 2025?  
```sql
SELECT YEAR(registration_date)AS YEAR, COUNT(*)AS Number_of_registrations FROM patients
WHERE registration_date<'2025-01-01'
GROUP BY YEAR;
```
### 4.Write a query to find the gender distribution across different age groups?  
```sql
SELECT CONCAT(FLOOR(DATEDIFF('2025-12-31',date_of_birth)/10/365.25)*10,'s')  AS Age_group,gender, COUNT(*) FROM patients
GROUP BY Age_group,gender
ORDER BY Age_group,gender;
```
### 5.Write a query to find how has patient registration grown month-over-month in 2025?  
```sql
SELECT MONTH(registration_date) AS MONTH, COUNT(*)AS Number_of_Registration FROM patients
WHERE registration_date>'2024-12-31'
GROUP BY MONTH;
```
### 6.Write a query to find which cities do most of our patients come from?  
```sql
SELECT city, COUNT(*) AS Patients FROM patients
GROUP BY city
ORDER BY Patients DESC;
```
### 7.Write a query to find the average age of patients by insurance provider?  
```sql
SELECT insurance_provider, ROUND(AVG(DATEDIFF('2025-12-31',date_of_birth)/365.25),2) AS Average_age FROM patients
GROUP BY insurance_provider;
```
### 8.Write a query to find which insurance providers have the highest percentage of elderly patients (65+)?  
```sql
SELECT insurance_provider, COUNT(CASE WHEN FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)>=65 THEN 1 END)*100/COUNT(*) AS Elderly_percentage FROM patients
GROUP BY  insurance_provider
ORDER BY Elderly_percentage DESC
LIMIT 2;
```
### 9.Write a query to find the distribution of insurance providers by patient gender? 
```sql
SELECT insurance_provider,gender,COUNT(*)AS TOTAL_PATIENTS FROM patients
GROUP BY insurance_provider,gender
ORDER BY TOTAL_PATIENTS,gender;
```
### 10.Write a query to find which insurance providers have seen the most new registrations in 2025?  
```sql
SELECT insurance_provider, COUNT(YEAR(registration_date)) AS Registrations FROM patients
WHERE YEAR(registration_date)='2025'
GROUP BY insurance_provider
ORDER BY Registrations DESC
LIMIT 3;
 ```
### 11.Write a query to find how many patients have valid email addresses vs. only phone numbers?  
```sql
SELECT 
        SUM(CASE  WHEN email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$' THEN 1 ELSE 0 END) AS valid_email,
        SUM(CASE WHEN (email IS NULL OR NOT email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._]+\.[A-Za-z]{2}$') 
    AND phone IS NOT NULL THEN 1 ELSE 0 END) AS only_phone
    FROM patients;
```
### 12.Write a query to find which zip codes are most common among our patients?  
```sql
SELECT zip_code, COUNT(*) AS Patients FROM patients
GROUP BY zip_code
ORDER BY Patients DESC
LIMIT 2;
```
### 13.Write a query to find the percentage of patients are from Boston vs. other cities?  
```sql
SELECT 
        SUM(CASE WHEN city='BOSTON' THEN 1 END) *100/COUNT(*) AS Boston_percentage,
        SUM(CASE WHEN city!='Boston' THEN 1 END)*100/COUNT(*) AS Other_cities_percentage
FROM patients;
```
### 14.Write a query to find how many patients registered in Q1 2025 vs. Q2 2025? 
```sql
SELECT COUNT(*) AS Patients,
        CASE 
                WHEN MONTH(registration_date)<=3 THEN 'First Quarter' 
                WHEN MONTH(registration_date) BETWEEN 4 AND 6 THEN 'Second Quarter'
        ELSE NULL
        END AS Quarter FROM patients
WHERE YEAR(registration_date)='2025' AND MONTH(registration_date) BETWEEN 1 AND 6
GROUP BY Quarter;
```
### 15.Write a query which gives the breakdown of patients by decade of birth (e.g., 1970s, 1980s)?  
```sql
SELECT CONCAT(FLOOR(YEAR(date_of_birth)/10)*10,'s') AS Birth_Decade, COUNT(*) AS Patients FROM patients
GROUP BY Birth_Decade;
```
### 16.Write a query to find which months see the highest patient registrations historically?
```sql
SELECT MONTH(registration_date) AS MONTH , COUNT(*) AS Total_patients FROM patients
GROUP BY MONTH
ORDER BY Total_patients DESC
LIMIT 2;
```
