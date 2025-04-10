/*Create new database & employee table (based on give sample data)
                      create employee table with primary key (EmployeeID)
*/

create database SQL_Projects;

use sql_projects;

create table Employee_details(
emp_id int Primary key,
first_name Varchar(30),
last_name varchar(30),
salary int,
joining_date  varchar(50),
department varchar(15),
gender varchar(7),
job_title varchar(40)
);



set sql_safe_updates=0;

set global local_infile=1;

show grants for root@localhost;

GRANT FILE ON *.* TO root@localhost;
FLUSH PRIVILEGES;

SHOW VARIABLES LIKE "local_infile";

SHOW VARIABLES LIKE 'secure-file-priv';



SET GLOBAL local_infile = 1;


show variables like "secure_file_priv";

/*insert sample data into the table*/


LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/Python_for_life/SQL assignment/tbl_emp_detail_data.csv'
INTO TABLE employee_details
FIELDS TERMINATED BY ','    
LINES TERMINATED BY '\n'    
IGNORE 1 ROWS;              

drop table employee_details;  
select * from employee_details;

-- Write a query to create a clone of an existing table using Create Command.

create table employee_2 as
select * from employee_details;

-- Write a query to get all employee detail from "employee" table

select * from employee_details;

-- Select only top 1 record from employee table

select * from employee_details 
limit 1;

-- Select only bottom 1 record from employee table

select * from employee_details
limit 1 offset 19;

-- How to select a random record from a table? 

SELECT * FROM employee_details
ORDER BY RAND()
LIMIT 1;

/* Write a query to get
 “first_name” in upper case as "first_name_upper"
 ‘first_name’ in lower case as ‘first_name_lower”
 Create a new column “full_name” by combining “first_name” &
 “last_name” with space as a separator.
 Add 'Hello ' to first_name and display result*/
 
 select 
 first_name,
 upper(first_name) as first_name_upper, 
 lower(first_name) as first_name_lower,
 concat(first_name,' ',last_name) as full_name,
 concat('Hello', first_name) as hello_first_name
 from employee_details;
 
 -- Select the employee details of Whose “first_name” is ‘Malli’
 
 select * from employee_details
 where first_name = "Malli";
 
 -- Select the employee details of Whose “first_name” present in ("Malli","Meena", "Anjali")
 
 select * from employee_details
 where first_name in ("Malli","Meena","Anjali");
 
 /*Select the employee details of Whose “first_name” not
 present in ("Malli","Meena", "Anjali")*/
 
select * from employee_details
where first_name not in ("Malli","Meena","Anjali");

-- Select the employee details of Whose “first_name” starts with “v”

select * from employee_details
where first_name like 'v%';

--  Select the employee details of Whose “first_name” ends with “i”

select * from employee_details
where first_name like '%i';

--  Select the employee details of Whose “first_name” contains “o”

select * from employee_details
where first_name like '%o%';

 /*Select the employee details of Whose "first_name" 
 start with any single character between 'm-v'*/
 
 select * from employee_details
 where first_name REGEXP '^[m-v]';
 
  /*Select the employee details of Whose "first_name" 
 not start with any single character between 'm-v'*/
 
 select * from employee_details
 where first_name not REGEXP '^[m-v]';
 
 /*Select the employee details of
 Whose "first_name" start with 'M' and contain 5 letters*/
 
 select * from employee_details
 where first_name like 'M____';
 
 -- Write a query to get all unique values of"department" from the employee table.
 
 select distinct (department) as unique_department from employee_details;
 
 -- Query to check the total records present in a table.
 
 select count(*) as total_record_count from employee_details ;
 
 /*Write down the query to print first letter of a Name in Upper Case 
 and all other letter in Lower Case.(EmployDetail table)*/
 
 select 
 concat(upper(left(first_name,1)), lower(substring(first_name,2))) as formated_name
 from employee_details;
 
 /*Write down the query to display all employee name in one cell separated by ','
       ex:-"Vikas, nikita, Ashish, Nikhil , anish"(EmployDetail table).*/
       
select group_concat(first_name separator ',') as all_employee_names
from employee_details;

