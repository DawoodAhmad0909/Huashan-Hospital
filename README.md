# Huashan-Hospital
Objective: Analyze Patients' data
Database: Huashan_hospital_database

Overview
This database is designed to help Huashan Hospital keep track of its patients and understand key trends in its patient population. It contains a single, detailed table called patients in which the data of each patient is stored.

Table: patients 


Key Queries 
1. What is the age distribution of our patients in 2025?  

SELECT FLOOR(DATEDIFF('2025-12-31',date_of_birth)/365.25)AS Age, COUNT(*) AS Number_of_patients FROM patients
WHERE date_of_birth IS NOT NULL
GROUP BY Age
ORDER BY Age;

2. Which insurance providers do most of our patients use?  



3. How many patients registered each year leading up to 2025?  



4. What is the gender distribution across different age groups?  



5. How has patient registration grown month-over-month in 2025?  



6. Which cities do most of our patients come from?  



7. What is the average age of patients by insurance provider?  



8. Which insurance providers have the highest percentage of elderly patients (65+)?  



9. What is the distribution of insurance providers by patient gender? 



10. Which insurance providers have seen the most new registrations in 2025?  


 
11. How many patients have valid email addresses vs. only phone numbers?  



12. Which zip codes are most common among our patients?  



13. What percentage of patients are from Boston vs. other cities?  



14. How many patients registered in Q1 2025 vs. Q2 2025? 


15. What is the breakdown of patients by decade of birth (e.g., 1970s, 1980s)?  



16. Which months see the highest patient registrations historically?
