SELECT c.CompanyName, d.DepartmentName, d.Budget
FROM department d
JOIN company c ON d.CompanyID = c.CompanyID
ORDER BY c.CompanyName, d.Budget DESC;