/*Query to get the below values of "salary" from employee table
 Lowest salary
 Highest salary
 Average salary
 Highest salary - Lowest salary as diff_salary
 % of difference between Highest salary and lowest salary. (sample output
 format: 10.5%)*/
 
 Select min(salary) as lowest_salary from employee_details;
 
 select max(salary) as highest_salary from employee_details;
 
 select avg(salary) as average_salary from employee_details;
 
 select (max(salary)-min(salary)) as diff_salary from employee_details;
 
 select (max(salary)-min(salary)) as diff_salary from employee_details;
 
 select 
 concat(round(((max(salary)-min(salary))/min(salary))*100,2), '%') as salary_diff_per
 from employee_details;
 
 -- Select “first_name” from the employee table after removing white spaces from
 -- Right side spaces
 
 select rtrim(first_name) as trimmed_first_name
 from employee_details;
 
 -- Left side spaces
 
 select ltrim(first_name) as trimmed_first_name
 from employee_details;
 
 -- Both right & left side spaces
 
 select trim(first_name) as trimmed_first_name
 from employee_details;
 
 
 --  Query to check no.of records present in a table where employees having 50k salary
 
 select count(*) from employee_details
 where salary = 50000;
 
-- Find the most recently hired employee in each department.

UPDATE employee_details
SET joining_date = STR_TO_DATE(joining_date, '%d-%m-%Y %H:%i')
WHERE joining_date IS NOT NULL;


select * from employee_details;


select * from employee_details
where (department, joining_date) in(
	select department, max(joining_date)
    from employee_details
    group by department
)
order by department;

-- Display first_name and gender as M/F.(if male then M, if Female then F).

select first_name,
case gender 
	When 'Male' then 'M'
    When'Female' then 'F'
end as gender_accro
from employee_details;

/*Display first_name, salary, and a salary category. (If salary is below 50,000, categorize
 as 'Low'; between 50,000 and 60,000 as 'Medium'; above 60,000 as 'High')*/
 
 Select first_name, salary,
 case 
	when salary<50000 then "Low"
    when salary >=50000 and salary < 60000 then "Medium"
    when salary >= 60000 then "High"
end as salary_category
from employee_details;

/*Display first_name, department, and a department classification. (If department is
 'IT', display 'Technical'; if 'HR', display 'Human Resources'; if 'Finance', display
 'Accounting'; otherwise, display 'Other')*/
 
 select first_name, department,
 case department
	when 'IT' then 'Technical'
    when 'HR' then 'Human Resources'
    when 'Finance' then 'Accounting'
    else 'other'
end as department_category
from employee_details;

/*Display first_name, salary, and eligibility for a salary raise. (If salary is less than
 50,000, mark as 'Eligible for Raise'; otherwise, 'Not Eligible')*/
select first_name, salary,
	case 
		when salary < 50000 then 'Eligible for Raise'
		else 'Not Eligible'
	end as eligibility
from employee_details;

/*Display first_name, joining_date, and employment status. (If joining date is before
 '2022-01-01', mark as 'Experienced'; otherwise, 'New Hire')*/
 
select first_name, joining_date,
	case 
		when joining_date < '2022-01-01' then 'Experienced'
        else 'New Hire'
	end as employment_status
from employee_details;

/*Display first_name, salary, and bonus amount. (If salary is above 60,000, add10%
 bonus; if between 50,000 and 60,000, add 7%; otherwise, 5%)*/
 
 select first_name, salary,
	case 
		when salary > 60000 then (salary +(salary*0.10))
        when salary >= 50000 and salary <= 60000 then (salary +(salary*0.07))
        else (salary +(salary*0.05))
	end as bonus_amount
from employee_details;

/*Display first_name, salary, and seniority level.
 (If salary is greater than 60,000, classify as 'Senior'; between 50,000 and 60,000 as
 'Mid-Level'; below 50,000 as 'Junior')*/
 
 select first_name, salary,
	case 
		when salary > 60000 then 'Senior'
        when salary >= 50000 and salary <= 60000 then 'Mid-Level'
        else 'Junior'
	end as seniority_level
from employee_details;


/*Display first_name, department, and job level for IT employees. (If department is 'IT'
       and salary is greater than 55,000, mark as 'Senior IT Employee'; otherwise, 'Other').*/

select first_name, department,
		case 
			when department = 'IT' and salary > 55000 then 'Senior IT employees'
            else 'other'
		end as job_level
from employee_details;

