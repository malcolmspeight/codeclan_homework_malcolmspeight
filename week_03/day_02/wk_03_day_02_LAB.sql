-- Question 1a

SELECT * FROM employees;


SELECT e.first_name, e.last_name, t."name" AS team_name
FROM employees AS e 
INNER JOIN teams AS t
ON e.id = t.id; 


-- Question 1b

SELECT e.first_name, e.last_name, t."name" AS team_name
FROM employees AS e 
INNER JOIN teams AS t
ON e.id = t.id
WHERE e.pension_enrol IS TRUE; 


-- Question 1c

SELECT e.first_name, e.last_name, t."name", t.charge_cost  
FROM employees AS e 
INNER JOIN teams AS t
ON e.id = t.id
WHERE CAST(t.charge_cost AS NUMERIC) > 80; 


-- Question 2a

SELECT e.*, pd.local_account_no, pd.local_sort_code  
FROM employees AS e
LEFT JOIN pay_details pd
ON e.pay_detail_id = pd.id;


-- Question 2b

SELECT e.*, pd.local_account_no, pd.local_sort_code , t."name"  
FROM employees AS e
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id
LEFT JOIN teams AS t
ON e.team_id = t.id;


-- Question 3a

SELECT e.id AS employee_id, t."name"  
FROM employees AS e
LEFT JOIN teams t 
ON e.team_id = t.id; 


-- Question 3b

SELECT t."name" AS team_name, count(e.*) AS employee_count  
FROM employees AS e
LEFT JOIN teams t 
ON e.team_id = t.id
GROUP BY t."name"; 


-- Question 3c

SELECT t."name" AS team_name, count(e.*) AS employee_count  
FROM employees AS e
LEFT JOIN teams t 
ON e.team_id = t.id
GROUP BY t."name"
ORDER BY employee_count ASC; 

 
-- Question 4a 

SELECT t.id, t."name" AS team_name, count(*) 
FROM teams AS t
INNER JOIN employees AS e
ON t.id = e.team_id
GROUP BY t.id, t."name"
ORDER BY t.id;


-- Question 4b

SELECT  t.id, 
        t."name" AS team_name, 
        count(e.*) AS employee_count, 
        t.charge_cost,
        (CAST(t.charge_cost AS NUMERIC) * count(e.*)) AS total_day_charge
FROM teams AS t
INNER JOIN employees AS e
ON t.id = e.team_id
GROUP BY t.id, t."name"
ORDER BY t.id;


-- Question 4c

SELECT  t.id, 
        t."name" AS team_name, 
        count(e.*) AS employee_count, 
        t.charge_cost,
        (CAST(t.charge_cost AS NUMERIC) * count(e.*)) AS total_day_charge
FROM teams AS t
INNER JOIN employees AS e
ON t.id = e.team_id
GROUP BY t.id, t."name"
HAVING (CAST(t.charge_cost AS NUMERIC) * count(e.*)) > 5000
ORDER BY t.id;


-- Extensions


-- Question 5

-- no of rows in table = 24
SELECT count(*) FROM employees_committees;

-- number of distinct employee ids in table = 22
SELECT count(DISTINCT(employee_id)) 
FROM employees_committees; 

-- number of employees who serve on more than 1 committee = 24 - 22 = 2 
SELECT (count(*) - count(DISTINCT(employee_id))) AS  employ_count
FROM employees_committees; 


-- Question 6

SELECT count(e.*) AS employees_no_committee
FROM employees AS e
LEFT JOIN employees_committees AS ec
ON e.id = ec.employee_id 
WHERE ec.employee_id IS NULL;








