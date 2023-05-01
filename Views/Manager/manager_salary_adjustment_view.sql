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