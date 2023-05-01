CREATE OR REPLACE FORCE EDITIONABLE VIEW "MANAGER_DESIGNATION_SALARY_VIEW" ("DESIGNATIONSALARYID", "DEPARTMENTID", "DEPARTMENTNAME", "DESIGNATION", "BASESALARY") AS 
SELECT ds.DesignationSalaryID, ds.DepartmentID, d.DepartmentName, ds.Designation, ds.BaseSalary
FROM designation_salary ds
JOIN department d ON ds.DepartmentID = d.DepartmentID
JOIN employee e ON d.DepartmentID = e.DepartmentID
JOIN user_account ua ON e.UserID = ua.UserID
WHERE UPPER(ua.Username) = UPPER(apex_current_username()) AND ua.Role = 'Manager';