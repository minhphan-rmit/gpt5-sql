CREATE OR REPLACE FORCE EDITIONABLE VIEW "MANAGER_EMPLOYEE_VIEW" ("USERID", "USERNAME", "EMAIL", "PHONE", "DATEOFBIRTH", "FIRSTNAME", "LASTNAME", "GENDER", "ROLE", "STATUS", "EMPLOYEEID", "DESIGNATION", "DEPARTMENTNAME") AS 
SELECT ua.UserID, ua.Username, ua.Email, ua.Phone, ua.DateOfBirth, ua.FirstName, ua.LastName, ua.Gender, ua.Role, ua.Status, e.EmployeeID, e.Designation, d.DepartmentName
FROM user_account ua
INNER JOIN employee e ON ua.UserID = e.UserID
INNER JOIN department d ON e.DepartmentID = d.DepartmentID
WHERE ua.Role = 'Employee' AND ua.Status = 'Active' AND e.CompanyID IN (
  SELECT e.CompanyID
  FROM employee e
  INNER JOIN user_account ua ON e.UserID = ua.UserID
  WHERE UPPER(ua.Username) = UPPER(apex_current_username()) 
) AND d.DepartmentID = (
  SELECT e.DepartmentID
  FROM employee e
  INNER JOIN user_account ua ON e.UserID = ua.UserID
  WHERE UPPER(ua.Username) = UPPER(apex_current_username()) 
)
ORDER BY e.EmployeeID ASC;