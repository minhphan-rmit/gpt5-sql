-- RMIT International University Vietnam
-- Course: ISYS3414 - Practical Database Concepts
--
-- General functions
create or replace FUNCTION user_auth ( 
    p_username IN VARCHAR2, 
    p_password IN VARCHAR2 
) RETURN BOOLEAN 
AS 
    lc_pwd_exit VARCHAR2(30); 
    lc_role VARCHAR2(20); 
BEGIN 
    -- Validate whether the user exists or not 
    SELECT 'Active', Role 
    INTO lc_pwd_exit, lc_role 
    FROM user_account 
    WHERE UPPER(Username) = UPPER(p_username) 
    AND UPPER(UserPassword) = UPPER(p_password); 
 
    -- Check the role of the user 
    IF lc_role = 'Admin' OR lc_role = 'Manager' OR lc_role = 'Employee' OR lc_role = 'Master' THEN 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Successful login for user: %s', p_username); 
        RETURN TRUE; 
    ELSE 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Login failed for user: %s', p_username); 
        RETURN FALSE; 
    END IF; 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Login failed for user: %s', p_username); 
        RETURN FALSE; 
    WHEN OTHERS THEN 
        -- Log the error message for debugging purposes 
        APEX_DEBUG.ERROR('Error in admin_auth function: ' || SQLERRM); 
        RETURN FALSE; 
END user_auth; 
/


create or replace FUNCTION apex_current_username RETURN VARCHAR2 IS
  current_username VARCHAR2(100);
BEGIN
  SELECT SYS_CONTEXT('APEX$SESSION', 'APP_USER') INTO current_username FROM DUAL;
  RETURN current_username;
END;
/


create or replace FUNCTION get_current_user_id(p_app_user IN VARCHAR2)
RETURN VARCHAR2
IS
  current_user_id VARCHAR2(100);
BEGIN
  SELECT UserID
    INTO current_user_id
    FROM user_account
   WHERE UPPER(username) = UPPER(p_app_user);

  RETURN current_user_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN OTHERS THEN
    RETURN NULL;
END;
/


create or replace FUNCTION get_logged_in_user_company_id
RETURN INTEGER
IS
  v_app_user VARCHAR2(50) := apex_current_username;
  v_company_id VARCHAR2;
BEGIN
  SELECT e.CompanyID
  INTO v_company_id
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  WHERE UPPER(ua.Username) = UPPER(v_app_user);

  RETURN v_company_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/


create or replace FUNCTION get_user_info(p_userid IN NUMBER, p_info_type IN VARCHAR2) RETURN VARCHAR2 IS
  v_result VARCHAR2(4000);
BEGIN
  SELECT CASE p_info_type
           WHEN 'FirstName' THEN ua.FirstName
           WHEN 'LastName' THEN ua.LastName
           WHEN 'Email' THEN ua.Email
           WHEN 'Phone' THEN ua.Phone
           WHEN 'DateOfBirth' THEN TO_CHAR(ua.DateOfBirth, 'DD-MON-YYYY')
           WHEN 'Gender' THEN ua.Gender
           WHEN 'Role' THEN ua.Role
           WHEN 'Status' THEN ua.Status
           WHEN 'Department' THEN d.DepartmentName
           WHEN 'Company' THEN c.CompanyName
           ELSE NULL
         END
  INTO v_result
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  JOIN department d ON e.DepartmentID = d.DepartmentID
  JOIN company c ON e.CompanyID = c.CompanyID
  WHERE ua.UserID = p_userid;

  RETURN v_result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/


create or replace FUNCTION get_logged_in_user_department_id
RETURN VARCHAR2
IS
  v_department_id VARCHAR2(20);
BEGIN
  SELECT e.DepartmentID
  INTO v_department_id
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  WHERE UPPER(ua.Username) = UPPER(apex_current_username());

  RETURN v_department_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
END;
/


