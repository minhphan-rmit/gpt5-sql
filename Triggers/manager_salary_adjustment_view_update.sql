create or replace TRIGGER manager_salary_adjustment_view_update
INSTEAD OF UPDATE ON manager_salary_adjustment_view
FOR EACH ROW
BEGIN
  UPDATE salary_adjustment
  SET
    AdjustmentDate = :NEW.ADJUSTMENTDATE,
    AdjustmentAmount = :NEW.ADJUSTMENTAMOUNT,
    AdjustmentType = :NEW.ADJUSTMENTTYPE,
    Reason = :NEW.REASON
  WHERE AdjustmentID = :OLD.ADJUSTMENTID;
END;
/