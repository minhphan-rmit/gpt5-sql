  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_EMPLOYEE_VIEW" ("EMPLOYEEID", "USERID", "DEPARTMENTID", "DESIGNATION", "HIREDATE", "COMPANYID", "FIRSTNAME", "LASTNAME") AS 
  SELECT e.EmployeeID, e.UserID, e.DepartmentID, e.Designation, e.HireDate, e.CompanyID,
         ua.FirstName, ua.LastName
  FROM employee e
  JOIN user_account ua ON e.UserID = ua.UserID
  WHERE EXISTS (
    SELECT 1
    FROM employee e_admin
    JOIN user_account ua_admin ON e_admin.UserID = ua_admin.UserID
    WHERE ua_admin.Role = 'Admin'
    AND e_admin.CompanyID = e.CompanyID
    AND UPPER(ua_admin.Username) = UPPER(apex_current_username)
  );