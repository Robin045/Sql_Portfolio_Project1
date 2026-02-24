-- TABLE CREATION:


create table retail_sales
    (
              transaction_id int primary key,
			  sale_date date,
			  sale_time time,
			  customer_id int,
			  gender varchar(7),
			  age int,
			  category varchar(15),
			  quantity int,
			  price_per_unit float,
			  cogs float,
			  total_sale float
			  );


-- Total records
Select * from retail_sales;
-- Total count of transactions 
Select count(*) from retail_sales;



-- DATA CLEANING:


Select * from retail_sales
where 
     transaction_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or 
	 category is null
	 or
	 quantity is null
	 or
	 price_per_unit is null
	 or 
	 cogs is null
	 or
	 total_sale is null;


Delete * from retail_sales
where 
     transaction_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or 
	 category is null
	 or
	 quantity is null
	 or
	 price_per_unit is null
	 or 
	 cogs is null
	 or
	 total_sale is null;




-- DATA EXPLORATION:


--Q1. How many unique customers do we have?
select distinct customer_id from retail_sales;

--Q2. What are unique categories do we have?
select distinct category from retail_sales;

--Q3. How many unique transactions do we have?
select distinct transaction_id from retail_sales;

--Q4. Total orders in each category
select category, count(quantity) from retail_sales
group by 1 order by 1;

--Q5. Total orders by each gender;
select gender, count(quantity) from retail_sales
group by 1;




-- DATA ANALYSIS & BUSINESS KEY PROBLEMS SOLVED:

--My Analysis & Findings

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.


--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the
-- quantity sold is equal to or more than 4 the month of Nov-2022.

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

--Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. 

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).





-- Q1. Specific Date Retrieval: Retrieve all columns for sales made on '2022-11-05'.
Select * from retail_sales 
where sale_date = '2022-11-05';

--Q2. Category & Quantity Filter: Retrieve all transactions where the category is 'Clothing', 
-- the quantity sold is equal to or more than 4, and the month is November 2022.
With Nov_22_sales as (Select *, extract('month' from sale_date)as month, 
extract('year' from sale_date)as year from retail_sales)
Select * from Nov_22_sales
where category = 'Clothing' and quantity >= 4
and month = 11 and year = 2022 ;

--Q3. Revenue by Category: Calculate the total sales (net sale) and total number of orders for each category.
Select category, sum(total_sale)as revenue, count(quantity)as No_of_orders
from retail_sales group by category;

--Q4. Customer Demographics: Find the average age of customers who purchased items from the 'Beauty' category.
Select round(avg(age),2)as average_age from retail_sales
where category = 'Beauty';

--Q5. High-Value Transactions: Find all transactions where the total sale amount is greater than 1,000.
select * from retail_sales
where total_sale > 1000;

--Q6. Gender Analysis: Find the total number of transactions (orders) made by each gender in each category.
select gender, category, count(quantity)as No_of_orders from retail_sales
group by 1, 2 order by 2;

--Q7. Best Selling Month: Calculate the average sale for each month and find the best-selling month in each year.
Select month, year, average_sale from( 
select avg(total_sale)as average_sale,
extract('month' from sale_date)as month, 
extract('year' from sale_date)as year from retail_sales
group by 2, 3 order by 1 desc)t
limit 2;

--Q8. Top Customers: Find the top 5 customers based on the highest total sales.
Select customer_id, sum(total_sale) from retail_sales
group by 1 order by 2 desc limit 5;

--Q9. Find the number of unique customers who purchased items from each category.
Select category, count(distinct customer_id) from retail_sales
group by category;

--Q10. Shift-based Analysis: Create shifts (Morning, Afternoon, Evening) and 
--calculate the number of orders for each shift. 
--Morning: <= 12:00
--Afternoon: Between 12:00 and 17:00
--Evening: > 17:00
select count(quantity)as No_of_orders, case
when extract('hour' from sale_time) < 12 then 'morning'
when extract('hour' from sale_time) between 12 and 17 then 'afternoon'
else 'evening' 
end as shift from retail_sales
group by 2 order by shift;

-- End of Project 