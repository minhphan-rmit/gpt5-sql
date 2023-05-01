create or replace FUNCTION apex_current_username RETURN VARCHAR2 IS
  current_username VARCHAR2(100);
BEGIN
  SELECT SYS_CONTEXT('APEX$SESSION', 'APP_USER') INTO current_username FROM DUAL;
  RETURN current_username;
END;
/