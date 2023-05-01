  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_COMPANY_VIEW" ("COMPANYID", "COMPANYNAME", "COMPANYADDRESS", "COUNTRY") AS 
  SELECT c."COMPANYID",c."COMPANYNAME",c."COMPANYADDRESS",c."COUNTRY"
  FROM company c
  WHERE EXISTS (
    SELECT 1
    FROM employee e
    JOIN user_account ua ON e.UserID = ua.UserID
    WHERE ua.Role = 'Admin'
    AND e.CompanyID = c.CompanyID
    AND UPPER(ua.Username) = UPPER(apex_current_username)
  );