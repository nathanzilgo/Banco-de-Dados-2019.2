SELECT e.fname as fname FROM employee AS e WHERE substring(e.address, length(e.address) - 1, length(e.address)) != 'TX' AND (SELECT COUNT(*) FROM employee WHERE employee.superssn=e.ssn AND substring(employee.address, length(employee.address) - 1, length(employee.address)) = 'TX') > 0;