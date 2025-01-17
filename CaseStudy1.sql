select * from fact;
select * from Location;
select * from Product;
--1. Display the number of states present in the LocationTable.
select count(distinct state) as num_of_state from Location;
--2. How many products are of regular type?
select count(distinct product) as num_of_product from product where Type='Regular';
--3. How much spending has been done on marketing of product ID 1?
select sum(Marketing) as marketingExpense  from fact where productId=1;
--4. What is the minimum sales of a product?
select product from product join fact on product.productId=fact.ProductId 
where fact.sales =(select min(sales) from fact); 
--5. Display the max Cost of Good Sold (COGS). 
select distinct product from product join fact on product.productId=fact.ProductId 
where fact.COGS =(select max(COGS) from fact); 
--6. Display the details of the product where product type is coffee.
select * from product where Product_Type='coffee';
--7. Display the details where total expenses are greater than 40. 
select * from fact where Total_Expenses>40;
--8. What is the average sales in area code 719?
select avg(sales) as avg_sales from fact where Area_Code=719; 
--9. Find out the total profit generated by Colorado state.
select sum(fact.Profit) as totalProfit from fact join Location on fact.Area_Code=Location.Area_Code where Location.State='Colorado';
--10. Display the average inventory for each product ID. 
select avg(inventory) as avg_inventory from fact group by ProductId;  
--11. Display state in a sequential order in a Location Table.
select distinct state from Location order by state;
--12. Display the average budget of the Product where the average budget
--margin should be greater than 100. 
select productid,avg(Budget_COGS) as avg_budget from fact group by productId having avg(Budget_margin) > 100;
--13. What is the total sales done on date 2010-01-01?
select sum(sales) from fact where date='2010-01-01';
--14. Display the average total expense of each product ID on an individual date.
select avg(total_expenses) as avg_totalExp,productid,date from fact group by ProductId,date;
--15. Display the table with the following attributes such as date, productID, 
--product_type, product, sales, profit, state, area_code. 
select fact.date,fact.productid,Product.Product_Type,Product.Product,fact.sales,fact.profit,Location.state,fact.Area_Code from fact 
join Product on Product.ProductId=fact.ProductId 
join Location on fact.Area_Code=Location.Area_Code;
--16. Display the rank without any gap to show the sales wise rank. 
select * from ( select *,dense_rank() over (order by sales asc) as rank from fact) as ranking;
--17. Find the state wise profit and sales. 
select Location.state,sum(fact.profit) as profit,sum(fact.sales) as sales from fact join Location on fact.Area_Code=Location.Area_Code
group by Location.state;
--18. Find the state wise profit and sales along with the productname.
select Location.state, sum(fact.profit) as profit,sum(fact.sales) as sales,Product.Product as productname from fact 
join Location on fact.Area_Code=Location.Area_Code join Product on fact.ProductId=Product.ProductId
group by Location.state,Product.Product;
--19. If there is an increase in sales of 5%, calculate the increasedsales. 
select sales, (Sales+sales*0.05) as increase_sales from fact; 
--20. Find the maximum profit along with the product ID and producttype. 
select  max(profit) as max_profit, Product.Product_Type,Product.ProductId from fact 
join Product on fact.ProductId=Product.ProductId group by Product.ProductId,Product_Type; 
--21. Create a stored procedure to fetch the result according to the product typefrom Product Table.
CREATE PROCEDURE Selectproducttype @producttype nvarchar(30)
AS
SELECT * FROM Product WHERE Product_Type = @producttype 
GO;
EXEC Selectproducttype @producttype = 'coffee';
select * from fact
--22. Write a query by creating a condition in which if the total expenses is lessthan60 then it is a profit or else loss. 
select  
CASE 
	when Total_Expenses < 60 then 'Profit'
	ELSE 'Loss'
	END as expense_category
from fact;

select Area_Code from Location
UNION
select Area_Code  from fact

--23. Give the total weekly sales value with the date and product IDdetails. Useroll-up to pull the data in hierarchical order. 
select sum(fact.Sales) as weekly_Sales, DATEPART(week, fact.Date) as weekly
from fact group by DATEPART(week, fact.Date) order by weekly
--24. Apply union and intersection operator on the tables which consist of
--attribute area code. 
select Area_Code from Location
UNION
select Area_Code  from fact
GO;
select Area_Code from Location
INTERSECT
select Area_Code  from fact

--25. Create a user-defined function for the product table to fetch a particular
--product type based upon the user�s preference.
create function Getproductype(@input tinyint)
returns table
as
RETURN(select Product_Type from Product where ProductId= @input);
select * from Getproductype(7)
--26. Change the product type from coffee to tea where product IDis 1 andundoit.
begin tran
select * from product where  ProductId=1
GO
update Product set Product_Type='Tea' where ProductId=1
GO
select * from product where  ProductId=1
Rollback
select * from product where  ProductId=1
--27. Display the date, product ID and sales where total expenses are
--between 100 to 200.
select date,productid,sales from fact where Total_Expenses between 100 and 200;
--28. Delete the records in the Product Table for regular type.
delete from product where Type='Regular';
--29. Display the ASCII value of the fifth character from the column Product.
select  ASCII(SUBSTRING(Product, 5, 10)) from Product;

