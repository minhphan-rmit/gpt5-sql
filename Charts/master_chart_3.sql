SELECT c.CompanyName, d.DepartmentName, ds.Designation, AVG(ds.BaseSalary) AS AvgSalary
FROM designation_salary ds
JOIN department d ON ds.DepartmentID = d.DepartmentID
JOIN company c ON d.CompanyID = c.CompanyID
GROUP BY c.CompanyName, d.DepartmentName, ds.Designation
ORDER BY c.CompanyName, d.DepartmentName, AvgSalary DESC;