/*Display first_name, joining_date, and recent joiner status. (If an employee joined
after '2024-01-01', label as 'Recent Joiner'; otherwise, 'Long-Term Employee')*/

select first_name, joining_date,
	case
		when joining_date > '2024-01-01' then 'Recent Joiner'
        else 'Long-Term Employee'
	end as Joiner_status
from employee_details;

/* Display first_name, joining_date, and leave entitlement. (If joined before '2021-01
01', assign '10 Days Leave'; between '2021-01-01' and '2023-01-01', assign '20 Days
Leave'; otherwise, '25 Days Leave')*/

select first_name, joining_date,
	case 
		when joining_date < '2021-01-01' then 10
        when joining_date > '2021-01-01' and joining_date < '2023-01-1' then 20
        else 25
	end as leave_entitlement
from employee_details;
       
/*Display first_name, salary, department, and promotion eligibility. (If salary is above
60,000 and department is 'IT', mark as 'Promotion Eligible'; otherwise, 'Not Eligible')*/

select first_name, salary, department,
	case
		when salary > 60000 and department = 'IT' then 'Promotion Eligible'
        else 'Not Eligible'
	end as promotion_eligibility
from employee_details;

/*Display first_name, salary, and overtime pay eligibility. (If salary is below 50,000,
mark as 'Eligible for Overtime Pay'; otherwise, 'Not Eligible')*/

select first_name, salary, 
	case
		when salary < 50000 then 'Eligible for Overtime Pay'
        else 'Not Eligible'
	end as Overtime_pay_eligibility
from employee_details;

/*Display first_name, department, salary, and job title. (If department is 'HR' and salary
is above 60,000, mark as 'HR Executive'; if department is 'Finance' and salary is above
55,000, mark as 'Finance Manager'; otherwise, 'Regular Employee')*/

select first_name, department, salary, 
	case 
		when department = 'HR' and salary > 60000 then 'HR Executive'
        when department = 'Finance' and salary > 55000 then 'Finance manager'
        else 'Regular Employee'
	end as job_title
from employee_details;

/* Display first_name, salary, and salary comparison to the company average. (If salary is 
above the company’s average salary, mark as 'Above Average'; otherwise, 'Below
Average')*/

select first_name, salary,
	case
		when salary > (select avg(salary) from employee_details) then 'Above average'
        else 'Below average'
	end as salary_comparison
from employee_details;

/*Write the query to get the department and department wise total(sum) salary,
 display it in ascending and descending order according to salary. */
 
 select department, sum(salary) as total_salary 
 from employee_details 
 group by department
 order by sum(salary);
 
select department, sum(salary) as total_salary 
from employee_details 
group by department
order by sum(salary) desc;

create table project_details(
project_id int primary key,
emp_id_no int,
project_name varchar(40),
start_date datetime,
end_date datetime,
status varchar(40)
);

select * from project_details;
select * from employee_details;

delete from project_details;

select count(*) from employee_details;
-- DELETE FROM employee_details
-- WHERE emp_id IN (1111, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010);

-- Write down the query to fetch Project name assign to more than one Employee

select project_name, count(emp_id_no) as c from project_details
group by project_name
having count(emp_id_no) > 1
order by c;

/* Write the query to get the department, total no. of departments, total(sum) salary
 with respect to department from "employee table" table. */
 
 SELECT COUNT( distinct department) AS count_dep, department, Total_salary
FROM (
    SELECT department, SUM(salary) AS Total_salary
    FROM employee_details
    GROUP BY department
) AS t
GROUP BY department, Total_salary;

/* Get the department-wise salary details from the "employee table" table: 
 What is the average salary? (Order by salary ascending)
 What is the maximum salary? (Order by salary ascending)*/
 
 select department, avg(salary) as avg_salary,
 max(salary) as max_salary from employee_details
 group by department
 order by avg_salary, max_salary;
 
 /*Display department-wise employee count and categorize based on size. (If a department
has more than 5 employees, label it as 'Large'; between 3 and 5 as 'Medium'; otherwise,
'Small')*/

select department, count(emp_id) as emp_count,
case 
	when count(emp_id)  > 5 then 'Large'
    when count(emp_id) < 5 and count(emp_id)> 3 then 'Medium'
    else 'Small'
end as category
from employee_details
group by department;

