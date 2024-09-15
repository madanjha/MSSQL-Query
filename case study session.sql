use school
select * from Location 

1. Display the number of states present in the location table. 
select count(distinct state) from Location

2. Display the states in a sequnetial order 
select * from Location order by state

3. How many products are of regular type?
select * from Product
select count(distinct Product) from Product where Type = 'Regular'

select * from fact
4. How much spending(marketing) is done on product_id 1?
select sum(Marketing) from fact where ProductId = 1 

5. What is the minimum sales for product?
select min(sales) from fact

6. Display the details where total-expenses are greater than 40 
select * from fact where total_expenses > 40 

7. what is the avg sales in area code 719?
select avg(sales) from fact where area_code = 719

8. Find out the total sales in colarado state
select sum(sales) from fact 
join location on fact.area_code = location.area_code
where state = 'Colorado'

9. Display the average inventory for each productID.
select productid, avg(inventory) from fact 
group by productid 

10. Display the average budget of the product where the average budget-margin > 100
select avg(budget_margin) as avg from fact 
where budget_margin > 100

11. Display the max cost of goods sold . 
select max(COGS) from fact

12. Display the details of the product where product type is coffee.
select * from product where product_type = 'coffee'

13. what is the total sales done on date 2010-01-01?
select sum(sales) from fact 
where date = '2010-01-01'

14. Display the average total expenses of each product id on an individual date
select * from fact
select productid, date, avg(total_expenses) as avg from fact 
group by productid, date 
order by productid

15. Display a table with the following columns 
- date 
- productid
product_type
product
sales
profit
state
area_code
select date, fact.productid, product_type, product,sales, profit,  location.state, fact.area_code
from fact
join product on fact.productid = product.productid
join location on fact.area_code = location.area_code

16. Display the rank without the gap to show the sales 
select * , dense_rank() over(order by sales) as rank from fact

17. find the state-wise profit and sales
select state, sum(profit), sum(sales) from fact join location 
on location.Area_Code = fact.Area_Code group by state
