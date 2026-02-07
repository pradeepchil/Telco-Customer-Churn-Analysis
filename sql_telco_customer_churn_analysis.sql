select * from TelcoCustomerChurn

select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'TelcoCustomerChurn'
/*
customerID -> 7043
gender - 2 -> Male|Female
SeniorCitizen - 2 -> 0|1
Partner - 2 -> Yes|No
Dependents - 2 -> Yes|No
tenure - 73 -> 0to 72
PhoneService - 2 -> Yes|No
MultipleLines -- 3 -> Yes|No|No phone service
InternetService - 3 -> Fiber optic|DSL|No
OnlineSecurity - 3 -> Yes|No|No internet service
OnlineBackup - 3 -> Yes|No|No internet service
DeviceProtection - 3 -> Yes|No|No internet service
TechSupport - 3 -> Yes|No|No internet service
StreamingTV - 3 -> Yes|No|No internet service
StreamingMovies - 3 -> Yes|No|No internet service
Contract - 3 -> Month-to-month|One year|Two year
PaperlessBilling - 2 -> Yes|No
PaymentMethod - 4 -> Electronic check|Credit card (automatic)|Bank transfer (automatic)|Mailed check
MonthlyCharges - 1585 -> 18.25 to 118.75
TotalCharges - 6531 -> 18.8 to 8684.8
Churn - 2 Yes|No
*/
------------------

select
Distinct tenure
from
(
select
CAST(tenure as int) as tenure
from TelcoCustomerChurn )a
order by tenure

select
Distinct Churn
from TelcoCustomerChurn
order by TotalCharges


alter table TelcoCustomerChurn
alter column tenure int
--------------------------
--1.Total Customers
select
COUNT(Distinct customerID) as Total_Customers
from TelcoCustomerChurn
-----------------------
--2.Total Churn Customers
select
COUNT(Distinct customerID) as Total_Customers
from TelcoCustomerChurn
where Churn = 'Yes'
-------------------
--3.Total Retain Customers
select
COUNT(Distinct customerID) as Total_Customers
from TelcoCustomerChurn
where Churn = 'No'
------------------
--4.Total Churn and Retain Customer Proportion

select
CONCAT(ROUND(CAST(Churn_customers as float)/Total_Customers *100,2),'%') as Churn_Proportion,
CONCAT(ROUND(CAST(Retain_customers as float)/Total_Customers *100,2),'%') as Retain_Proportion
from
(
select
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn) a
---------------------------
--5.Total Customers By Gender
select
gender,
COUNT(Distinct customerID) as Total_Customers
from TelcoCustomerChurn
Group by gender
order by Total_Customers Desc
--------------------------------
--6.Total Churn Customers by Gender

select 
gender,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
gender,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by gender) a
order by Total_Churn_Customers Desc
--------------------------------------
--7.Total Churn Customers by SeniorCitizen

select 
SeniorCitizen,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
SeniorCitizen,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by SeniorCitizen) a
order by Total_Churn_Customers Desc
-----------------------------------
--8.Total Churn Customers by Partner

select 
Partner,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
Partner,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by Partner) a
order by Total_Churn_Customers Desc
-----------------------------------
--9.Total Churn Customers by Dependents

select 
Dependents,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
Dependents,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by Dependents) a
order by Total_Churn_Customers Desc
-------------------------------------
--10 Total Churn Customers by PhoneService

select 
PhoneService,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
PhoneService,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by PhoneService) a
order by Total_Churn_Customers Desc
-----------------------------------
--11. Total Churn Customers by MultipleLines

select 
MultipleLines,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
MultipleLines,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by MultipleLines) a
order by Total_Churn_Customers Desc
------------------------------------
--12. Total Churn Customers by InternetService

select 
InternetService,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
InternetService,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by InternetService) a
order by Total_Churn_Customers Desc
-----------------------------------
--13. Total Churn Customers by OnlineSecurity

select 
OnlineSecurity,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
OnlineSecurity,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by OnlineSecurity) a
order by Total_Churn_Customers Desc
-----------------------------------
--14.Total Churn Customers by OnlineBackup

