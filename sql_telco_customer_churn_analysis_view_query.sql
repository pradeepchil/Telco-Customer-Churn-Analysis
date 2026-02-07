create view telcochustomerchurn_view as
(
select *,
case
	when tenure between 0 and 12 then 'New Customers'
	when tenure between 13 and 48 then 'Established Customers'
	when tenure >48 then 'Loyal Customers'
	end as Customer_segment,
case
	when MonthlyCharges between 0 and 75 then '0 to 75'
	when MonthlyCharges>75 and MonthlyCharges<=100 then '75 to 100'
	when MonthlyCharges>100 then 'Above 100'
	end 
	as monthlycharges_segmentation
from TelcoCustomerChurn)

select * from telcochustomerchurn_view