-- Master Queries
SELECT * FROM user_account;
INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (<UserID>, '<Username>', '<UserPassword>', '<Email>', '<Phone>', TO_DATE('<DateOfBirth>', 'YYYY-MM-DD'), '<FirstName>', '<LastName>', '<Gender>', '<Role>', '<Status>');
UPDATE user_account
SET 
  Username = '<NewUsername>',
  UserPassword = '<NewUserPassword>',
  Email = '<NewEmail>',
  Phone = '<NewPhone>',
  DateOfBirth = TO_DATE('<NewDateOfBirth>', 'YYYY-MM-DD'),
  FirstName = '<NewFirstName>',
  LastName = '<NewLastName>',
  Gender = '<NewGender>',
  Role = '<NewRole>',
  Status = '<NewStatus>'
WHERE UserID = <UserID>;
DELETE FROM user_account
WHERE UserID = <UserID>;
SELECT * FROM company;
INSERT INTO company (
  CompanyID, 
  CompanyName, 
  CompanyAddress, 
  country
) VALUES (
  <CompanyID>, 
  '<CompanyName>', 
  '<CompanyAddress>', 
  '<country>'
);
UPDATE company
SET 
  CompanyName = '<NewCompanyName>',
  CompanyAddress = '<NewCompanyAddress>',
  country = '<NewCountry>'
WHERE CompanyID = <CompanyID>;
DELETE FROM company
WHERE CompanyID = <CompanyID>;
SELECT * FROM department;
INSERT INTO department (
  DepartmentID, 
  CompanyID, 
  Budget, 
  DepartmentName
) VALUES (
  <DepartmentID>, 
  <CompanyID>, 
  <Budget>, 
  '<DepartmentName>'
);
UPDATE department
SET 
  CompanyID = <NewCompanyID>,
  Budget = <NewBudget>,
  DepartmentName = '<NewDepartmentName>'
WHERE DepartmentID = <DepartmentID>;);
DELETE FROM company
WHERE DepartmentID = <DepartmentID>;
SELECT * FROM employee;
INSERT INTO employee (
  EmployeeID, 
  UserID, 
  DepartmentID, 
  Designation, 
  HireDate, 
  CompanyID
) VALUES (
  <EmployeeID>, 
  <UserID>, 
  <DepartmentID>, 
  '<Designation>', 
  TO_DATE('<HireDate>', 'YYYY-MM-DD'),
  <CompanyID>
);
UPDATE employee
SET 
  UserID = <NewUserID>,
  DepartmentID = <NewDepartmentID>,
  Designation = '<NewDesignation>',
  HireDate = TO_DATE('<NewHireDate>', 'YYYY-MM-DD'),
  CompanyID = <NewCompanyID>
WHERE EmployeeID = <EmployeeID>;
DELETE FROM employee
WHERE EmployeeID = <EmployeeID>;
SELECT * FROM designation_salary;
INSERT INTO designation_salary (
  DesignationSalaryID, 
  DepartmentID, 
  Designation, 
  BaseSalary
) VALUES (
  <DesignationSalaryID>, 
  <DepartmentID>, 
  '<Designation>', 
  <BaseSalary>
);
UPDATE designation_salary
SET 
  DepartmentID = <NewDepartmentID>,
  Designation = '<NewDesignation>',
  BaseSalary = <NewBaseSalary>
WHERE DesignationSalaryID = <DesignationSalaryID>;
DELETE FROM designation_salary
WHERE DesignationSalaryID = <DesignationSalaryID>;
SELECT * FROM salary_summary;
INSERT INTO salary_summary (
  SalarySummaryID, 
  EmployeeID, 
  PaymentDate, 
  BaseSalary, 
  NetSalary, 
  TaxDeduction, 
  TotalSavings, 
  CTCSalary
) VALUES (
  <SalarySummaryID>, 
  <EmployeeID>, 
  TO_DATE('<PaymentDate>', 'YYYY-MM-DD'), 
  <BaseSalary>, 
  <NetSalary>, 
  <TaxDeduction>, 
  <TotalSavings>, 
  <CTCSalary>
);
UPDATE salary_summary
SET 
  EmployeeID = <NewEmployeeID>,
  PaymentDate = TO_DATE('<NewPaymentDate>', 'YYYY-MM-DD'),
  BaseSalary = <NewBaseSalary>,
  NetSalary = <NewNetSalary>,
  TaxDeduction = <NewTaxDeduction>,
  TotalSavings = <NewTotalSavings>,
  CTCSalary = <NewCTCSalary>
