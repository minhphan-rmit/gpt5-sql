create or replace TRIGGER manager_salary_adjustment_view_delete
INSTEAD OF DELETE ON manager_salary_adjustment_view
FOR EACH ROW
BEGIN
  DELETE FROM salary_adjustment WHERE AdjustmentID = :OLD.ADJUSTMENTID;
END;
/