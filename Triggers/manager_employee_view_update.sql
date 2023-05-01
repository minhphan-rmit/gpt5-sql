create or replace TRIGGER manager_employee_view_update
INSTEAD OF UPDATE ON manager_employee_view
FOR EACH ROW
BEGIN
  UPDATE user_account
  SET Username = :NEW.Username,
      Email = :NEW.Email,
      Phone = :NEW.Phone,
      DateOfBirth = :NEW.DateOfBirth,
      FirstName = :NEW.FirstName,
      LastName = :NEW.LastName,
      Gender = :NEW.Gender,
      Role = :NEW.Role,
      Status = :NEW.Status
  WHERE UserID = :OLD.UserID;

  UPDATE employee
  SET Designation = :NEW.Designation,
      DepartmentID = (
        SELECT DepartmentID
        FROM department
        WHERE DepartmentName = :NEW.DepartmentName
      )
  WHERE EmployeeID = :OLD.EmployeeID;
END;
/