WHERE SalarySummaryID = <SalarySummaryID>;
DELETE FROM salary_summary
WHERE SalarySummaryID = <SalarySummaryID>;
SELECT * FROM salary_adjustment;
INSERT INTO salary_adjustment (
  AdjustmentID, 
  EmployeeID, 
  AdjustmentDate, 
  AdjustmentAmount, 
  AdjustmentType, 
  Reason
) VALUES (
  <AdjustmentID>, 
  <EmployeeID>, 
  TO_DATE('<AdjustmentDate>', 'YYYY-MM-DD'), 
  <AdjustmentAmount>, 
  '<AdjustmentType>', 
  '<Reason>'
);
UPDATE salary_adjustment
SET 
  EmployeeID = <NewEmployeeID>,
  AdjustmentDate = TO_DATE('<NewAdjustmentDate>', 'YYYY-MM-DD'),
  AdjustmentAmount = <NewAdjustmentAmount>,
  AdjustmentType = '<NewAdjustmentType>',
  Reason = '<NewReason>'
WHERE AdjustmentID = <AdjustmentID>;
DELETE FROM salary_adjustment
WHERE AdjustmentID = <AdjustmentID>;
SELECT * FROM tax_bracket;
INSERT INTO tax_bracket (
  TaxBracketID,
  CompanyID,
  MinIncome,
  MaxIncome,
  TaxRate
) VALUES (
  <TaxBracketID>,
  <CompanyID>,
  <MinIncome>,
  <MaxIncome>,
  <TaxRate>
);
UPDATE tax_bracket
SET
  CompanyID = <NewCompanyID>,
  MinIncome = <NewMinIncome>,
  MaxIncome = <NewMaxIncome>,
  TaxRate = <NewTaxRate>
WHERE TaxBracketID = <TaxBracketID>;
DELETE FROM tax_bracket
WHERE TaxBracketID = <TaxBracketID>;


-- Admin Queries
CREATE OR REPLACE FORCE EDITIONABLE VIEW 
"ADMIN_USER_VIEW" ("USERID", "USERNAME", 
"USERPASSWORD", "EMAIL", "PHONE", "DATEOFBIRTH", "FIRSTNAME", "LASTNAME", "GENDER", "ROLE", 
"STATUS") AS 

  SELECT ua."USERID",ua."USERNAME",
ua."USERPASSWORD",ua."EMAIL",ua."PHONE",
ua."DATEOFBIRTH",ua."FIRSTNAME",u
a."LASTNAME",ua."GENDER",ua."ROLE",ua."STATUS"
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
INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (<UserID>, '<Username>', '<UserPassword>', '<Email>', '<Phone>', TO_DATE('<DateOfBirth>', 'YYYY-MM-DD'), '<FirstName>', '<LastName>', '<Gender>', '<Role>', '<Status>');
UPDATE user_account
SET 
  Username = '<NewUsername>',
  UserPassword = '<NewUserPassword>',
  Email = '<NewEmail>',
  Phone = '<NewPhone>',
  DateOfBirth = TO_DATE('<NewDateOfBirth>', 'YYYY-MM-DD'),
  FirstName = '<NewFirstName>',
  LastName = '<NewLastName>',
  Gender = '<NewGender>',
  Role = '<NewRole>',
  Status = '<NewStatus>'
WHERE UserID = <UserID>;
DELETE FROM user_account
WHERE UserID = <UserID>;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN_COMPANY_VIEW" 
("COMPANYID", "COMPANYNAME", 
"COMPANYADDRESS", "COUNTRY") AS 
  SELECT c."COMPANYID",
c."COMPANYNAME",
c."COMPANYADDRESS",c."COUNTRY"
  FROM company c
  WHERE EXISTS (
    SELECT 1
    FROM employee e
    JOIN user_account ua ON e.UserID = ua.UserID
    WHERE ua.Role = 'Admin'
    AND e.CompanyID = c.CompanyID
    AND UPPER(ua.Username) = UPPER(apex_current_username)
  );
