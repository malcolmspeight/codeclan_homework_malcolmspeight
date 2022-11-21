/* MVP */

-- Question 1

SELECT *
FROM employees 
WHERE department = 'Human Resources';


-- Question 2

SELECT first_name, last_name, country
FROM employees 
WHERE department = 'Legal';


-- Question 3

SELECT COUNT(*) AS employee_count
FROM employees 
WHERE country = 'Portugal';


-- Question 4

SELECT COUNT(*) AS employee_count
FROM employees 
WHERE country IN ('Portugal', 'Spain');


-- Question 5

SELECT COUNT(*) AS count_no_local_ac
FROM pay_details 
WHERE local_account_no ISNULL;


-- Question 6
-- no records found

SELECT *
FROM pay_details 
WHERE local_account_no ISNULL 
AND iban ISNULL; 


-- Question 7

SELECT first_name, last_name
FROM employees 
ORDER BY last_name ASC NULLS LAST; 


-- Question 8

SELECT first_name, last_name, country
FROM employees 
ORDER BY country ASC, last_name ASC
NULLS LAST;


-- Question 9

SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST
LIMIT 10;


-- Question 10

SELECT first_name, last_name, salary
FROM employees 
ORDER BY salary ASC NULLS LAST
LIMIT 1;


-- Question 11

SELECT count(*) AS first_initial_F
FROM employees 
WHERE first_name ILIKE 'f%';


-- Question 12

SELECT *
FROM employees
WHERE email ILIKE '%@yahoo%';


-- Question 13

SELECT count(*) AS Not_pension_enrol
FROM employees
WHERE pension_enrol = TRUE
AND country NOT IN ('France', 'Germany');


-- Question 14

SELECT MAX(salary) AS max_eng_sal   
FROM employees
WHERE department = 'Engineering'
AND fte_hours = 1.0;


-- Question 15

SELECT first_name , last_name , fte_hours , salary, 
        (fte_hours * salary) AS effective_yearly_salary
FROM employees; 


/* Ext */


-- Question 16

SELECT first_name || ' ' || last_name || ' - ' || department AS badge_label
FROM employees
WHERE first_name NOTNULL 
AND last_name NOTNULL
AND department NOTNULL; 


-- Question 17

SELECT first_name || ' ' || last_name || ' - ' || department || 
        ' (joined ' || EXTRACT(YEAR FROM start_date) || ')' AS badge_label
FROM employees
WHERE first_name NOTNULL 
AND last_name NOTNULL
AND department NOTNULL
AND start_date NOTNULL; 


-- with month as string (not quite right though)
SELECT first_name || ' ' || last_name || ' - ' || department || 
        ' (joined ' || TO_CHAR(start_date, 'Month') || to_char(start_date, 'YYYY') || ')' AS badge_label
FROM employees
WHERE first_name NOTNULL 
AND last_name NOTNULL
AND department NOTNULL
AND start_date NOTNULL; 


-- Question 18

SELECT first_name, last_name, salary, 
    (CASE WHEN salary < 40000 THEN 'low' 
          WHEN salary >= 40000 THEN 'high' END) AS salary_class
FROM employees
WHERE salary NOTNULL 
ORDER BY salary ASC; 





