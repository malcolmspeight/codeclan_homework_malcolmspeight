/*
 * FINAL SQL lab and Homework
 *  
 */

/*
 * MVP
 */

-- Question 1

SELECT COUNT(*)
FROM employees 
WHERE grade IS NULL 
AND salary IS NULL; 


-- Question 2

SELECT department, first_name, last_name
FROM employees 
ORDER BY department, last_name;


-- Question 3

SELECT *
FROM employees 
WHERE salary NOTNULL 
AND last_name ILIKE 'a%'
ORDER BY salary DESC 
LIMIT 10;


-- Question 4

SELECT department, COUNT(*) AS intake_2003
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;


-- Question 5

SELECT department, fte_hours, count(*) AS employee_count
FROM employees
GROUP BY department, fte_hours
ORDER BY department ASC, fte_hours ASC; 


-- Question 6

SELECT pension_enrol, COUNT(*) AS employee_count
FROM employees 
GROUP BY pension_enrol;


-- Question 7

SELECT *
FROM employees 
WHERE department = 'Accounting'
AND pension_enrol IS FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1; 


-- Question 8

SELECT country, count(*) AS employee_count, avg(salary) AS avg_salary
FROM employees 
GROUP BY country
HAVING count(*) > 30
ORDER BY avg_salary desc; 


-- Question 9

SELECT 
    first_name, 
    last_name, 
    fte_hours, 
    salary, 
    (fte_hours * salary) AS effective_yearly_salary
FROM employees
WHERE (fte_hours * salary) > 30000; 


-- Question 10

-- looking at contents of table "teams"
SELECT * FROM teams;

SELECT * 
FROM employees AS e
LEFT JOIN teams AS t 
ON e.team_id = t.id 
WHERE t.id IN (7, 8);


-- Question 11

-- count entries in pay_details table which lack a tax code
SELECT count(*) FROM pay_details WHERE local_tax_code IS NULL; 

SELECT first_name, last_name 
FROM employees AS e
LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id 
WHERE pd.local_tax_code IS NULL; 


-- Question 12

SELECT 
    first_name,
    last_name,
    (48 * 35 * CAST(t.charge_cost AS NUMERIC) - e.salary) * e.fte_hours AS expected_profit
FROM employees AS e
LEFT JOIN teams AS t 
ON e.team_id = t.id
ORDER BY expected_profit; 


-- Question 13

-- unsure why question hint mentions 'mode'. 
-- I'm assuming this is a typo and 'least common' = 'least frequent'

-- list of fte_hours categories and their frequency
SELECT fte_hours, count(*) AS employee_count
FROM employees
GROUP BY fte_hours
ORDER BY count(*) ASC;
    
-- lowest paid employee in least common fte_hours category
SELECT first_name, last_name, salary 
FROM employees 
WHERE fte_hours IN (
    SELECT fte_hours
    FROM employees
    GROUP BY fte_hours
    ORDER BY count(*) ASC 
    LIMIT 1
    )
ORDER BY salary ASC 
LIMIT 1;


-- Question 14

SELECT department, count(*) AS no_first_name_count
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING count(*) >= 2
ORDER BY no_first_name_count DESC, department ASC; 


-- Question 15

SELECT first_name, count(*) AS first_name_frequency
FROM employees 
WHERE first_name NOTNULL 
GROUP BY first_name
HAVING count(*) > 1
ORDER BY first_name_frequency DESC, first_name ASC; 


-- Question 16

SELECT 
    department, 
    CAST(sum(CAST(grade = 1 AS INTEGER)) AS REAL) / COUNT(*) * 100 AS grade1_percent
FROM employees
GROUP BY department
ORDER BY department; 


/*
 * EXTENSION
 * 
 */

-- Ext Question 1

-- CTE for largest department 
WITH largest_dep AS (
    SELECT department
    FROM employees 
    GROUP BY department
    ORDER BY count(*) DESC
    LIMIT 1
), 
-- CTE for departmental averages
team_avgs AS (
    SELECT 
        department,
        avg(salary) AS avg_salary, 
        avg(fte_hours) AS avg_fte_hours
    FROM employees
    WHERE department = (
        SELECT department
        FROM largest_dep)
    GROUP BY department 
)
-- main query
SELECT 
    e.id,
    e.first_name,
    e.last_name, 
    e.department, 
    e.salary, 
    e.salary / t_a.avg_salary AS salary_over_team_avg,
    e.fte_hours, 
    e.fte_hours / t_a.avg_fte_hours AS fte_over_team_avg
FROM employees AS e
INNER JOIN team_avgs AS t_a
ON e.department = t_a.department
ORDER BY e.id;

-- Generalise query for Ext Q1 would be to change "Limit 1" on the departmental 
-- CTE to include ties.


-- Ext Question 2

SELECT 
    COALESCE(CAST(pension_enrol AS varchar), 'unknown') AS pension_enrolled, 
    COUNT(*) AS employee_count
FROM employees 
GROUP BY pension_enrol;


-- Ext Question 3

SELECT * FROM committees; 


SELECT e.first_name, e.last_name, e.email, e.start_date 
FROM employees AS e
LEFT JOIN employees_committees AS ec 
ON e.id = ec.employee_id 
WHERE ec.committee_id = 3
ORDER BY e.start_date ASC;


-- Ext Question 4

SELECT  
    (CASE WHEN e.salary < 40000 THEN 'low'
          WHEN e.salary >= 40000 THEN 'high'
          WHEN e.salary IS NULL THEN 'none' END) AS salary_class,
    count(DISTINCT(employee_id)) AS employee_count
FROM employees_committees AS ec
LEFT JOIN employees AS e
ON ec.employee_id = e.id
GROUP BY (CASE WHEN e.salary < 40000 THEN 'low'
          WHEN e.salary >= 40000 THEN 'high'
          WHEN e.salary IS NULL THEN 'none' END); 


