INSERT INTO company (
  CompanyID, 
  CompanyName, 
  CompanyAddress, 
  country
) VALUES (
  <CompanyID>, 
  '<CompanyName>', 
  '<CompanyAddress>', 
  '<country>'
);
UPDATE company
SET 
  CompanyName = '<NewCompanyName>',
  CompanyAddress = '<NewCompanyAddress>',
  country = '<NewCountry>'
WHERE CompanyID = <CompanyID>;
DELETE FROM company
WHERE CompanyID = <CompanyID>;
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
INSERT INTO department (
  DepartmentID, 
  CompanyID, 
  Budget, 
  DepartmentName
) VALUES (
  <DepartmentID>, 
  <CompanyID>, 
  <Budget>, 
  '<DepartmentName>'
);
UPDATE department
SET 
  CompanyID = <NewCompanyID>,
  Budget = <NewBudget>,
  DepartmentName = '<NewDepartmentName>'
WHERE DepartmentID = <DepartmentID>;);
DELETE FROM company
WHERE DepartmentID = <DepartmentID>;
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
INSERT INTO employee (
  EmployeeID, 
  UserID, 
  DepartmentID, 
  Designation, 
  HireDate, 
  CompanyID
) VALUES (
  <EmployeeID>, 
  <UserID>, 
  <DepartmentID>, 
  '<Designation>', 
  TO_DATE('<HireDate>', 'YYYY-MM-DD'),
  <CompanyID>
);
UPDATE employee
SET 
  UserID = <NewUserID>,
  DepartmentID = <NewDepartmentID>,
  Designation = '<NewDesignation>',
  HireDate = TO_DATE('<NewHireDate>', 'YYYY-MM-DD'),
  CompanyID = <NewCompanyID>
WHERE EmployeeID = <EmployeeID>;
DELETE FROM employee
WHERE EmployeeID = <EmployeeID>;
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


-- Manager Queries
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
INSERT INTO employee (
  EmployeeID, 
  UserID, 
  DepartmentID, 
  Designation, 
  HireDate, 
  CompanyID
) VALUES (
  <EmployeeID>, 
  <UserID>, 
  <DepartmentID>, 
  '<Designation>', 
  TO_DATE('<HireDate>', 'YYYY-MM-DD'),
  <CompanyID>
);
UPDATE employee
SET 
  UserID = <NewUserID>,
  DepartmentID = <NewDepartmentID>,
  Designation = '<NewDesignation>',
  HireDate = TO_DATE('<NewHireDate>', 'YYYY-MM-DD'),
  CompanyID = <NewCompanyID>
WHERE EmployeeID = <EmployeeID>;
DELETE FROM employee
WHERE EmployeeID = <EmployeeID>;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MANAGER_DESIGNATION_SALARY_VIEW" ("DESIGNATIONSALARYID", "DEPARTMENTID", "DEPARTMENTNAME", "DESIGNATION", "BASESALARY") AS 
SELECT ds.DesignationSalaryID, ds.DepartmentID, d.DepartmentName, ds.Designation, ds.BaseSalary
FROM designation_salary ds
JOIN department d ON ds.DepartmentID = d.DepartmentID
JOIN employee e ON d.DepartmentID = e.DepartmentID
JOIN user_account ua ON e.UserID = ua.UserID
WHERE UPPER(ua.Username) = UPPER(apex_current_username()) AND ua.Role = 'Manager';
INSERT INTO designation_salary (
  DesignationSalaryID, 
  DepartmentID, 
  Designation, 
  BaseSalary
) VALUES (
  <DesignationSalaryID>, 
  <DepartmentID>, 
  '<Designation>', 
  <BaseSalary>
);
UPDATE designation_salary
SET 
  DepartmentID = <NewDepartmentID>,
  Designation = '<NewDesignation>',
  BaseSalary = <NewBaseSalary>
