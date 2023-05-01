create or replace FUNCTION user_auth ( 
    p_username IN VARCHAR2, 
    p_password IN VARCHAR2 
) RETURN BOOLEAN 
AS 
    lc_pwd_exit VARCHAR2(30); 
    lc_role VARCHAR2(20); 
BEGIN 
    -- Validate whether the user exists or not 
    SELECT 'Active', Role 
    INTO lc_pwd_exit, lc_role 
    FROM user_account 
    WHERE UPPER(Username) = UPPER(p_username) 
    AND UPPER(UserPassword) = UPPER(p_password); 
 
    -- Check the role of the user 
    IF lc_role = 'Admin' OR lc_role = 'Manager' OR lc_role = 'Employee' OR lc_role = 'Master' THEN 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Successful login for user: %s', p_username); 
        RETURN TRUE; 
    ELSE 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Login failed for user: %s', p_username); 
        RETURN FALSE; 
    END IF; 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        -- Debugging message 
        APEX_DEBUG.MESSAGE('Login failed for user: %s', p_username); 
        RETURN FALSE; 
    WHEN OTHERS THEN 
        -- Log the error message for debugging purposes 
        APEX_DEBUG.ERROR('Error in admin_auth function: ' || SQLERRM); 
        RETURN FALSE; 
END user_auth; 
/