select 
OnlineBackup,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
OnlineBackup,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by OnlineBackup) a
order by Total_Churn_Customers Desc
------------------------------------
--15.Total Churn Customers by DeviceProtection

select 
DeviceProtection,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
DeviceProtection,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by DeviceProtection) a
order by Total_Churn_Customers Desc
-----------------------------------
--16.Total Churn Customers by TechSupport

select 
TechSupport,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
TechSupport,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by TechSupport) a
order by Total_Churn_Customers Desc
-----------------------------------
--17.Total Churn Customers by StreamingTV

select 
StreamingTV,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
StreamingTV,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by StreamingTV) a
order by Total_Churn_Customers Desc
-----------------------------------
--18. Total Churn Customers by StreamingMovies

select 
StreamingMovies,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
StreamingMovies,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by StreamingMovies) a
order by Total_Churn_Customers Desc
-----------------------------------
--19.Total Churn Customers by Contract

select 
Contract,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
Contract,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by Contract) a
order by Total_Churn_Customers Desc
-----------------------------------
--20. Total Churn Customers by PaperlessBilling

select 
PaperlessBilling,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
PaperlessBilling,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by PaperlessBilling) a
order by Total_Churn_Customers Desc
-----------------------------------
--21.Total Churn Customers by PaymentMethod

select 
PaymentMethod,
Total_Customers,
Churn_customers,
SUM(Churn_customers) over() as Total_Churn_Customers,
CONCAT(ROUND(CAST(Churn_customers as float)/SUM(Churn_customers) over() *100,2),'%') as Churn_Proportion,
Retain_customers,
SUM(Retain_customers) over() as Total_Retain_Customers,
CONCAT(ROUND(CAST(Retain_customers as float)/SUM(Retain_customers) over() *100,2),'%') as Retain_Proportion
from
(
select
PaymentMethod,
COUNT(Distinct customerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers,
sum(case when churn ='No' then 1 else 0 end) as Retain_customers
from TelcoCustomerChurn
Group by PaymentMethod) a
order by Total_Churn_Customers Desc
------------------------------------
--22.tenure
select *,
sum(Total_Customers) over() as Total_Churn,
CONCAT(ROUND(CAST(Total_Customers as float)/SUM(Total_Customers) over() *100,2),'%') as Churn_Proportion
from
(
select
Customer_segment,
sum(Churn_customers) as Total_Customers
from
(
select
tenure,
case
	when tenure between 0 and 12 then 'New Customers'
	when tenure between 13 and 48 then 'Established Customers'
	when tenure >48 then 'Loyal Customers'
	end as Customer_segment,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers
from TelcoCustomerChurn
Group by tenure) a
Group by Customer_segment)b
order by Total_Customers Desc
-----------------------------------
select
Customer_segment,
COUNT(customerID) as Total_Customers,
SUM(Churn_customers) as Churn_Customer
from
(
select
customerID,
tenure,
case
	when tenure between 0 and 12 then 'New Customers'
	when tenure between 13 and 48 then 'Established Customers'
	when tenure >48 then 'Loyal Customers'
	end as Customer_segment,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers
from TelcoCustomerChurn
group by customerID,tenure) a
group by Customer_segment
order by Total_Customers Desc
----------------------------------------------------------











----------------
--MonthlyCharges

select *,
CONCAT(ROUND(CAST(Churn_customers as Float)/Total_Customers*100,2),'%') as Proportion
from
(
select
monthlycharges_segmentation,
COUNT(CustomerID) as Total_Customers,
sum(case when churn ='Yes' then 1 else 0 end) as Churn_customers
from
(
select
CustomerID,
case
	when MonthlyCharges between 0 and 75 then '0 to 75'
	when MonthlyCharges>75 and MonthlyCharges<=100 then '75 to 100'
	when MonthlyCharges>100 then 'Above 100'
	end 
	as monthlycharges_segmentation,
Churn
from TelcoCustomerChurn) a
group by monthlycharges_segmentation) b
