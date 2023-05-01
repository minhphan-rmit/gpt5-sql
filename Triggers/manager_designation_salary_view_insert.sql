create or replace TRIGGER manager_designation_salary_view_insert
INSTEAD OF INSERT ON manager_designation_salary_view
FOR EACH ROW
BEGIN
  INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
  VALUES (:NEW.DesignationSalaryID, :NEW.DepartmentID, :NEW.Designation, :NEW.BaseSalary);
END;
/