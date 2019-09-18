-- Banco de Dados 2019.2 - ROTEIRO 4
-- Professor: Cláudio Campelo
-- Aluno: Nathan Fernandes
-- ssh -o ServerAliveInterval=30 nathan@150.165.15.11 -p 45600

DROP OWNED BY nathan;
CREATE SCHEMA company; 
SHOW search_path; 
SET search_path TO company,public;

CREATE TABLE test();
DROP TABLE test;

-- Q1
SELECT * FROM department;

-- Q2
SELECT * FROM dept_locations;

-- Q3
SELECT * FROM employee;

-- Q4
SELECT * FROM dependent;

-- Q5
SELECT * FROM project;

-- Q6
SELECT * FROM works_on;

-- Q7
SELECT (fname, lname) FROM employee WHERE sex = 'M';

-- Q8
SELECT (fname) FROM employee WHERE sex = 'M' AND superssn IS NULL;

-- Q9
SELECT e.fname AS e_fname, s.fname AS s_fname 
FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn;

-- Q10
SELECT e.fname AS e_fname FROM employee AS e, employee AS s
WHERE e.superssn = s.ssn AND s.fname = 'Franklin';

-- Q11
SELECT d.dname AS d_dname, l.dlocation AS d_location
FROM department AS d, dept_locations AS l
WHERE d.dnumber = l.dnumber;

-- Q12
SELECT d.dname AS d_dname, l.dlocation AS d_location
FROM department AS d, dept_locations AS l
WHERE d.dnumber = l.dnumber AND SUBSTRING(l.dlocation, 1, 1) = 'S';

-- Q13
SELECT e.fname AS e_fname, e.lname AS e_lname, d.dependent_name AS dependent_name
FROM employee AS e, dependent AS d
WHERE d.essn = e.ssn;

-- Q14
SELECT e.fname || ' ' || e.minit || ' ' || e.lname AS full_name, e.salary AS salary
FROM employee AS e
WHERE e.salary > 50000;

-- Q15
SELECT p.pname AS project_name, d.dname AS department_name
FROM project AS p, department AS d
WHERE p.dnum = d.dnumber;

-- Q16
SELECT p.pname AS project_name, e.fname AS staff_name
FROM project AS p, employee AS e, department AS d
WHERE p.pnumber > 30 AND p.dnum = d.dnumber AND e.ssn = d.mgrssn; 

-- Q17
SELECT p.pname AS project_name, e.fname AS employee_name
FROM project AS p, EMPLOYEE AS e, works_on AS w
WHERE w.essn = e.ssn AND w.pno = p.pnumber;

-- Q18
SELECT e.fname AS fname, d.dependent_name AS dependent_name,
d.relationship AS relationship FROM employee AS e, dependent AS d, works_on AS w
WHERE w.pno = 91 AND d.essn = e.ssn AND w.essn = e.ssn;
