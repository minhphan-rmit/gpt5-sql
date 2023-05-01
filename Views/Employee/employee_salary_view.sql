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