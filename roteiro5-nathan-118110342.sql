-- Banco de Dados 2019.2 - ROTEIRO 4
-- Professor: Cláudio Campelo
-- Aluno: Nathan Fernandes
-- ssh -o ServerAliveInterval=30 nathan@150.165.15.11 -p 45600

-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND substring(address, length(address)-1, length(address)) = 'TX';