WHERE DesignationSalaryID = <DesignationSalaryID>;
DELETE FROM designation_salary
WHERE DesignationSalaryID = <DesignationSalaryID>;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MANAGER_SALARY_ADJUSTMENT_VIEW" ("EMPLOYEEID", "EMPLOYEENAME", "ADJUSTMENTID", "ADJUSTMENTDATE", "ADJUSTMENTAMOUNT", "ADJUSTMENTTYPE", "REASON") AS 
  SELECT
  emp_e.EmployeeID AS EmployeeID,
  ua_e.FirstName || ' ' || ua_e.LastName AS EmployeeName,
  sa.AdjustmentID,
  sa.AdjustmentDate,
  sa.AdjustmentAmount,
  sa.AdjustmentType,
  sa.Reason
FROM
  employee emp_m
  JOIN employee emp_e ON emp_m.DepartmentID = emp_e.DepartmentID
  JOIN salary_adjustment sa ON emp_e.EmployeeID = sa.EmployeeID
  JOIN user_account ua ON emp_m.UserID = ua.UserID
  JOIN user_account ua_e ON emp_e.UserID = ua_e.UserID
WHERE
  UPPER(ua.Username) = UPPER(apex_current_username())
  AND ua.Role = 'Manager';
INSERT INTO salary_adjustment (
  AdjustmentID, 
  EmployeeID, 
  AdjustmentDate, 
  AdjustmentAmount, 
  AdjustmentType, 
  Reason
) VALUES (
  <AdjustmentID>, 
  <EmployeeID>, 
  TO_DATE('<AdjustmentDate>', 'YYYY-MM-DD'), 
  <AdjustmentAmount>, 
  '<AdjustmentType>', 
  '<Reason>'
);
UPDATE salary_adjustment
SET 
  EmployeeID = <NewEmployeeID>,
  AdjustmentDate = TO_DATE('<NewAdjustmentDate>', 'YYYY-MM-DD'),
  AdjustmentAmount = <NewAdjustmentAmount>,
  AdjustmentType = '<NewAdjustmentType>',
  Reason = '<NewReason>'
WHERE AdjustmentID = <AdjustmentID>;
DELETE FROM salary_adjustment
WHERE AdjustmentID = <AdjustmentID>;


-- Employee Queries
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "EMPLOYEE_SALARY_VIEW" ("USERID", "EMPLOYEEID", "EMPLOYEENAME", "PAYMENTDATE", "BASESALARY", "FORMATTEDBASESALARY", "INCREMENTAMOUNT", "DEDUCTIONAMOUNT", "TAXDEDUCTION", "ADJUSTEDSALARY", "NETSALARY", "CTCSALARY", "TOTALSAVINGS") AS 
  WITH IncrementDeduction AS (
SELECT e.EmployeeID,
SUM(CASE
WHEN sa.AdjustmentType = 'Increment' THEN sa.AdjustmentAmount
ELSE 0
END) AS IncrementAmount,
SUM(CASE
WHEN sa.AdjustmentType = 'Deduction' THEN sa.AdjustmentAmount
ELSE 0
END) AS DeductionAmount
FROM employee e
LEFT JOIN salary_adjustment sa ON e.EmployeeID = sa.EmployeeID
WHERE sa.AdjustmentDate BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) AND TRUNC(SYSDATE, 'MM')
GROUP BY e.EmployeeID
),
TempAdjustedSalary AS (
SELECT e.EmployeeID,
ds.BaseSalary + COALESCE(id.IncrementAmount, 0) - COALESCE(id.DeductionAmount, 0) AS AdjustedSalary
FROM employee e
JOIN designation_salary ds ON e.DepartmentID = ds.DepartmentID AND e.Designation = ds.Designation
LEFT JOIN IncrementDeduction id ON e.EmployeeID = id.EmployeeID
),
TaxDeduction AS (
SELECT e.EmployeeID,
SUM(tas.AdjustedSalary * tb.TaxRate / 100) AS TotalTax
FROM employee e
JOIN TempAdjustedSalary tas ON e.EmployeeID = tas.EmployeeID
JOIN tax_bracket tb ON e.CompanyID = tb.CompanyID
WHERE tas.AdjustedSalary BETWEEN tb.MinIncome AND tb.MaxIncome
GROUP BY e.EmployeeID
),
PastNetSalary AS (
SELECT EmployeeID,
SUM(NetSalary) AS TotalPastNetSalary
FROM salary_summary
GROUP BY EmployeeID
)
SELECT ua.UserID,
e.EmployeeID,
ua.FirstName || ' ' || ua.LastName AS EmployeeName,
ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1) + 4 AS PaymentDate,
ds.BaseSalary,
TO_CHAR(ds.BaseSalary, '999,999,999') AS FormattedBaseSalary,
COALESCE(id.IncrementAmount, 0) AS IncrementAmount,
COALESCE(id.DeductionAmount, 0) AS DeductionAmount,
COALESCE(td.TotalTax, 0) AS TaxDeduction,
TO_CHAR(tas.AdjustedSalary, '999,999,999') AS AdjustedSalary,
TO_CHAR((tas.AdjustedSalary - COALESCE(td.TotalTax, 0)), '999,999,999') AS NetSalary,
TO_CHAR((ds.BaseSalary + 500), '999,999,999') AS CTCSalary,
(tas.AdjustedSalary - COALESCE(td.TotalTax, 0)) + COALESCE(pns.TotalPastNetSalary, 0) AS TotalSavings
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN designation_salary ds ON e.DepartmentID = ds.DepartmentID AND e.Designation = ds.Designation
LEFT JOIN IncrementDeduction id ON e.EmployeeID = id.EmployeeID
LEFT JOIN TempAdjustedSalary tas ON e.EmployeeID = tas.EmployeeID
LEFT JOIN TaxDeduction td ON e.EmployeeID = td.EmployeeID
LEFT JOIN PastNetSalary pns ON e.EmployeeID = pns.EmployeeID;


