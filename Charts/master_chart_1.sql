SELECT c.CompanyName, ua.Role, ua.Status, COUNT(ua.UserID) AS UserCount
FROM user_account ua
JOIN employee e ON ua.UserID = e.UserID
JOIN company c ON e.CompanyID = c.CompanyID
GROUP BY c.CompanyName, ua.Role, ua.Status
ORDER BY c.CompanyName, ua.Role, ua.Status;
