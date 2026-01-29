---SQL Retail Sales Analysis - p1
create database sql_project_p2;

----create table----
create table retail_sales
			(
				transactions_id int primary key,
				sale_date date,
				sale_time time,
				customer_id int,
				gender varchar(15),
				age int,
				category varchar(15),
				quantiyb int,
				price_per_unit float,
				cogs float,
				toal_sale float
			);	


---Data Cleaning-----

select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or 
	gender is null
	or
	category is null
	or
	quantiyb is null
	or
	cogs is null
	or
	toal_sale is null;


delete from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or 
	gender is null
	or
	category is null
	or
	quantiyb is null
	or
	cogs is null
	or
	toal_sale is null;

select count(*) from retail_sales;


----Data Exploration----

---How many sales we have?--
select count(*) as total_sale from retail_sales;
----How many unique customers we have?----
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category from retail_sales;



---Data Analysis & Business Key Problem & Answers---

---Q1.write sql query to reterive all columns from sales made on '2022-11-05'----
select * from retail_sales 
where sale_date='2022-11-05';

---Q2.write sql query to reterive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov2022----
select 
*
from retail_sales
where category='Clothing'
and
	to_char(sale_date,'YYYY-MM')='2022-11'
	and
quantiyb>=4;
----Q3.Wrte a SQL query to calulate the total sales (total_sales) for eah category---
select
category,
sum(toal_sale) as net_sale
from 
retail_sales
group by 1;
----Q4.Write SQL query to find the average age of customers who purchased items from the 'Beauty'category----
select 
avg(age) from 
retail_sales
where category='Beauty';
----Q5.Write SQL query to find all transactions where the total_sale greater than 1000----
select 
*
from retail_sales
where toal_sale>1000;
----Q6.Write SqL query to find the total number of transactions(transaction_id) made by each gender in each category---
select category,
gender,
count(*) as total_trans
from retail_sales
group by 
category,
gender
order by 1;
---Q7 Write SQL query to calculate the average sale for each month.find out the best selling month in each year---
select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(toal_sale)as avg_sale
from retail_sales
group by 1,2
order by 1,2
----Q8.Write SQL query to find out the top 5 customers based on the highest total sales----
select
customer_id,
sum(toal_sale)as total_sales
from retail_sales 
group by 1
order by 2 desc
limit 5;
-----Q9.Write SQL query to find the number of unique customers who purchased items from each category----
select 
category,
  count(distinct customer_id)as cnt_unique_cs
from retail_sales
group by category;

---Q10.Write SQL query to create each shift and number of orders(example morning<=12 between 12 6 7 evening<17)---
with hourly_sale
as
(
select *,
 case
 when extract(hour from sale_time)<12 then 'morning'
 when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
 else'evening'
 end as shift
 from retail_sales
 )
 select 
 shift, count(*) as total_orders
 from
 hourly_sale
 group by shift
 
---- END OF THE PROJECT-----





				