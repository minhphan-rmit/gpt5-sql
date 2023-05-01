  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_MANAGER_VIEW" ("USERID", "USERNAME", "EMAIL", "PHONE", "FIRSTNAME", "LASTNAME", "GENDER", "EMPLOYEEID", "DESIGNATION", "DEPARTMENTNAME", "COMPANYNAME") AS 
  SELECT ua.UserID, ua.Username, ua.Email, ua.Phone, ua.FirstName, ua.LastName, ua.Gender, e.EmployeeID, e.Designation, d.DepartmentName, c.CompanyName
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN department d ON e.DepartmentID = d.DepartmentID
JOIN company c ON e.CompanyID = c.CompanyID
WHERE ua.Role = 'Manager' AND c.CompanyID IN (
  SELECT ec.CompanyID
  FROM user_account uac
  JOIN employee ec ON uac.UserID = ec.UserID
  WHERE uac.Role = 'Admin'
  AND UPPER(uac.Username) = UPPER(apex_current_username)
);