/*Display department-wise average salary and classify pay levels. (If the average salary in a
department is above 60,000, label it as 'High Pay'; between 50,000 and 60,000 
as 'Medium Pay'; otherwise, 'Low Pay').*/

select department, avg(salary)as avg_salary,
case
	when avg(salary) > 60000 then 'High Pay'
    when avg(salary) < 60000 and avg(salary) > 50000 then 'Medium Pay'
    else 'Low Pay'
end as pay_levels
from employee_details
group by department;

/* Display department, gender, and count of employees in each category. (Group by
department and gender, showing total employees in each combination)*/

select department, gender, count(emp_id) as count_emp
from employee_details
group by department, gender;

/* Display the number of employees who joined each year and categorize hiring trends. (If a
year had more than 5 hires, mark as 'High Hiring'; 3 to 5 as 'Moderate Hiring'; otherwise,
'Low Hiring')*/

select count(emp_id) as emp_count,year(joining_date),
case 
	when count(emp_id) > 5 then 'High Hiring'
    when count(emp_id) <=5 and count(emp_id) >=3 then 'Moderate Hiring'
    else 'Low Hiring'
end as category
from employee_details
group by year(joining_date);

/*Display department-wise highest salary and classify senior roles. (If the highest salary in a
department is above 70,000, label as 'Senior Leadership'; otherwise, 'Mid-Level')*/

select max(salary) as high_salary, department,
case
	when max(salary)>70000 then 'Senior leadership'
    else 'Mid Level'
end as seniority
from employee_details
group by department;

/* Display department-wise count of employees earning more than 60,000. (Group
employees by department and count those earning above 60,000, labeling departments
with more than 2 such employees as 'High-Paying Team')*/

select department, count(emp_id) as emp_count,
case 
	when count(emp_id)>2 then 'High-Paying Team'
    else 'Average'
end as category
from employee_details
where salary > 60000
group by department;

/*Query to extract the below things from joining_date column. (Year, Month, Day, Current
 Date)*/
 
 select Year(joining_date) as YEAR_J,
 month(joining_date) as Month_J,
 day(joining_date) as DAY_J,
 current_date() as CURR_DATE
 from employee_details;
 
 /*Create two new columns that calculate the difference between joining_date and the
 current date. One column should show the difference in months, and the other should
 show the difference in days*/
 
select
	timestampdiff(month, joining_date, current_date()) as date_diff_m,
    timestampdiff(day, joining_date, current_date()) as date_diff_d
from employee_details;

-- Get all employee details from the employee table whose joining year is 2020.

select * from employee_details
where year(joining_date) = 2020;

-- Get all employee details from the employee table whose joining month is Feb.

select * from employee_details
where month(joining_date) = 2;

/*Get all employee details from employee table whose joining date between "2021-01-01"
 and "2021-12-01"*/
 
 select * from employee_details
 where joining_date > '2021-01-01'and joining_date < '2021-12-01';
 
 /*Get the employee name and project name from the "employee table" and
 "ProjectDetail" for employees who have been assigned a project, sorted by first name.*/
 
 select first_name, project_name
 from employee_details  join project_details on
 employee_details.emp_id = project_details.emp_id_no
 order by first_name;
 
 /*Get the employee name and project name from the "employee table" and
 "ProjectDetail" for all employees, including those who have not been assigned a project,
 sorted by first name.*/
 
 select first_name, project_name
 from employee_details  left join project_details on
 employee_details.emp_id = project_details.emp_id_no
 order by first_name;
 
 /*Get the employee name and project name from the "employee table" and
 "ProjectDetail" for all employees. If an employee has no assigned project, display "-No
 Project Assigned," sorted by first name*/
 
  select first_name, 
  case
	when project_name IS Null then "No Project Assigned"
    else project_name
end as project_name
 from employee_details  left join project_details on
 employee_details.emp_id = project_details.emp_id_no
 order by first_name;
 
 /* Get all project names from the "ProjectDetail" table, even if they are not linked to any
 employee, sorted by first name from the "employee table" and "ProjectDetail" table*/
 
 select first_name, project_name
 from employee_details  right join project_details on
 employee_details.emp_id = project_details.emp_id_no
 order by first_name;
 
 /*Find the project names from the "ProjectDetail" table that have not been assigned to
 any employee using the "employee table" and "ProjectDetail" table.*/
 
 select project_name, first_name
 from employee_details  right join project_details on
 employee_details.emp_id = project_details.emp_id_no
 where first_name is null;
 
 /*Get the employee name and project name for employees who are assigned to more than
 one project.*/
 
