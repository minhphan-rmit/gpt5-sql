-- Drop existing tables (if they exist)
DROP TABLE IF EXISTS tax_bracket;
DROP TABLE IF EXISTS salary_summary;
DROP TABLE IF EXISTS salary_adjustment;
DROP TABLE IF EXISTS designation_salary;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS user_account;

-- Create new tables with constraints
-- User Account table
CREATE TABLE user_account (
  UserID integer PRIMARY KEY,
  Username varchar2(50) NOT NULL UNIQUE,
  UserPassword varchar2(255) NOT NULL,
  Email varchar2(350) NOT NULL UNIQUE,
  Phone varchar2(30) UNIQUE,
  DateOfBirth date NOT NULL,
  FirstName varchar2(30) NOT NULL,
  LastName varchar2(30) NOT NULL,
  Gender varchar2(10) CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
  Role varchar2(20) CHECK (Role IN ('Admin', 'Manager', 'Employee','Master')) NOT NULL,
  Status varchar2(20) CHECK (Status IN ('Active', 'In-active')) NOT NULL
);

-- Company table
CREATE TABLE company (
  CompanyID integer PRIMARY KEY,
  CompanyName varchar2(100) NOT NULL UNIQUE,
  CompanyAddress varchar2(255) NOT NULL,
  country varchar2(50) NOT NULL
);


-- Department table
CREATE TABLE department (
  DepartmentID integer PRIMARY KEY,
  CompanyID integer NOT NULL,
  Budget decimal(14, 2) NOT NULL,
  DepartmentName varchar2(50) NOT NULL,
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID),
  UNIQUE (CompanyID, DepartmentName)
);

-- Employee table
CREATE TABLE employee (
  EmployeeID integer PRIMARY KEY,
  UserID integer NOT NULL,
  DepartmentID integer NOT NULL,
  Designation varchar2(50) NOT NULL,
  HireDate date NOT NULL,
  CompanyID integer NOT NULL,
  FOREIGN KEY (UserID) REFERENCES user_account (UserID),
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
);

-- Designation salary
CREATE TABLE designation_salary (
  DesignationSalaryID integer PRIMARY KEY,
  DepartmentID integer NOT NULL,
  Designation varchar2(50) NOT NULL,
  BaseSalary decimal(14, 2) NOT NULL,
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  UNIQUE (DepartmentID, Designation)
);

-- Salary Adjustment table
CREATE TABLE salary_adjustment (
  AdjustmentID integer PRIMARY KEY,
  EmployeeID integer NOT NULL,
  AdjustmentDate date NOT NULL,
  AdjustmentAmount decimal(14, 2) NOT NULL,
  AdjustmentType varchar2(20) NOT NULL CHECK (AdjustmentType IN ('Increment', 'Deduction')),
  Reason varchar2(255),
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);

-- Salary Summary table
CREATE TABLE salary_summary (
  SalarySummaryID integer PRIMARY KEY,
  EmployeeID integer NOT NULL,
  PaymentDate date NOT NULL,
  BaseSalary decimal(14, 2) NOT NULL,
  NetSalary decimal(14, 2) NOT NULL,
  TaxDeduction decimal(14, 2) NOT NULL,
  TotalSavings decimal(14, 2) NOT NULL,
  CTCSalary decimal(14, 2) NOT NULL,
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);

-- Tax Bracket table
CREATE TABLE tax_bracket (
  TaxBracketID integer PRIMARY KEY,
  CompanyID integer NOT NULL,
  MinIncome decimal(14, 2) NOT NULL,
  MaxIncome decimal(14, 2) NOT NULL,
  TaxRate number(5, 2) NOT NULL CHECK (
  TaxRate >= 0
  AND TaxRate <= 100
  ),
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
);


-- Database Population

