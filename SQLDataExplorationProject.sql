use SuperMarket

--First, I created stored procedure so I can easily take a look back at the whole table while doing the work all the way down
create procedure SelectAll
as
select* 
from sm_sales

--The values in gross margin percentage is redundant so I decided to delete the column
Alter Table sm_sales
drop column [gross margin percentage]

--What city has the highest average rating?
select 
  city, 
  round (avg (rating), 2) as avg_rating 
from sm_sales
group by City
order by avg_rating desc

--Which city has the highest amount of sales
select city, SUM (total) as [Total Sales]
from sm_sales
group by city
order by [Total Sales]

--Which city has the highest quantity of sold items 
select city, SUM ([Quantity]) as [Total Quantity]
from sm_sales
group by city
order by [Total Quantity] desc


--What product line produce the highest amount of sales
select [product line], round (sum ( [total]),2) as [total sales]
from sm_sales
group by [product line]
order by [total sales] desc

--Which month has the highest revenue

select MONTH (date) as [Month Number], SUM ([total]) as [Monthly Total]
from sm_sales
group by MONTH (date)
order by SUM ([total]) desc


--Selecting all columns that has invoice ID ending in number 99
select *
from sm_sales
where [invoice id] like '%99'

--Change Gender Label
Select Gender, 
Case
When Gender ='Female' then 'F'
Else 'M'
End as [Sex]
From sm_sales

--Total Sales
select SUM([Total]) as [Total Sales]
from sm_sales

--count of payment method

select payment, COUNT ([payment]) as [Payment count]
from sm_sales
group by Payment

--select top 10 total purchase amount per city

select top 10 Total , [Product Line]
from sm_sales
order by [Total] desc

-- Which product line has the most revenue
select [Product Line], SUM(Total) as [Total per Product Line]
from sm_sales
group by [Product line]
order by Sum(Total)


--Example of adding and deleting a column
alter table sm_sales
add [Date of Birth] date

alter table sm_sales drop column [Date of Birth] 




--Create another table

create table customer_info 
(
ID int,
[First Name] varchar (255),
[Last Name] varchar (255),
Age int,
[Address] varchar (255)
)

alter table customer_info
alter column ID varchar (255)

--Adding data to new table

Insert into customer_info (ID, [First Name], [Last Name], Age,  [Address])
Values 
('123-19-1176','Jan', 'Carreon', '24', 'Malabon'),
('355-53-5943','Ash','Socuaji','22','Valenzuela'),
('351-62-0822','Robin','Salvador','25','Manila'),
('829-34-3910','Daryl','Laluna','42','Pasay'),
('765-26-6951','Tony','Malsi','35','Quezon City'),
('300-71-4605','Sheen','Osabel','51','Makati'),
('273-16-6619','Luis','Bautista','18','Caloocan'),
('649-29-6775','Alex','Ramirez','27','Quezon City'),
('871-79-8483','Eli','Lawas','62','Malabon'),
('232-16-2483','Dani','Bajilar','47','Valenzuela')

Select *
from customer_info

--Joining Table 
Select *
from sm_sales
full join customer_info
on sm_sales.[Invoice ID] = customer_info.ID
where ID is not null



--Creating View
Create View Customer_details
as
select ID, [First Name],[Last Name], Age,[Address], Gender, [Customer type], Payment
from sm_sales
join customer_info
on sm_sales.[Invoice ID] = customer_info.ID
where ID is not null

--Select created view
select * 
from Customer_details

--Select Customer details in Malabon, Valenzuela and Caloocan

Select *
from Customer_details
where [Address] in ('Malabon', 'Valenzuela','Caloocan')






