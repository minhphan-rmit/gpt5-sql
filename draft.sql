create or replace FUNCTION get_logged_in_user_department_id
RETURN VARCHAR2
IS
  v_department_id VARCHAR2(20);
BEGIN
  SELECT e.DepartmentID
  INTO v_department_id
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  WHERE UPPER(ua.Username) = UPPER(apex_current_username());

  RETURN v_department_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
END;
/