select e.first_name, p.project_name
from employee_details e join project_details p
on e.emp_id = p.emp_id_no
where e.emp_id in (
select emp_id_no
from project_details
group by emp_id_no
having count(project_name) > 1
);

/* Get the project name and the employee names of employees working on projects that
 have more than one employee assigned.*/
 
 
 
select  p.project_name, e.first_name
from employee_details e join project_details p
on e.emp_id = p.emp_id_no
where p.project_name in (
select project_name
from project_details
group by project_name
having count(emp_id_no) > 1
)
order by project_name;

/*Get records from the "ProjectDetail" table where the corresponding employee ID does
 not exist in the "employee table.*/
 
 select * from project_details
 where emp_id_no not in (
 select emp_id from employee_details
 );
 
 
 select * from employee_details;
 select * from project_details;
 
 INSERT INTO project_details (project_id, emp_id_no, project_name, start_date, end_date, status)
VALUES 
    (2001, 101, 'Website Redesign', '2022-03-07', '2022-06-10', 'Completed'),
    (2002, 101, 'Cloud Migration', '2022-06-10', NULL, 'Ongoing'),
    (2003, 102, 'AI Chatbot', '2022-01-29', NULL, 'Ongoing'),
    (2004, 103, 'Data Migration', '2022-08-13', '2023-04-05', 'Completed'),
    (2005, 103, 'AI Chatbot', '2022-05-21', '2022-07-08', 'Completed'),
    (2006, 103, 'ML Model Deployment', '2022-05-14', NULL, 'Ongoing'),
    (2007, 104, 'Website Redesign', '2023-04-18', '2023-07-20', 'Completed'),
    (2008, 105, 'ML Model Deployment', '2022-05-22', '2022-07-02', 'Completed'),
    (2009, 105, 'Cloud Migration', '2023-04-10', '2024-01-14', 'Completed'),
    (2010, 106, 'Data Migration', '2022-05-03', '2022-07-14', 'Completed'),
    (1111, 202, 'Food Ordering App', '2024-02-01', NULL, 'Ongoing');
    
/* Get all project names from the "ProjectDetail" table, even if they are not linked to any
 employee, sorted by first name from the "employee table" and "ProjectDetail" table.*/
 
select project_name, first_name
from project_details join employee_details 
on project_details.emp_id_no = employee_details.emp_id
order by first_name;   

/* Find the project names from the "ProjectDetail" table that have not been assigned to
 any employee using the "employee table" and "ProjectDetail" table.*/
 
 select * from project_details
 where emp_id_no not in(
 select emp_id from employee_details);
 
 /*Get the employee name and project name for employees who are assigned to more than
 one project.*/
 
 select e.first_name, p.project_name
 from employee_details e join project_details p
 on e.emp_id = p.emp_id_no
 where e.emp_id in (select emp_id_no
 from project_details
 group by emp_id_no
 having count(project_name)>1);
 
 /* Get the project name and the employee names of employees working on projects that
 have more than one employee assigned*/
 
  select * from project_details
 where emp_id_no not in (
 select emp_id from employee_details
 );
 
  
 select e.first_name, p.project_name
 from employee_details e join project_details p
 on e.emp_id = p.emp_id_no
 where p.project_name in (select project_name
 from project_details
 group by project_name
 having count(emp_id_no)>1)
 order by project_name;
 
/*Assign a row number to each employee within their department based on salary in
 descending order*/
 
select
	row_number() over(partition by department order by salary desc) as row_num,
    emp_id,
	first_name,
    last_name,
    department,
    salary
from employee_details;
 
#Rank employees within each department based on salary using RANK()

select
	rank () over(partition by department order by salary desc) as rank_emp,
    emp_id,
	first_name,
    last_name,
    department,
    salary
from employee_details;

# Rank employees within each department based on salary using DENSE_RANK().

select
	dense_rank () over(partition by department order by salary desc) as drank,
    emp_id,
	first_name,
    last_name,
    department,
    salary
from employee_details;

#Find the highest-paid employee in each department using RANK().

