/****** 
Q1: 1.	Which departments in which states had 
the highest total payroll (gross pay) costs in 2018? 
List only top 10 
******/

SELECT top(10) d.department, a.state, sum(p.gross_pay) total_pay
FROM [MergerProject].[dbo].[employee_info] e
join [MergerProject].[dbo].[addresses] a 
on a.address_id = e.address_id
join [MergerProject].[dbo].[departments] d
on d.department_id = e.department_id
join [MergerProject].[dbo].[payroll_register] p
on p.employee_id = e.employee_id
where p.period like '%2018%'
group by d.department, a.state
order by sum(p.gross_pay) desc;


/****** 
Q2: Management has asked that you produce a report that shows all accounting department employees 
grouped by state, with the employee_id, last name, first name, total gross salary. 
This report should be in alphabetical order from A – Z. 
INDICATE HOW MANY ROWS OF DATA DOES YOUR TABLE HAVE. 
******/

SELECT e.employee_id, e.first_name, e.last_name, a.state, sum(p.gross_pay) total_gross_salary
FROM [MergerProject].[dbo].[employee_info] e
join [MergerProject].[dbo].[addresses] a 
on a.address_id = e.address_id
join [MergerProject].[dbo].[departments] d
on d.department_id = e.department_id
join [MergerProject].[dbo].[payroll_register] p
on p.employee_id = e.employee_id
where d.department = 'accounting'
group by e.employee_id, e.first_name, e.last_name, a.state
order by e.first_name, e.last_name;
/*ANSWER: 400 ROWS*/


/****** 
Q3: Smart-Buy wants to understand how many periods their seasonal workers 
worked during the busy season (4th quarter of 2017) and what was their total pay. 
In your output provide Employee ID, Last Name, total pay for each employee, number of periods.  
Order by total gross pay.  
******/

SELECT e.employee_id, e.last_name, sum(p.gross_pay) total_gross_salary, count(c.num_of_working_hours) no_of_periods
FROM [MergerProject].[dbo].[employee_info] e
join [MergerProject].[dbo].[payroll_register] p
on p.employee_id = e.employee_id
join [MergerProject].[dbo].[calendar] c
on c.period = p.period
where c.year_quarter = '2017-Q4' and e.employment_type = 'seasonal'
group by e.employee_id, e.last_name
order by sum(p.gross_pay) desc;


/****** 
Q4: If smart-buy wants to relocate headquarters, where should they do this? 
HINT: It is easier to use at least 2 queries to answer this question.  
Take into consideration where the employees associated with headquarters 
(for example: accountants, IT workers, executives, and possibly others) currently live.  
Also consider the location of our most lucrative stores.  
******/

---------------------SUBQUERY METHOD--------------------
SELECT Employee_Details.city, Employee_Details.state, 
		sum(Employee_Details.num_of_employees) Num_of_Employees, 
		sum(num_of_stores) Num_of_Stores, 
		sum(store_revenue) Revenue_Generated
FROM (SELECT  a.city, a.state, count(e.employee_id) num_of_employees
FROM [MergerProject].[dbo].[employee_info] e
join [MergerProject].[dbo].[addresses] a 
on a.address_id = e.address_id
join [MergerProject].[dbo].[departments] d
on d.department_id = e.department_id
where e.role not in ('sales_person','maintenance_worker', 'cashier','sales', 'delivery_driver',
					'district_manager', 'supervisor','stocker', 'picker','greeter', 'packer', 'loader', 'buyer')
group by a.city, a.state)Employee_Details
join
(SELECT s.city, s.state, count(s.store_id) num_of_stores, sum(r.store_revenue) store_revenue
FROM [MergerProject].[dbo].[stores] s
join [MergerProject].[dbo].[revenue_stores] r
on s.store_id = r.store_id
group by s.city, s.state)Store_Details
ON Store_Details.CITY = Employee_Details.city AND Store_Details.STATE = Employee_Details.state
group by Employee_Details.city, Employee_Details.state
order by sum(Store_Details.store_revenue) desc;


--------------------------------CTE METHOD------------------------
WITH Employee_Details AS(
SELECT  a.city, a.state, count(e.employee_id) num_of_employees
FROM [MergerProject].[dbo].[employee_info] e
join [MergerProject].[dbo].[addresses] a 
on a.address_id = e.address_id
join [MergerProject].[dbo].[departments] d
on d.department_id = e.department_id
where e.role not in ('sales_person','maintenance_worker', 'cashier','sales', 'delivery_driver',
					'district_manager', 'supervisor','stocker', 'picker','greeter', 'packer', 'loader', 'buyer')
group by a.city, a.state
),
Store_Details as(
SELECT s.city, s.state, count(s.store_id) num_of_stores, sum(r.store_revenue) store_revenue
FROM [MergerProject].[dbo].[stores] s
join [MergerProject].[dbo].[revenue_stores] r
on s.store_id = r.store_id
group by s.city, s.state)

select Employee_Details.city, Employee_Details.state, 
		sum(Employee_Details.num_of_employees) Num_of_Employees, 
		sum(num_of_stores) Num_of_Stores, 
		sum(store_revenue) Revenue_Generated
from Employee_Details
join Store_Details
ON Store_Details.CITY = Employee_Details.city AND Store_Details.STATE = Employee_Details.state
group by Employee_Details.city, Employee_Details.state
order by sum(Store_Details.store_revenue) desc;