-- User Account table popluation
INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (1, 'gpt5master', 'master123', 'gpt5@master.com', '1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Male', 'Master', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (2, 'gpt5admin1', 'admin123', 'gpt5@admin.com', '2345678901', TO_DATE('1990-01-02', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Female', 'Admin', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (3, 'gpt5admin2', 'admin123', 'gpt5@rmit.edu.vn', '3456789012', TO_DATE('1990-01-03', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Male', 'Admin', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (4, 'alicesmith', 'password4', 'alicesmith@example.com', '4567890123', TO_DATE('1990-01-04', 'YYYY-MM-DD'), 'Alice', 'Smith', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (5, 'charliebrown', 'password5', 'charliebrown@example.com', '5678901234', TO_DATE('1990-01-05', 'YYYY-MM-DD'), 'Charlie', 'Brown', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (6, 'lucybrown', 'password6', 'lucybrown@example.com', '1982734890125', TO_DATE('1990-01-06', 'YYYY-MM-DD'), 'Lucy', 'Brown', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (7, 'davidjones', 'password7', 'davidjones@example.com', '918723498071236', TO_DATE('1990-01-07', 'YYYY-MM-DD'), 'David', 'Jones', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (8, 'sarahjones', 'password8', 'sarahjones@example.com', '8901234567', TO_DATE('1990-01-08', 'YYYY-MM-DD'), 'Sarah', 'Jones', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (9, 'tomwilson', 'password9', 'tomwilson@example.com', '9012345678', TO_DATE('1990-01-09', 'YYYY-MM-DD'), 'Tom', 'Wilson', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (10, 'katewilson', 'password10', 'katewilson@example.com', '0123456789', TO_DATE('1990-01-10', 'YYYY-MM-DD'), 'Kate', 'Wilson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (11, 'peterbrown', 'password11', 'peterbrown@example.com', '11111111111', TO_DATE('1990-01-11', 'YYYY-MM-DD'), 'Peter', 'Brown', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (12, 'marybrown', 'password12', 'marybrown@example.com', '1212121212', TO_DATE('1990-01-12', 'YYYY-MM-DD'), 'Mary', 'Brown', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (13, 'johnsmith', 'password13', 'johnsmith@example.com', '1313131313', TO_DATE('1990-01-13', 'YYYY-MM-DD'), 'John', 'Smith', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (14, 'janesmith', 'password14', 'janesmith@example.com', '1414141414', TO_DATE('1990-01-14', 'YYYY-MM-DD'), 'Jane', 'Smith', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (15, 'mikeross', 'password15', 'mikeross@example.com', '1515151515', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'Mike', 'Ross', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (16, 'rachelzane', 'password16', 'rachelzane@example.com', '6789012345', TO_DATE('1990-01-16', 'YYYY-MM-DD'), 'Rachel', 'Zane', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (17, 'harveyspecter', 'password17', 'harveyspecter@example.com', '7890123456', TO_DATE('1990-01-17', 'YYYY-MM-DD'), 'Harvey', 'Specter', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (18, 'donnapaulsen', 'password18', 'donnapaulsen@example.com', '1818181818', TO_DATE('1990-01-18', 'YYYY-MM-DD'), 'Donna', 'Paulsen', 'Female', 'Employee', 'Active' );

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (19, 'michaelross', 'password19', 'michaelross@example.com', '1919191919', TO_DATE('1990-01-19', 'YYYY-MM-DD'), 'Michael', 'Ross', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (20, 'jessicapearson', 'password20', 'jessicapearson@example.com', '2020202020', TO_DATE('1990-01-20', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (21, 'robertzane', 'password21', 'robertzane@example.com', '2121212121', TO_DATE('1990-01-21', 'YYYY-MM-DD'), 'Robert', 'Zane', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (22, 'rachelspecter', 'password22', 'rachelspecter@example.com', '2222222222', TO_DATE('1990-01-22', 'YYYY-MM-DD'), 'Rachel', 'Specter', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (23, 'louislitt', 'password23', 'louislitt@example.com', '2323232323', TO_DATE('1990-01-23', 'YYYY-MM-DD'), 'Louis', 'Litt', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (24, 'katrinabennett', 'password24', 'katrinabennett@example.com', '2424242424', TO_DATE('1990-01-24', 'YYYY-MM-DD'), 'Katrina', 'Bennett', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (25, 'haroldgunderson', 'password25', 'haroldgunderson@example.com', '2525252525', TO_DATE('1990-01-25', 'YYYY-MM-DD'), 'Harold', 'Gunderson', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (26, 'jessicapearson2', 'password26', 'jessicapearson2@example.com', '2626262626', TO_DATE('1990-01-26', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (27, 'sheilasazs', 'password27', 'sheilasazs@example.com', '2727272727', TO_DATE('1990-01-27', 'YYYY-MM-DD'), 'Sheila', 'Sazs', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (28, 'harveyspecter2', 'password28', 'harveyspecter2@example.com', '2828282828', TO_DATE('1990-01-28', 'YYYY-MM-DD'), 'Harvey', 'Specter', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (29, 'harrietkaldor', 'password29', 'harrietkaldor@example.com', '2929292929', TO_DATE('1990-01-29', 'YYYY-MM-DD'), 'Harriet', 'Kaldor', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (30, 'danielhardman', 'password30', 'danielhardman@example.com', '3030303030', TO_DATE('1990-01-30', 'YYYY-MM-DD'), 'Daniel', 'Hardman', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (31, 'rachelspecter2', 'password31', 'rachelspecter2@example.com', '1234567890', TO_DATE('1990-01-31', 'YYYY-MM-DD'), 'Rachel', 'Specter', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (32, 'scottie', 'password32', 'scottie@example.com', '3232323232', TO_DATE('1990-02-01', 'YYYY-MM-DD'), 'Scottie', 'Unknown', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (33, 'jessicapearson3', 'password33', 'jessicapearson3@example.com', '3333333333', TO_DATE('1990-02-02', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES (34, 'samantha', 'password34', 'samantha@example.com', '3434343434', TO_DATE('1990-02-03', 'YYYY-MM-DD'), 'Samantha', 'Unknown', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (35, 'danielseagal', 'password35', 'danielseagal@example.com', '3535353535', TO_DATE('1990-02-04', 'YYYY-MM-DD'), 'Daniel', 'Seagal', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (36, 'jennygriffith', 'password36', 'jennygriffith@example.com', '3636363636', TO_DATE('1990-02-05', 'YYYY-MM-DD'), 'Jenny', 'Griffith', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (37, 'katrinabennett2', 'password37', 'katrinabennett2@example.com', '3737373737', TO_DATE('1990-02-06', 'YYYY-MM-DD'), 'Katrina', 'Bennett', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (38, 'robertzane2', 'password38', 'robertzane2@example.com', '3838383838', TO_DATE('1990-02-07', 'YYYY-MM-DD'), 'Robert', 'Zane', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (39, 'jacksoloff', 'password39', 'jacksoloff@example.com', '3939393939', TO_DATE('1990-02-08', 'YYYY-MM-DD'), 'Jack', 'Soloff', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (40, 'danielhardman2', 'password40', 'danielhardman2@example.com', '4040404040', TO_DATE('1990-02-09', 'YYYY-MM-DD'), 'Daniel', 'Hardman', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (41, 'nhatminh', 'pnm1234', 's3978598@rmit.edu.vn', '0907459988', TO_DATE('2004-05-09', 'YYYY-MM-DD'), 'Minh', 'Phan', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (42, 'giatin', 'hdgt1234', 's3962530@rmit.edu.vn', '0911111111', TO_DATE('2004-12-26', 'YYYY-MM-DD'), 'Tin', 'Huynh', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (43, 'thanhngoc', 'nttn1234', 's39797640@rmit.edu.vn', '0922222222', TO_DATE('2004-02-02', 'YYYY-MM-DD'), 'Ngoc', 'Nguyen', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES (44, 'dangkhoi', 'bdk1234', 's3983426@rmit.edu.vn', '09555555555', TO_DATE('2004-03-03', 'YYYY-MM-DD'), 'Khoi', 'Bui', 'Male', 'Manager', 'Active');

-- Company table populatation
-- Company 1
INSERT INTO company (CompanyID, CompanyName, CompanyAddress, Country)
VALUES(
        1,
        'RMIT University',
        '124 La Trobe St, Melbourne VIC 3000, Australia',
        'Australia'
    );

-- Company 2
INSERT INTO company (CompanyID, CompanyName, CompanyAddress, Country)
VALUES (
        2,
        'GPT-5',
        '702 Nguyen Van Linh Street, District 7, Ho Chi Minh City, Vietnam',
        'Vietnam'
    );


-- Department table population
-- Departments in Company 1
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (1, 1, 10000.00, 'Administration');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (2, 1, 9000.00, 'Teaching');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (3, 1, 8000.00, 'IT Support');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (4, 1, 7000.00, 'Marketing');

-- Departments in Company 2
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (6, 2, 100000000.00, 'Technical');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (7, 2, 90000000.00, 'Business');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (8, 2, 70000000.00, 'Human Resource');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES (9, 2, 60000000.00, 'Marketing');


-- Employee Population
-- Employees in Company 1
INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (2, 2, 3, 'IT Leader', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (3, 3, 5, 'Technical Support Specialist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (4, 4, 1, 'President', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (5, 5, 2, 'Course Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (6, 6, 3, 'Senior Supporter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (7, 7, 4, 'Marketing Director', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (8, 8, 1, 'Vice President', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (9, 9, 1, 'Assistant', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (10, 10, 1, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (11, 11, 1, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (12, 12, 2, 'Lecturer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (13, 13, 2, 'Teaching Assistant', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (14, 14, 2, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (15, 15, 2, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (16, 16, 3, 'Junior Supporter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (17, 17, 3, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (18, 18, 3, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (19, 19, 4, 'Content Specialist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (20, 20, 4, 'Event Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (21, 21, 4, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (22, 22, 4, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 1);

-- Employees in Company 2
INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (23, 23, 5, 'Software Engineer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (24, 24, 5, 'Network Administrator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (25, 25, 5, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (26, 26, 6, 'Financial Analyst', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (27, 27, 6, 'Operations Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (28, 28, 6, 'Marketing Analyst', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (29, 29, 6, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (30, 30, 7, 'Recruiter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (31, 31, 7, 'Training and Development Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (32, 32, 7, 'HR Generalist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (33, 33, 7, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (34, 34, 8, 'Event Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (35, 35, 8, 'Brand Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (36, 36, 8, 'Content Creator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (37, 37, 8, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (38, 38, 7, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (39, 39, 6, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (40, 40, 5, 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (41, 41, 8, 'Marketing Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (42, 42, 5, 'Chief Technical Officer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (43, 43, 6, 'Business Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES (44, 44, 7, 'HR Director', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 2);

-- Designation Salary Population
-- Company 1 Designation Salary
INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (1, 1, 'President', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (2, 1, 'Vice President', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (3, 1, 'Assistant', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (4, 1, 'Staff', 30000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (5, 2, 'Course Coordinator', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (6, 2, 'Lecturer', 8500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (7, 2, 'Teaching Assistant', 6000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (8, 2, 'Staff', 3000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (9, 3, 'IT Leader', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (10, 3, 'Senior Supporter', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (11, 3, 'Junior Supporter', 6000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (12, 3, 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (13, 4, 'Marketing Director', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (14, 4, 'Content Specialist', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (15, 4, 'Event Coordinatior', 7650.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (16, 4, 'Staff', 3000.00);

-- Company 2 Designation Salary
INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (17, 5, 'Chief Tech Officer', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (18, 5, 'Software Engineer', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (19, 5, 'Network Administration', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (20, 5, 'Technical Support Specialist', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (21, 5, 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (22, 6, 'Business Manager', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (23, 6, 'Financial Analyst', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (24, 6, 'Operations Manager', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (25, 6, 'Marketing Analyst', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (26, 6, 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (27, 7, 'HR Director', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (28, 7, 'Recruiter', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (29, 7, 'Training and Development Manager', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (30, 7, 'HR Generalist', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (31, 7, 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (32, 8, 'Marketing Manager', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (33, 8, 'Event Coordinator', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (34, 8, 'Brand Manager', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (35, 8, 'Content Creator', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES (36, 8, 'Staff', 4000.00);

-- Tax Bracket population
-- Company 1 Tax Bracket
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (1, 1, 0, 3000, 0);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (2, 1, 3000, 4500, 5);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (3, 1, 4501, 7000, 7);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (4, 1, 7001, 9000, 9);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (5, 1, 9001, 9999999999, 15);

-- Company 2 Tax Bracket
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (6, 2, 0, 3000, 0);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (7, 2, 3000, 4500, 5);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (8, 2, 4501, 7000, 7);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (9, 2, 7001, 9000, 9);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES (10, 2, 9001, 9999999999, 15);


-- Salary Adjustment Population
-- Increment for employee ID 2
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason) 
VALUES (1, 2, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 650, 'Increment', 'Annual Increment');

-- Deduction for employee ID 3
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason) 
VALUES (2, 3, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 300, 'Deduction', 'Late Penalty');

-- Increment for employee ID 4
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason) 
VALUES (3, 4, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 750, 'Increment', 'Performance Bonus');

-- Deduction for employee ID 5
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason) 
VALUES (4, 5, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 200, 'Deduction', 'Absenteeism');

-- Increment for employee ID 6
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason) 
VALUES (5, 6, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 600, 'Increment', 'Cost of Living Adjustment');

-- Increment for employee ID 7
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (6, 7, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 500, 'Increment', 'Merit Increase');

-- Deduction for employee ID 8
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (7, 8, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 100, 'Deduction', 'Equipment Damage');

-- Increment for employee ID 9
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (8, 9, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 800, 'Increment', 'Promotion');

-- Deduction for employee ID 10
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (9, 10, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 150, 'Deduction', 'Health Insurance');

-- Increment for employee ID 11
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (10, 11, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 900, 'Increment', 'Market Adjustment');

-- Deduction for employee ID 12
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (11, 12, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 250, 'Deduction', 'Loan Repayment');

-- Increment for employee ID 13
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (12, 13, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 700, 'Increment', 'Skills Development Bonus');

-- Deduction for employee ID 14
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (13, 14, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 200, 'Deduction', 'Tax Withholding');

-- Increment for employee ID 15
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (14, 15, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1000, 'Increment', 'Extraordinary Performance Award');

-- Deduction for employee ID 16
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (15, 16, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 300, 'Deduction', 'Salary Overpayment');

-- Increment for employee ID 17
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (16, 17, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 550, 'Increment', 'Retention Bonus');

-- Deduction for employee ID 18
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (17, 18, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 100, 'Deduction', 'Parking Violation');

-- Increment for employee ID 19
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (18, 19, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 850, 'Increment', 'Employee Referral Bonus');

-- Deduction for employee ID 20
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (19, 20, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 400, 'Deduction', 'Court-Ordered Garnishment');

-- Increment for employee ID 21
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (20, 21, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 700, 'Increment', 'Educational Assistance Reimbursement');

-- Deduction for employee ID 22
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (21, 22, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 150, 'Deduction', 'Child Support');

-- Increment for employee ID 23
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (22, 23, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 950, 'Increment', 'Departmental Award');

-- Deduction for employee ID 24
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (23, 24, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 200, 'Deduction', 'Expense Reimbursement Adjustment');

-- Increment for employee ID 25
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (24, 25, TO_DATE('2023-11-01', 'YYYY-MM-DD'), 500, 'Increment', 'Job Re-Evaluation');

-- Deduction for employee ID 26
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (25, 26, TO_DATE('2023-11-01', 'YYYY-MM-DD'), 250, 'Deduction', 'Unpaid Leave');

-- Increment for employee ID 27
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (26, 27, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 600, 'Increment', 'Longevity Pay');

-- Deduction for employee ID 28
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (27, 28, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 350, 'Deduction', 'Overpayment Correction');

-- Increment for employee ID 29
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (28, 29, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 800, 'Increment', 'Profit Sharing Bonus');

-- Deduction for employee ID 30
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (29, 30, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 100, 'Deduction', 'Uniform Deduction');

-- Increment for employee ID 31
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (30, 31, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 650, 'Increment', 'Loyalty Bonus');

-- Deduction for employee ID 32
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (31, 32, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 200, 'Deduction', 'Excessive Breaks Penalty');

-- Increment for employee ID 33
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (32, 33, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 750, 'Increment', 'Employee of the Month');

-- Deduction for employee ID 34
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (33, 34, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 300, 'Deduction', 'Non-Compliance Penalty');

-- Increment for employee ID 35
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (34, 35, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 550, 'Increment', 'Sales Commission');

-- Deduction for employee ID 36
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (35, 36, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 250, 'Deduction', 'Work-Related Travel Expenses');

-- Increment for employee ID 37
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (36, 37, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 700, 'Increment', 'New Certification Bonus');

-- Deduction for employee ID 38
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (37, 38, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 150, 'Deduction', 'Late Arrival Penalty');

-- Increment for employee ID 39
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (38, 39, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 900, 'Increment', 'Special Project Completion Bonus');

-- Deduction for employee ID 40
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (39, 40, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 200, 'Deduction', 'Personal Phone Usage');

-- Increment for employee ID 41
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (40, 41, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 800, 'Increment', 'Company Milestone Achievement');

-- Deduction for employee ID 42
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (41, 42, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 300, 'Deduction', 'Unauthorized Overtime');

-- Increment for employee ID 43
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (42, 43, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 750, 'Increment', 'Leadership Training Completion');

-- Deduction for employee ID 44
INSERT INTO salary_adjustment (AdjustmentID, EmployeeID, AdjustmentDate, AdjustmentAmount, AdjustmentType, Reason)
VALUES (43, 44, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 250, 'Deduction', 'Safety Violation');

-- Salary Summary Population (Only for user 22)
-- Record 1
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (1, 22, TO_DATE('2022-01-31', 'YYYY-MM-DD'), 3000, 2850, 2850, 3000, 150);

-- Record 2
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (2, 22, TO_DATE('2022-02-28', 'YYYY-MM-DD'), 3200, 3040, 5890, 3200, 160);

-- Record 3
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (3, 22, TO_DATE('2022-03-31', 'YYYY-MM-DD'), 3500, 3325, 9215, 3500, 175);

-- Record 4
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (4, 22, TO_DATE('2022-04-30', 'YYYY-MM-DD'), 3800, 3610, 12825, 3800, 190);

-- Record 5
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (5, 22, TO_DATE('2022-05-31', 'YYYY-MM-DD'), 4000, 3800, 16625, 4000, 200);

-- Record 6
INSERT INTO SALARY_SUMMARY (SALARYSUMMARYID, EMPLOYEEID, PAYMENTDATE, BASESALARY, NETSALARY, TOTALSAVINGS, CTCSALARY, TAXDEDUCTION)
VALUES (6, 22, TO_DATE('2022-06-30', 'YYYY-MM-DD'), 4200, 3990, 20615, 4200, 210);

-- Salary Adjustment Population (Only for user 22)
INSERT INTO SALARY_ADJUSTMENT (ADJUSTMENTID, EMPLOYEEID, ADJUSTMENTDATE, ADJUSTMENTAMOUNT, ADJUSTMENTTYPE, REASON)
VALUES (44, 22, TO_DATE('2022-02-28', 'YYYY-MM-DD'), 160, 'Deduction', 'Tax Deduction');


INSERT INTO SALARY_ADJUSTMENT (ADJUSTMENTID, EMPLOYEEID, ADJUSTMENTDATE, ADJUSTMENTAMOUNT, ADJUSTMENTTYPE, REASON)
VALUES (45, 22, TO_DATE('2022-03-31', 'YYYY-MM-DD'), 175, 'Deduction', 'Tax Deduction');


INSERT INTO SALARY_ADJUSTMENT (ADJUSTMENTID, EMPLOYEEID, ADJUSTMENTDATE, ADJUSTMENTAMOUNT, ADJUSTMENTTYPE, REASON)
VALUES (46, 22, TO_DATE('2022-04-30', 'YYYY-MM-DD'), 190, 'Deduction', 'Tax Deduction');


INSERT INTO SALARY_ADJUSTMENT (ADJUSTMENTID, EMPLOYEEID, ADJUSTMENTDATE, ADJUSTMENTAMOUNT, ADJUSTMENTTYPE, REASON)
VALUES (47, 22, TO_DATE('2022-05-31', 'YYYY-MM-DD'), 200, 'Deduction', 'Tax Deduction');


INSERT INTO SALARY_ADJUSTMENT (ADJUSTMENTID, EMPLOYEEID, ADJUSTMENTDATE, ADJUSTMENTAMOUNT, ADJUSTMENTTYPE, REASON)
VALUES (48, 22, TO_DATE('2022-06-30', 'YYYY-MM-DD'), 210, 'Deduction', 'Tax Deduction');