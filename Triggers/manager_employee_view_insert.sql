create or replace TRIGGER manager_employee_view_insert
INSTEAD OF INSERT ON manager_employee_view
FOR EACH ROW
BEGIN
  INSERT INTO user_account (UserID, Username, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
  VALUES (:NEW.UserID, :NEW.Username, :NEW.Email, :NEW.Phone, :NEW.DateOfBirth, :NEW.FirstName, :NEW.LastName, :NEW.Gender, 'Employee', :NEW.Status);

  INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation)
  VALUES (:NEW.EmployeeID, :NEW.UserID, (
    SELECT DepartmentID
    FROM department
    WHERE DepartmentName = :NEW.DepartmentName
  ), :NEW.Designation);
END;
/