create or replace PROCEDURE process_salary_summary AS
BEGIN
  INSERT INTO salary_summary (EmployeeID, PaymentDate, BaseSalary, NetSalary, TaxDeduction, TotalSavings, CTCSalary)
  SELECT EmployeeID, 
         PaymentDate, 
         TO_NUMBER(BaseSalary), 
         TO_NUMBER(NetSalary), 
         TaxDeduction, 
         TotalSavings, 
         TO_NUMBER(CTCSalary)
  FROM EMPLOYEE_SALARY_VIEW
  WHERE PaymentDate = TRUNC(SYSDATE);

  COMMIT;
END process_salary_summary;
/


BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'PROCESS_SALARY_SUMMARY_JOB',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN process_salary_summary; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY;BYHOUR=0;',
    enabled         => TRUE,
    comments        => 'Job to process salary summary daily'
  );
END;
/


CREATE OR REPLACE FORCE EDITIONABLE VIEW "EMPLOYEE_ADJUSTMENT_VIEW" ("USERID", "EMPLOYEEID", "EMPLOYEENAME", "ADJUSTMENTID", "ADJUSTMENTDATE", "ADJUSTMENTAMOUNT", "ADJUSTMENTTYPE", "REASON") AS 
  SELECT ua.UserID,
       e.EmployeeID,
       ua.FirstName || ' ' || ua.LastName AS EmployeeName,
       sa.AdjustmentID,
       sa.AdjustmentDate,
       sa.AdjustmentAmount,
       sa.AdjustmentType,
       sa.Reason
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN salary_adjustment sa ON e.EmployeeID = sa.EmployeeID;


-- Charts
-- Chart: User Activity by Role and Company
SELECT c.CompanyName, ua.Role, ua.Status, COUNT(ua.UserID) AS UserCount
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN company c ON e.CompanyID = c.CompanyID
GROUP BY c.CompanyName, ua.Role, ua.Status
ORDER BY c.CompanyName, ua.Role, ua.Status;


-- Chart: Department Budget Distribution
SELECT c.CompanyName, d.DepartmentName, d.Budget
FROM department d
JOIN company c ON d.CompanyID = c.CompanyID
ORDER BY c.CompanyName, d.Budget DESC;


-- Chart: Average Salary by Designation and Department
SELECT c.CompanyName, d.DepartmentName, ds.Designation, AVG(ds.BaseSalary) AS AvgSalary
FROM designation_salary ds
JOIN department d ON ds.DepartmentID = d.DepartmentID
JOIN company c ON d.CompanyID = c.CompanyID
GROUP BY c.CompanyName, d.DepartmentName, ds.Designation
ORDER BY c.CompanyName, d.DepartmentName, AvgSalary DESC;


