create or replace FUNCTION get_logged_in_user_company_id
RETURN INTEGER
IS
  v_app_user VARCHAR2(50) := apex_current_username;
  v_company_id INTEGER;
BEGIN
  SELECT e.CompanyID
  INTO v_company_id
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  WHERE UPPER(ua.Username) = UPPER(v_app_user);

  RETURN v_company_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/