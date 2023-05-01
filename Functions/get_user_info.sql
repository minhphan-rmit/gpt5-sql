create or replace FUNCTION get_user_info(p_userid IN NUMBER, p_info_type IN VARCHAR2) RETURN VARCHAR2 IS
  v_result VARCHAR2(4000);
BEGIN
  SELECT CASE p_info_type
           WHEN 'FirstName' THEN ua.FirstName
           WHEN 'LastName' THEN ua.LastName
           WHEN 'Email' THEN ua.Email
           WHEN 'Phone' THEN ua.Phone
           WHEN 'DateOfBirth' THEN TO_CHAR(ua.DateOfBirth, 'DD-MON-YYYY')
           WHEN 'Gender' THEN ua.Gender
           WHEN 'Role' THEN ua.Role
           WHEN 'Status' THEN ua.Status
           WHEN 'Department' THEN d.DepartmentName
           WHEN 'Company' THEN c.CompanyName
           ELSE NULL
         END
  INTO v_result
  FROM user_account ua
  JOIN employee e ON ua.UserID = e.UserID
  JOIN department d ON e.DepartmentID = d.DepartmentID
  JOIN company c ON e.CompanyID = c.CompanyID
  WHERE ua.UserID = p_userid;

  RETURN v_result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/