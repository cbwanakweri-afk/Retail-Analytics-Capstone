-- Create a database named retail_data with the create database statement 
create database IF NOT exists retail_data;

-- seting as default database
USE retail_data;

-- Creating the marketing_campaign table 
CREATE TABLE marketing_campaign (
ID INT primary key,
Year_Birth INT,
Education VARCHAR(50),
Marital_Status VARCHAR(50),
Income DECIMAL(10,2),
Kidhome INT,
Teenhome INT,
Dt_Customer DATETIME,
Recency INT,
MntWines INT,
MntFruits INT,
MntMeatProducts INT,
MntFishProducts INT,
MntSweetProducts INT,
MntGoldProds INT,
NumDealsPurchases INT,
NumWebPurchases INT,
NumCatalogPurchases INT,
NumStorePurchases INT,
NumWebVisitsMonth INT,
AcceptedCmp1 INT,
AcceptedCmp2 INT,
AcceptedCmp3 INT,
AcceptedCmp4 INT,
AcceptedCmp5 INT,
Response INT
);

-- Loading data into the database by going to Table Data Import Wizard, 
-- selecting the CSV file and choosing the Create New Table and letting MYSQL auto-create the table.

select *
from marketing_campaign;

-- Calculating the total number of customer encounters in the marketing campaign dataset
Select count(*)
from marketing_campaign;

-- Identifing the top 10 most purchased products in the dataset
SELECT SUM(MntWines) AS Total_Wines, 
SUM(MntMeatProducts) AS Total_Meat, 
SUM(MntFruits) AS Total_Fruits, 
SUM(MntFishProducts) AS Total_Fish, 
SUM(MntSweetProducts) AS Total_Sweets,
SUM(MntGoldProds) AS Total_Gold
FROM marketing_campaign;

-- Finding  the count of response values
SELECT Response, COUNT(*)
FROM marketing_campaign
GROUP BY Response;

-- Determining the distribution of customers based on their education level and marital status
Select Education, Marital_Status, count(*)
FROM marketing_campaign
group by Education, Marital_Status
order by count(*) desc;

-- Identifying the average income of customers who participated in the marketing campaign
Select avg(income) as avg_income_participants
FROM marketing_campaign
Where Response = 1;

-- Calculating the total number of promotions accepted by customers in each campaign
SELECT SUM(AcceptedCmp1) AS Campaign1,
SUM(AcceptedCmp2) AS Campaign2,
SUM(AcceptedCmp3) AS Campaign3,
SUM(AcceptedCmp4) AS Campaign4,
SUM(AcceptedCmp5) AS Campaign5
FROM marketing_campaign;

-- Identifying the distribution of customers' responses to the last campaign
Select AcceptedCmp5, count(*)
from marketing_campaign
GROUP BY AcceptedCmp5;

-- Calculating the average number of children and teenagers in customers' households
select avg(Kidhome), avg(Teenhome)
from marketing_campaign;

-- Creating an Age column by subtracting year_birth from the current year 
-- Creating the age column 
ALTER TABLE marketing_campaign
ADD Age INT;
-- Updating the age column 
UPDATE marketing_campaign
SET Age = YEAR(CURDATE()) - Year_Birth
WHERE ID IS NOT NULL;

-- Creating Age_group columns 
ALTER TABLE marketing_campaign ADD Age_group VARCHAR(20);
-- Updating the the age_group with conditions
UPDATE marketing_campaign
SET Age_group = CASE
WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
ELSE '56+'
END;

-- Determining the average number of visits per month for customers in each age group
Select Age_group, avg(NumWebVisitsMonth)
from marketing_campaign
group by Age_group
order by avg(NumWebVisitsMonth) desc;

-- Project Findings Summary
-- So overall, I found that Wines and Meat Products were the top-performing categories based on total purchases. Those clearly stood out compared to the other product groups. 
-- When I looked at campaign responses, most customers didn’t accept the offer, but there was still a noticeable group that did, which made it interesting to compare their behavior.
-- The demographic breakdown showed patterns across education levels and marital status, so you can see which groups are more represented in the dataset.
-- I also noticed some differences in income and age when comparing engagement levels, especially when I grouped customers by age and looked at their average visits.
-- Overall, the data helped me understand purchasing trends, customer behavior, and how effective the marketing campaigns were.



