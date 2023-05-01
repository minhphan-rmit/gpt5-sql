create or replace FUNCTION get_current_user_id(p_app_user IN VARCHAR2)
RETURN VARCHAR2
IS
  current_user_id VARCHAR2(100);
BEGIN
  SELECT UserID
    INTO current_user_id
    FROM user_account
   WHERE UPPER(username) = UPPER(p_app_user);

  RETURN current_user_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN OTHERS THEN
    RETURN NULL;
END;
/