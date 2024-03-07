/* SQL & Tableau data analyst project , KPI testting with SQL*/ 

/* creating the table with the same column headers as the file */
create table hrd 
(
emp_no int8 PRIMARY KEY,
gender varchar(50) not Null,
marital_status varchar(50),
age_band varchar(50),
age int2,
department varchar(50),
education varchar(50),
education_field varchar(50),
job_role varchar(50),
business_travel varchar(50),
employee_count int8,
attrition varchar(50),
attrition_label varchar(50),
job_satisfaction int8,
active_employee int8
)


/* importing data from the file saved in my laptop as hrd_data */

select * 
from hrd 
-- No of employees in each department and we can also test based on their education as well 
select sum(employee_count) from hrd 
-- where education= 'High School'
--where department = 'Sales'
where education_field = 'Medical'

/* counting attrition where it is 'Yes' and should be doctoral degree*/
select count(attrition) from hrd
where attrition = 'Yes' and  department = 'R&D' and education_field = 'Medical' and education = 'High School'                     --education = 'Doctoral Degree'


-- Attrition rate
select round(((select count(attrition) from hrd where attrition = 'Yes')/sum(employee_count))*100,2) 
from hrd



-- attrition rate department wise 
select round(((select count(attrition) from hrd where attrition = 'Yes'and department = 'Sales')/sum(employee_count))*100,2) 
from hrd
where department = 'Sales'



-- active employees 
select sum(employee_count)- (select count(attrition) from hrd where attrition = 'Yes')
from hrd


-- active emloyees by gender 
select sum(employee_count)- (select count(attrition) from hrd where attrition = 'Yes'and gender = 'Male')
from hrd
where gender = 'Male'


-- Average age of employees 
select round(avg(age),0)as avg_age from hrd



-- attrition by gender 
select gender,count(attrition) from hrd 
where attrition = 'Yes'
group by gender 
order by count(attrition) desc 



select gender,count(attrition) from hrd 
where attrition = 'Yes' and education = 'High School'
group by gender 
order by count(attrition) desc 


-- attrition by department 
select department, count(attrition) from hrd 
where attrition = 'Yes'
group by department 
order by count(attrition)desc;


-- Number of employees by age group 
select age,sum(employee_count) from hrd 
--where department = 'R&D'   -- we can also test it department wise 
group by age 
order by age 

-- Eduaction field by attrition
select education_field,count(attrition)from hrd 
where attrition= 'Yes' and --department = 'R&D' , can also check department wise 
group by education_field
order by count(attrition) desc




-- attrition rate by gender for different age group 
select age_band,gender,count(attrition)from hrd 
where attrition = 'Yes'
group by age_band, gender 
order by count(attrition)desc


select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrd where attrition = 'Yes')) * 100,2) as pct
from hrd
where attrition = 'Yes'
group by age_band, gender
order by age_band desc;



-- end of the kpi testing SQl with Tableau 
 -- Thank You 