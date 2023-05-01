create or replace TRIGGER manager_employee_view_delete
INSTEAD OF DELETE ON manager_employee_view
FOR EACH ROW
BEGIN
  DELETE FROM employee
  WHERE EmployeeID = :OLD.EmployeeID;

  DELETE FROM user_account
  WHERE UserID = :OLD.UserID;
END;
/