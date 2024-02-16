
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM dependents;
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

/*1. List of Employees by Department: How many employees are there in each department?*/ /*DONE*/
SELECT d.department_name, COUNT(e.employee_id) AS num_employees FROM departments d 
LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY d.department_name;

/*2. Salary Analysis: What is the average, minimum, and maximum salary by job title?*/ /*DONE*/
SELECT j.job_title, 
       AVG(e.salary) AS avg, 
       MIN(e.salary) AS minimum, 
       MAX(e.salary) AS maximum
FROM jobs j INNER JOIN employees e ON j.job_id = e.job_id GROUP BY j.job_title;

/*3. Geographical Distribution: How many employees are there in each country or region?*/ /*DONE*/
SELECT c.country_name, COUNT(e.employee_id) AS total_employees FROM countries c 
LEFT JOIN locations l ON c.country_id = l.country_id LEFT JOIN departments d 
ON l.location_id = d.location_id LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY c.country_name;

/*4. Employee Details: Can you provide a detailed list of employees, including their names, job titles, departments, and locations?*/ /*DONE*/
SELECT e.first_name, e.last_name, j.job_title, d.department_name, l.city
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id 
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id;

/*5. Department Locations: Which departments are located in each city or country?*/
SELECT l.city, d.department_name
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
ORDER BY l.city;

/*6. Job Title Analysis: What are the most common job titles, and how many employees hold those titles?*/
SELECT j.job_title, COUNT(e.employee_id) AS total_employees
FROM jobs j
LEFT JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
ORDER BY COUNT(e.employee_id) DESC;


/*7. Hiring Trends: How has the hiring trend varied by year or month?*/
SELECT YEAR(e.hire_date) AS hire_year, COUNT(e.employee_id) AS total_hires
FROM employees e
GROUP BY YEAR(e.hire_date);

/*8. Salary Range Jobs: Which jobs have the widest salary range, and what does this range look like?*/
SELECT j.job_title, (j.max_salary - j.min_salary) AS salary_range
FROM jobs j
ORDER BY (j.max_salary - j.min_salary) DESC;

/*9. Employee Tenure: Who are the longest-serving employees, and what departments do they work in?*/
SELECT e.first_name, e.last_name, e.hire_date, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
ORDER BY e.hire_date ASC
LIMIT 10;

/*10.cRegional Analysis: How do employee numbers, department counts, or average salaries compare across different regions?*/
SELECT r.region_name, COUNT(e.employee_id) AS num_employees, COUNT(DISTINCT d.department_id) AS total_departments, AVG(e.salary) AS avg_salary
FROM regions r
LEFT JOIN countries c ON r.region_id = c.region_id
LEFT JOIN locations l ON c.country_id = l.country_id
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name;


