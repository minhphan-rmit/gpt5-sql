UPDATE user_account
SET 
  Username = '<NewUsername>',
  UserPassword = '<NewUserPassword>',
  Email = '<NewEmail>',
  Phone = '<NewPhone>',
  DateOfBirth = TO_DATE('<NewDateOfBirth>', 'YYYY-MM-DD'),
  FirstName = '<NewFirstName>',
  LastName = '<NewLastName>',
  Gender = '<NewGender>',
  Role = '<NewRole>',
  Status = '<NewStatus>'
WHERE UserID = <UserID>;