SELECT 
    rank_emp,
    emp_id,
    first_name,
    last_name,
    department,
    salary
FROM (
    SELECT
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_emp,
        emp_id,
        first_name,
        last_name,
        department,
        salary
    FROM employee_details
) AS ranked_employees
WHERE rank_emp = 1;

#Find the second highest-paid employee in each department using RANK().

SELECT 
    rank_emp,
    emp_id,
    first_name,
    last_name,
    department,
    salary
FROM (
    SELECT
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_emp,
        emp_id,
        first_name,
        last_name,
        department,
        salary
    FROM employee_details
) AS ranked_employees
WHERE rank_emp = 2;

#Rank employees based on their years of experience within each department.

select 
	emp_id,
	first_name,
    last_name,
    department,
    timestampdiff (year, joining_date, curdate()) as years_of_exp,
    rank () over(partition by department order by timestampdiff (year, joining_date, curdate()) desc) as rank_yr
    from employee_details;
    
    #Find the employee with the earliest join date in each department using RANK().
   
   select
		emp_id,
        first_name,
        last_name,
        department,
        joining_date, 
		rank_join
	from(select
		emp_id,
        first_name,
        last_name,
        department,
        joining_date,
        rank () over(partition by department order by joining_date) as rank_join
        from employee_details) as rank_emp
	where rank_join = 1
    
	/* Find the employees who earn more than the average salary of their department*/
    
Select * from employee_details;

Select
	e.first_name,
    e.last_name,
    e.department,
    e.salary
from 
	employee_details e
where e.salary > (
select 
avg(salary)
from employee_details
where department = e.department
);

/*Rank employees within each job title in every department based on salary.*/

select * from employee_details;

select first_name,
last_name,
department,
job_title,
salary,
rank() over (partition by department, job_title order by salary desc ) as sal_job_rank
from employee_details;

/*Find the top 3 highest-paid employees in each department.*/

select first_name,
last_name,
department,
job_title,
salary from (select first_name,
last_name,
department,
job_title,
salary,
row_number() over (partition by department order by salary desc ) as sal_job_rank
from employee_details) as t
where sal_job_rank < 4;

/*Find employees who belong to the top 10% earners within their department using
 PERCENT_RANK()*/
 
select first_name,
last_name,
department,
job_title,
salary,
sal_job_rank from (select first_name,
last_name,
department,
job_title,
salary,
percent_rank() over (partition by department order by salary) as sal_job_rank
from employee_details) as t
where sal_job_rank > 0.9;

/*Assign row numbers to employees based on their joining year using PARTITION BY
 YEAR(join_date)*/
 
 select 
 first_name,
 last_name,
 joining_date,
 department,
 year(joining_date) as yr,
 row_number() over(partition by year(joining_date)) as yr_r
 from employee_details;
 
 
 
 /*Rank employees based on the number of projects handled within each department.*/
 
 select * from employee_details;
 select * from project_details;
 
 select first_name,
 last_name,
 emp_id,
 p_count,
 department,
 rank() over (partition by  department order by p_count desc) as p_rank_order from(
 select e.first_name as first_name, e.last_name as last_name, e.department as department,
 p.emp_id_no as emp_id, count(project_id) as p_count from project_details p
 join employee_details e on p.emp_id_no = e.emp_id
 group by emp_id) as t;
 
 /*Find employees who are the only ones in their department (departments with only one
 employee).*/
 
 select * from employee_details;
 
 select * from employee_details
 where  department in (
 select  department from employee_details 
 group by department
 Having count(emp_id) =1 );
 
 /*Find the highest-paid employee in each job role within a department.*/
 
select first_name,
last_name,
salary,
t,
department from ( select 
 first_name,
 last_name,
 salary,
 department,
 row_number () over (partition by department order by salary desc) as t
 from employee_details) as p
 where t = 1 ;
 
 /*Find employees who have been working in the company the longest in each department.*/
 
 select first_name,
 last_name,
 department,
 joining_date,
 year_diff,
 t from (select first_name,
 last_name,
 department,
 joining_date,
timestampdiff(day, joining_date, current_date()) as year_diff,
 row_number () over (partition by department order by timestampdiff(day, joining_date, current_date()) desc) as t
 from employee_details) as p
 where t =1 ;
 
 
 
 







 















      




 



 





       



