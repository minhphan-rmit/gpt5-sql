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