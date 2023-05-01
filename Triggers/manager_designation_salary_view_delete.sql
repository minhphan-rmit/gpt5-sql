create or replace TRIGGER manager_designation_salary_view_delete
INSTEAD OF DELETE ON manager_designation_salary_view
FOR EACH ROW
BEGIN
  DELETE FROM designation_salary
  WHERE DesignationSalaryID = :OLD.DesignationSalaryID;
END;
/