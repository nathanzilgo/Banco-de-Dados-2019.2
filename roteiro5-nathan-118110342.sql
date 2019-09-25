-- Banco de Dados 2019.2 - ROTEIRO 4
-- Professor: Cláudio Campelo
-- Aluno: Nathan Fernandes
-- ssh -o ServerAliveInterval=30 nathan@150.165.15.11 -p 45600

-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND substring(address, length(address)-1, length(address)) = 'TX';

-- Q3
SELECT superssn AS ssn_supervisor, COUNT(ssn) AS qtd_supervisionados FROM employee
GROUP BY ssn_supervisor ORDER BY qtd_supervisionados;

-- Q4
SELECT e.fname AS nome_supervisor, COUNT(s.superssn) AS qtd_supervisionados
FROM employee AS e JOIN employee AS s ON s.superssn = e.ssn 
GROUP BY e.fname ORDER BY qtd_supervisionados;

-- Q5
SELECT e.fname AS nome_supervisor, COUNT(s.ssn) AS qtd_supervisionados
FROM employee AS s LEFT JOIN employee AS e ON s.superssn = e.ssn
GROUP BY e.fname ORDER BY qtd_supervisionados;

-- Q6
SELECT MIN(qtd) AS qtd FROM (SELECT COUNT(*) AS qtd FROM works_on GROUP BY works_on.pno) AS sel;

-- Q7 TA ERRADA
SELECT num_projeto, MIN(qtd) AS qtd FROM
(SELECT w.pno AS num_projeto, COUNT(*) AS qtd FROM works_on AS w GROUP BY num_projeto) AS foo
GROUP BY num_projeto, MIN(qtd);

-- Q8
SELECT p.pnumber AS proj_num, AVG(e.salary) AS media_sal
FROM project AS p, works_on AS w, employee AS e 
WHERE(p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

-- Q9
SELECT p.pnumber AS num_projeto, p.pname AS proj_nome, AVG(e.salary) 
AS media_sal FROM project AS p, works_on AS w,
employee AS e WHERE(p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

-- Q10
SELECT emp.fname, emp.salary FROM employee AS emp, (SELECT MAX(e.salary) AS s FROM employee AS e, works_on AS w 
WHERE (w.pno = 92 AND w.essn = e.ssn)) AS foo WHERE emp.salary > foo.s;

-- Q11
SELECT e.ssn, COUNT(w.essn) AS qtd_proj FROM employee AS e FULL OUTER JOIN works_on AS w ON (w.essn = e.ssn)
GROUP BY e.ssn ORDER BY qtd_proj;

-- Q12
SELECT * FROM (SELECT w.pno AS num_proj, COUNT(e.ssn) AS qtd_func FROM employee AS e FULL OUTER JOIN
works_on AS w ON (w.essn = e.ssn) GROUP BY w.pno) AS se WHERE se.qtd_func < 5 ORDER BY qtd_func;

-- Q13
SELECT DISTINCT e.fname FROM employee AS e, works_on AS w, dependent AS d,
(SELECT * FROM project AS p WHERE p.plocation LIKE '%Sugarland%') AS foo
WHERE (d.essn = e.ssn AND w.essn = e.ssn AND w.pno = foo.pnumber);

-- Q15 TA ERRADA
SELECT DISTINCT e.fname, e.lname FROM employee AS e, works_on as w JOIN
    works_on AS w WHERE w.essn = '123456789') AS foo
    ON foo.pno = w.pno;