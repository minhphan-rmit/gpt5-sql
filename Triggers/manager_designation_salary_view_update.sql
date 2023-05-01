create or replace TRIGGER manager_designation_salary_view_update
INSTEAD OF UPDATE ON manager_designation_salary_view
FOR EACH ROW
BEGIN
  UPDATE designation_salary
  SET DepartmentID = :NEW.DepartmentID,
      Designation = :NEW.Designation,
      BaseSalary = :NEW.BaseSalary
  WHERE DesignationSalaryID = :OLD.DesignationSalaryID;
END;
/