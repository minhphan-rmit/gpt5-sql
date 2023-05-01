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