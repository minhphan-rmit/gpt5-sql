create or replace TRIGGER manager_salary_adjustment_view_insert
INSTEAD OF INSERT ON manager_salary_adjustment_view
FOR EACH ROW
BEGIN
  INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
  VALUES (:NEW.ADJUSTMENTID, :NEW.EMPLOYEEID, :NEW.ADJUSTMENTDATE, :NEW.ADJUSTMENTAMOUNT, :NEW.ADJUSTMENTTYPE, :NEW.REASON);
END;
/