-- Chart: Salary Adjustments by Reason and Type
SELECT sa.AdjustmentType, sa.Reason, COUNT(sa.AdjustmentID) AS AdjustmentCount
FROM salary_adjustment sa
GROUP BY sa.AdjustmentType, sa.Reason
ORDER BY AdjustmentCount DESC;


-- Chart: Tax Rate Distribution
SELECT c.CompanyName, tb.MinIncome, tb.MaxIncome, tb.TaxRate
FROM tax_bracket tb
JOIN company c ON tb.CompanyID = c.CompanyID
ORDER BY c.CompanyName, tb.MinIncome;

--Chart: Net Salary Growth Over Time (Employee)
SELECT
  TO_CHAR(ss.PaymentDate, 'YYYY-MM') AS PaymentMonthYear,
  SUM(ss.NetSalary) AS NetSalarySum
FROM
  user_account ua
  INNER JOIN employee e ON ua.UserID = e.UserID
  INNER JOIN salary_summary ss ON e.EmployeeID = ss.EmployeeID
WHERE
  UPPER(ua.Username) = UPPER(apex_current_username())
GROUP BY
  TO_CHAR(ss.PaymentDate, 'YYYY-MM')
ORDER BY
  PaymentMonthYear;


--Employee's salary adjustments (increments and deductions) over time (Employee)
SELECT
  TO_CHAR(sa.AdjustmentDate, 'YYYY-MM') AS AdjustmentMonthYear,
  sa.AdjustmentType,
  SUM(sa.AdjustmentAmount) AS TotalAdjustmentAmount
FROM
  user_account ua
  INNER JOIN employee e ON ua.UserID = e.UserID
  INNER JOIN salary_adjustment sa ON e.EmployeeID = sa.EmployeeID
WHERE
  UPPER(ua.Username) = UPPER(apex_current_username())
GROUP BY
  TO_CHAR(sa.AdjustmentDate, 'YYYY-MM'),
  sa.AdjustmentType
ORDER BY
  AdjustmentMonthYear;


-- Employees in Department (Admin)
SELECT d.DepartmentName, COUNT(e.EmployeeID) as NumberOfEmployees
FROM department d
JOIN employee e ON d.DepartmentID = e.DepartmentID
JOIN company c ON e.CompanyID = c.CompanyID
WHERE c.CompanyID = get_logged_in_user_company_id
GROUP BY d.DepartmentName;


-- Department Average Salary (Admin)
SELECT d.DepartmentName, AVG(ds.BaseSalary) as AverageSalary
FROM department d
JOIN employee e ON d.DepartmentID = e.DepartmentID
JOIN designation_salary ds ON e.Designation = ds.Designation AND e.DepartmentID = ds.DepartmentID
JOIN company c ON d.CompanyID = c.CompanyID
WHERE c.CompanyID = get_logged_in_user_company_id
GROUP BY d.DepartmentName;


-- Gender Distribution (Admin)
SELECT ua.Gender, COUNT(e.EmployeeID) as NumberOfEmployees
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN company c on e.companyid = c.companyID
WHERE c.CompanyID = get_logged_in_user_company_id
GROUP BY ua.Gender;


--Department Salary Distribution (Manager)
SELECT ds.Designation, AVG(ds.BaseSalary) as AverageSalary
FROM designation_salary ds
WHERE ds.DepartmentID = (
  SELECT emp.DepartmentID
  FROM employee emp
  JOIN user_account ua ON ua.UserID = emp.UserID
  WHERE UPPER(ua.Username) = UPPER(:APP_USER)
)
GROUP BY ds.Designation;


-- Gender distribution of employees in the department(Manager)
SELECT ua.Gender, COUNT(e.EmployeeID) as NumberOfEmployees
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
WHERE e.DepartmentID = (
  SELECT emp.DepartmentID
  FROM employee emp
  JOIN user_account ua ON ua.UserID = emp.UserID
  WHERE UPPER(ua.Username) = UPPER(:APP_USER)
)
GROUP BY ua.Gender;
