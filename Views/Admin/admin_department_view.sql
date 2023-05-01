  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_DEPARTMENT_VIEW" ("DEPARTMENTID", "COMPANYID", "BUDGET", "DEPARTMENTNAME") AS 
  SELECT d.DepartmentID, d.CompanyID, d.Budget, d.DepartmentName
  FROM department d
  WHERE EXISTS (
    SELECT 1
    FROM employee e
    JOIN user_account ua ON e.UserID = ua.UserID
    WHERE ua.Role = 'Admin'
    AND e.CompanyID = d.CompanyID
    AND UPPER(ua.Username) = UPPER(apex_current_username)
  );