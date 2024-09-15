1. Functions - set of statements which are there to perform a particular task.
2 types of functions - in- built , user defined functions 
in built - sql predefined 
user defined functions - we create for our use 

built in functions - 1. aggregate function , 2. string functions 
3. numerical functions 4. date and time functions 

aggregate functions - operate on a set of values and return a single value. 
sum , avg, max, min , count 
string functions - performed on string data types 
len , substring, upper, lower......
numerical functions - performed on numerical data types 
floor , ceiling, round 
date and time functions - perform on date data type 
getdate, datepart, datediff.... dateadd...  

user defined functions - 1. scalar   2. table 
scalar - return a single value 
table - return a table 

2. Case statements - for conditional logic 
case when then 

create table orders(orderId int primary key, amount decimal(4, 2))

insert into orders values(1, 150)
insert into orders values(2, 50)
insert into orders values(3, 1200)
insert into orders values(4, 200)
insert into orders values(5, 30)

1. use built-in function minimum, maximum, and average amount

select min(amount) as minamount, max(amount) as maxamount,
avg(amount) as avgamount from orders  yyyy-mm-dd 

2. create a user defined function to multiple a number by 10. 
create function dbo.multipleby10(@inputnumber int)
returns int 
as
begin 
return @inputnumber * 10;
end

select dbo.multipleby10(6)

3. use case and determine whether 100 is less than , greater than or equal to 200
select 
case 
when 100 > 200 then 'greater'
when 100 < 200 then 'smaller'
else 'equal'
end ;

4. use case statement and you need to categorize the amounts as medium , low and high

select amount, case
when amount > 1000 then 'high'
when amount < 500 then 'low'
else 'medium'
end as category
from orders

5. create a user defined table function that returns amount greater than a given input. 

create function dbo.greaterthan(@threshold int)
returns table 
as 
return (select * from orders 
where amount > @threshold);

select * from orders dense_rank() over(order by amount) as rank where rank = 2 

select * from dbo.greaterthan(500);

create function dbo.greaterthan1(@threshold int)returns tableasreturn (select * from orderswhere amount > @threshold);select * from dbo.greaterthan1(500);

1. order by -> to sort the results 
by default -> ascending 
2. set functions -> union and intersection 
union -> combined results from both the queries
union all -> allow duplicate values also
intersection -> common results only 
except -> return the results only from the first query which are not present in second query

1. arrange the amount in decreasing order
select * from orders 
order by amount desc

assume that you have new table employee(emp_id, emp_name, emp_salary)
another table employee2(emp-id, emp_name, empy_salary)
3. apply union operator for these two tables.
select * from employee 
union
select * from employee2 

4. apply intersection 
select * from employee 
intersect
select * from employee2 

5. apply except operator 

select * from employee 
except
select * from employee2 
select floor(4.5);
select decimal(4, 2)