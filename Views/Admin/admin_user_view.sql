  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_USER_VIEW" ("USERID", "USERNAME", "USERPASSWORD", "EMAIL", "PHONE", "DATEOFBIRTH", "FIRSTNAME", "LASTNAME", "GENDER", "ROLE", "STATUS") AS 
  SELECT ua."USERID",ua."USERNAME",ua."USERPASSWORD",ua."EMAIL",ua."PHONE",ua."DATEOFBIRTH",ua."FIRSTNAME",ua."LASTNAME",ua."GENDER",ua."ROLE",ua."STATUS"
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  WHERE EXISTS (
    SELECT 1
    FROM employee e_admin
    JOIN user_account ua_admin ON e_admin.UserID = ua_admin.UserID
    WHERE ua_admin.Role = 'Admin'
    AND e_admin.CompanyID = e.CompanyID
    AND UPPER(ua_admin.Username) = UPPER(apex_current_username)
  );