-- Drop existing tables (if they exist)
DROP TABLE IF EXISTS tax_bracket;
DROP TABLE IF EXISTS salary_summary;
DROP TABLE IF EXISTS salary_adjustment;
DROP TABLE IF EXISTS designation_salary;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS user_account;

-- User Account table
CREATE TABLE user_account (
  UserID varchar2(15) PRIMARY KEY,
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
  CompanyID varchar2(15) PRIMARY KEY,
  CompanyName varchar2(100) NOT NULL UNIQUE,
  CompanyAddress varchar2(255) NOT NULL,
  country varchar2(50) NOT NULL
);

-- Department table
CREATE TABLE department (
  DepartmentID varchar2(15) PRIMARY KEY,
  CompanyID varchar2(15) NOT NULL,
  Budget decimal(14, 2) NOT NULL,
  DepartmentName varchar2(50) NOT NULL,
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID),
  UNIQUE (CompanyID, DepartmentName)
);

-- Employee table
CREATE TABLE employee (
  EmployeeID varchar2(15) PRIMARY KEY,
  UserID varchar2(15) NOT NULL,
  DepartmentID varchar2(15) NOT NULL,
  Designation varchar2(50) NOT NULL,
  HireDate date NOT NULL,
  CompanyID varchar2(15) NOT NULL,
  FOREIGN KEY (UserID) REFERENCES user_account (UserID),
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
);

-- Designation salary
CREATE TABLE designation_salary (
  DesignationSalaryID varchar2(15) PRIMARY KEY,
  DepartmentID varchar2(15) NOT NULL,
  Designation varchar2(50) NOT NULL,
  BaseSalary decimal(14, 2) NOT NULL,
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  UNIQUE (DepartmentID, Designation)
);

-- Salary Adjustment table
CREATE TABLE salary_adjustment (
  AdjustmentID varchar2(15) PRIMARY KEY,
  EmployeeID varchar2(15) NOT NULL,
  AdjustmentDate date NOT NULL,
  AdjustmentAmount decimal(14, 2) NOT NULL,
  AdjustmentType varchar2(20) NOT NULL CHECK (AdjustmentType IN ('Increment', 'Deduction')),
  Reason varchar2(255),
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);

-- Salary Summary table
CREATE TABLE salary_summary (
  SalarySummaryID varchar2(15) PRIMARY KEY,
  EmployeeID varchar2(15) NOT NULL,
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
  TaxBracketID varchar2(15) PRIMARY KEY,
CompanyID varchar2(15) NOT NULL,
MinIncome decimal(14, 2) NOT NULL,
MaxIncome decimal(14, 2) NOT NULL,
TaxRate number(5, 2) NOT NULL CHECK (
TaxRate >= 0
AND TaxRate <= 100
),
FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
);


-- Database Population
-- User Account table population
INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0001', 'gpt5master', 'master123', 'gpt5@master.com', '1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Male', 'Master', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0002', 'gpt5admin1', 'admin123', 'gpt5@admin.com', '2345678901', TO_DATE('1990-01-02', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Female', 'Admin', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-002', 'gpt5admin2', 'admin123', 'gpt5@rmit.edu.vn', '3456789012', TO_DATE('1990-01-03', 'YYYY-MM-DD'), 'Giang', 'Tuan', 'Male', 'Admin', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0004', 'alicesmith', 'password4', 'alicesmith@example.com', '4567890123', TO_DATE('1990-01-04', 'YYYY-MM-DD'), 'Alice', 'Smith', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0005', 'charliebrown', 'password5', 'charliebrown@example.com', '5678901234', TO_DATE('1990-01-05', 'YYYY-MM-DD'), 'Charlie', 'Brown', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0006', 'lucybrown', 'password6', 'lucybrown@example.com', '1982734890125', TO_DATE('1990-01-06', 'YYYY-MM-DD'), 'Lucy', 'Brown', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0007', 'davidjones', 'password7', 'davidjones@example.com', '918723498071236', TO_DATE('1990-01-07', 'YYYY-MM-DD'), 'David', 'Jones', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0008', 'sarahjones', 'password8', 'sarahjones@example.com', '8901234567', TO_DATE('1990-01-08', 'YYYY-MM-DD'), 'Sarah', 'Jones', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0009', 'tomwilson', 'password9', 'tomwilson@example.com', '9012345678', TO_DATE('1990-01-09', 'YYYY-MM-DD'), 'Tom', 'Wilson', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0010', 'katewilson', 'password10', 'katewilson@example.com', '0123456789', TO_DATE('1990-01-10', 'YYYY-MM-DD'), 'Kate', 'Wilson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0011', 'peterbrown', 'password11', 'peterbrown@example.com', '1111111111', TO_DATE('1990-01-11', 'YYYY-MM-DD'), 'Peter', 'Brown', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0012', 'marybrown', 'password12', 'marybrown@example.com', '1212121212', TO_DATE('1990-01-12', 'YYYY-MM-DD'), 'Mary', 'Brown', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0013', 'johnsmith', 'password13', 'johnsmith@example.com', '1313131313', TO_DATE('1990-01-13', 'YYYY-MM-DD'), 'John', 'Smith', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0014', 'janesmith', 'password14', 'janesmith@example.com', '1414141414', TO_DATE('1990-01-14', 'YYYY-MM-DD'), 'Jane', 'Smith', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0015', 'mikeross', 'password15', 'mikeross@example.com', '1515151515', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'Mike', 'Ross', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0016', 'rachelzane', 'password16', 'rachelzane@example.com', '6789012345', TO_DATE('1990-01-16', 'YYYY-MM-DD'), 'Rachel', 'Zane', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0017', 'harveyspecter', 'password17', 'harveyspecter@example.com', '7890123456', TO_DATE('1990-01-17', 'YYYY-MM-DD'), 'Harvey', 'Specter', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0018', 'donnapaulsen', 'password18', 'donnapaulsen@example.com', '1818181818', TO_DATE('1990-01-18', 'YYYY-MM-DD'), 'Donna', 'Paulsen', 'Female', 'Employee', 'Active' );

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0019', 'michaelross', 'password19', 'michaelross@example.com', '1919191919', TO_DATE('1990-01-19', 'YYYY-MM-DD'), 'Michael', 'Ross', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('RMIT-U-0020', 'jessicapearson', 'password20', 'jessicapearson@example.com', '2020202020', TO_DATE('1990-01-20', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0001', 'robertzane', 'password21', 'robertzane@example.com', '2121212121', TO_DATE('1990-01-21', 'YYYY-MM-DD'), 'Robert', 'Zane', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0002', 'rachelspecter', 'password22', 'rachelspecter@example.com', '2222222222', TO_DATE('1990-01-22', 'YYYY-MM-DD'), 'Rachel', 'Specter', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0003', 'louislitt', 'password23', 'louislitt@example.com', '2323232323', TO_DATE('1990-01-23', 'YYYY-MM-DD'), 'Louis', 'Litt', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0004', 'katrinabennett', 'password24', 'katrinabennett@example.com', '2424242424', TO_DATE('1990-01-24', 'YYYY-MM-DD'), 'Katrina', 'Bennett', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0005', 'haroldgunderson', 'password25', 'haroldgunderson@example.com', '2525252525', TO_DATE('1990-01-25', 'YYYY-MM-DD'), 'Harold', 'Gunderson', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0006', 'jessicapearson2', 'password26', 'jessicapearson2@example.com', '2626262626', TO_DATE('1990-01-26', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0007', 'sheilasazs', 'password27', 'sheilasazs@example.com', '2727272727', TO_DATE('1990-01-27', 'YYYY-MM-DD'), 'Sheila', 'Sazs', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0008', 'harveyspecter2', 'password28', 'harveyspecter2@example.com', '2828282828', TO_DATE('1990-01-28', 'YYYY-MM-DD'), 'Harvey', 'Specter', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0009', 'harrietkaldor', 'password29', 'harrietkaldor@example.com', '2929292929', TO_DATE('1990-01-29', 'YYYY-MM-DD'), 'Harriet', 'Kaldor', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0010', 'danielhardman', 'password30', 'danielhardman@example.com', '3030303030', TO_DATE('1990-01-30', 'YYYY-MM-DD'), 'Daniel', 'Hardman', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0011', 'rachelspecter2', 'password31', 'rachelspecter2@example.com', '3131313131', TO_DATE('1990-01-31', 'YYYY-MM-DD'), 'Rachel', 'Specter', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0012', 'scottie', 'password32', 'scottie@example.com', '3232323232', TO_DATE('1990-02-01', 'YYYY-MM-DD'), 'Scottie', 'Unknown', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0013', 'jessicapearson3', 'password33', 'jessicapearson3@example.com', '3333333333', TO_DATE('1990-02-02', 'YYYY-MM-DD'), 'Jessica', 'Pearson', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status) 
VALUES ('GPT5-U-0014', 'samantha', 'password34', 'samantha@example.com', '3434343434', TO_DATE('1990-02-03', 'YYYY-MM-DD'), 'Samantha', 'Unknown', 'Other', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0015', 'danielseagal', 'password35', 'danielseagal@example.com', '3535353535', TO_DATE('1990-02-04', 'YYYY-MM-DD'), 'Daniel', 'Seagal', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0016', 'jennygriffith', 'password36', 'jennygriffith@example.com', '3636363636', TO_DATE('1990-02-05', 'YYYY-MM-DD'), 'Jenny', 'Griffith', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0017', 'katrinabennett2', 'password37', 'katrinabennett2@example.com', '3737373737', TO_DATE('1990-02-06', 'YYYY-MM-DD'), 'Katrina', 'Bennett', 'Female', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0018', 'robertzane2', 'password38', 'robertzane2@example.com', '3838383838', TO_DATE('1990-02-07', 'YYYY-MM-DD'), 'Robert', 'Zane', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0019', 'jacksoloff', 'password39', 'jacksoloff@example.com', '3939393939', TO_DATE('1990-02-08', 'YYYY-MM-DD'), 'Jack', 'Soloff', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0020', 'danielhardman2', 'password40', 'danielhardman2@example.com', '4040404040', TO_DATE('1990-02-09', 'YYYY-MM-DD'), 'Daniel', 'Hardman', 'Male', 'Employee', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0021', 'nhatminh', 'pnm1234', 's3978598@rmit.edu.vn', '0907459988', TO_DATE('2004-05-09', 'YYYY-MM-DD'), 'Minh', 'Phan', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0022', 'giatin', 'hdgt1234', 's3962530@rmit.edu.vn', '0911111111', TO_DATE('2004-12-26', 'YYYY-MM-DD'), 'Tin', 'Huynh', 'Male', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0023', 'thanhngoc', 'nttn1234', 's39797640@rmit.edu.vn', '0922222222', TO_DATE('2004-02-02', 'YYYY-MM-DD'), 'Ngoc', 'Nguyen', 'Female', 'Manager', 'Active');

INSERT INTO user_account (UserID, Username, UserPassword, Email, Phone, DateOfBirth, FirstName, LastName, Gender, Role, Status)
VALUES ('GPT5-U-0024', 'dangkhoi', 'bdk1234', 's3983426@rmit.edu.vn', '09555555555', TO_DATE('2004-03-03', 'YYYY-MM-DD'), 'Khoi', 'Bui', 'Male', 'Manager', 'Active');


-- Company table population
-- Company 1
INSERT INTO company (CompanyID, CompanyName, CompanyAddress, Country)
VALUES(
        'RMIT',
        'RMIT University',
        '124 La Trobe St, Melbourne VIC 3000, Australia',
        'Australia'
    );

-- Company 2
INSERT INTO company (CompanyID, CompanyName, CompanyAddress, Country)
VALUES (
        'GPT5',
        'GPT-5',
        '702 Nguyen Van Linh Street, District 7, Ho Chi Minh City, Vietnam',
        'Vietnam'
    );


-- Department table population
-- Departments in Company 1
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('RMIT-D-0001', 'RMIT', 10000.00, 'Administration');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('RMIT-D-0002', 'RMIT', 9000.00, 'Teaching');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('RMIT-D-0003', 'RMIT', 8000.00, 'IT Support');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('RMIT-D-0004', 'RMIT', 7000.00, 'Marketing');

-- Departments in Company 2
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('GPT5-D-0001', 'GPT5', 10000.00, 'Technical');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('GPT5-D-0002', 'GPT5', 9000.00, 'Business');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('GPT5-D-0003', 'GPT5', 7000.00, 'Human Resource');
INSERT INTO department (DepartmentID, CompanyID, Budget, DepartmentName)
VALUES ('GPT5-D-0004', 'GPT5', 6000.00, 'Marketing');


-- Employee table population
INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0002', 'RMIT-U-0002', 'RMIT-D-0003', 'IT Leader', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0002', 'GPT5-U-0002', 'GPT5-D-0001', 'Technical Support Specialist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0004', 'RMIT-U-0004', 'RMIT-D-0001', 'President', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0005', 'RMIT-U-0005', 'RMIT-D-0002', 'Course Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0006', 'RMIT-U-0006', 'RMIT-D-0003', 'Senior Supporter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0007', 'RMIT-U-0007', 'RMIT-D-0004', 'Marketing Director', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0008', 'RMIT-U-0008', 'RMIT-D-0001', 'Vice President', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0009', 'RMIT-U-0009', 'RMIT-D-0001', 'Assistant', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0010', 'RMIT-U-0010', 'RMIT-D-0001', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0011', 'RMIT-U-0011', 'RMIT-D-0001', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0012', 'RMIT-U-0012', 'RMIT-D-0002', 'Lecturer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0013', 'RMIT-U-0013', 'RMIT-D-0002', 'Teaching Assistant', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0014', 'RMIT-U-0014', 'RMIT-D-0002', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0015', 'RMIT-U-0015', 'RMIT-D-0002', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0016', 'RMIT-U-0016', 'RMIT-D-0003', 'Junior Supporter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0017', 'RMIT-U-0017', 'RMIT-D-0003', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0018', 'RMIT-U-0018', 'RMIT-D-0003', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0019', 'RMIT-U-0019', 'RMIT-D-0004', 'Content Specialist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0020', 'RMIT-U-0020', 'RMIT-D-0004', 'Event Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0021', 'RMIT-U-0021', 'RMIT-D-0004', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('RMIT-E-0022', 'RMIT-U-0022', 'RMIT-D-0004', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'RMIT');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0003', 'GPT5-U-0003', 'GPT5-D-0001', 'Software Engineer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0004', 'GPT5-U-0004', 'GPT5-D-0001', 'Network Administrator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0005', 'GPT5-U-0005', 'GPT5-D-0001', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0006', 'GPT5-U-0006', 'GPT5-D-0002', 'Financial Analyst', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0007', 'GPT5-U-0007', 'GPT5-D-0002', 'Operations Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0008', 'GPT5-U-0008', 'GPT5-D-0002', 'Marketing Analyst', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0009', 'GPT5-U-0009', 'GPT5-D-0002', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0010', 'GPT5-U-0010', 'GPT5-D-0003', 'Recruiter', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0011', 'GPT5-U-0011', 'GPT5-D-0003', 'Training and Development Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0012', 'GPT5-U-0012', 'GPT5-D-0003', 'HR Generalist', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0013', 'GPT5-U-0013', 'GPT5-D-0003', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0014', 'GPT5-U-0014', 'GPT5-D-0004', 'Event Coordinator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0015', 'GPT5-U-0015', 'GPT5-D-0004', 'Brand Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0016', 'GPT5-U-0016', 'GPT5-D-0004', 'Content Creator', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0017', 'GPT5-U-0017', 'GPT5-D-0004', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0018', 'GPT5-U-0018', 'GPT5-D-0003', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0019', 'GPT5-U-0019', 'GPT5-D-0002', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0020', 'GPT5-U-0020', 'GPT5-D-0001', 'Staff', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0021', 'GPT5-U-0021', 'GPT5-D-0004', 'Marketing Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0022', 'GPT5-U-0022', 'GPT5-D-0001', 'Chief Technical Officer', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0023', 'GPT5-U-0023', 'GPT5-D-0002', 'Business Manager', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');

INSERT INTO employee (EmployeeID, UserID, DepartmentID, Designation, HireDate, CompanyID)
VALUES ('GPT5-E-0024', 'GPT5-U-0024', 'GPT5-D-0003', 'HR Director', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'GPT5');


-- Designation Salary population
INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0001', 'RMIT-D-0001', 'President', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0002', 'RMIT-D-0001', 'Vice President', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0003', 'RMIT-D-0001', 'Assistant', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0004', 'RMIT-D-0001', 'Staff', 30000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0005', 'RMIT-D-0002', 'Course Coordinator', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0006', 'RMIT-D-0002', 'Lecturer', 8500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0007', 'RMIT-D-0002', 'Teaching Assistant', 6000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0008', 'RMIT-D-0002', 'Staff', 3000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0009', 'RMIT-D-0003', 'IT Leader', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0010', 'RMIT-D-0003', 'Senior Supporter', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0011', 'RMIT-D-0003', 'Junior Supporter', 6000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0012', 'RMIT-D-0003', 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0013', 'RMIT-D-0004', 'Marketing Director', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0014', 'RMIT-D-0004', 'Content Specialist', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0015', 'RMIT-D-0004', 'Event Coordinatior', 7650.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('RMIT-DS-0016', 'RMIT-D-0004', 'Staff', 3000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0001', 'GPT5-D-0001', 'Chief Tech Officer', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0002', 'GPT5-D-0001', 'Software Engineer', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0003', 'GPT5-D-0001', 'Network Administration', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0004', 'GPT5-D-0001', 'Technical Support Specialist', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0005', 'GPT5-D-0001', 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0006', 'GPT5-D-0002', 'Business Manager', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0007', 'GPT5-D-0002', 'Financial Analyst', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0008', 'GPT5-D-0002', 'Operations Manager', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0009', 'GPT5-D-0002', 'Marketing Analyst', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0010', 'GPT5-D-0002', 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0011', 'GPT5-D-0003', 'HR Director', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0012', 'GPT5-D-0003', 'Recruiter', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0013', 'GPT5-D-0003', 'Training and Development Manager', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0014', 'GPT5-D-0003', 'HR Generalist', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0015', 'GPT5-D-0003', 'Staff', 4000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0016', 'GPT5-D-0004', 'Marketing Manager', 10000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0017', 'GPT5-D-0004', 'Event Coordinator', 8000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0018', 'GPT5-D-0004', 'Brand Manager', 7500.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0019', 'GPT5-D-0004', 'Content Creator', 7000.00);

INSERT INTO designation_salary (DesignationSalaryID, DepartmentID, Designation, BaseSalary)
VALUES ('GPT5-DS-0020', 'GPT5-D-0004', 'Staff', 4000.00);


--Tax Bracket Table population
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('RMIT-TB-0001', 'RMIT', 0, 3000, 0);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('RMIT-TB-0002', 'RMIT', 3000, 4500, 5);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('RMIT-TB-0003', 'RMIT', 4501, 7000, 7);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('RMIT-TB-0004', 'RMIT', 7001, 9000, 9);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('RMIT-TB-0005', 'RMIT', 9001, 9999999999, 15);

INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('GPT5-TB-0001', 'GPT5', 0, 3000, 0);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('GPT5-TB-0002', 'GPT5', 3000, 4500, 5);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('GPT5-TB-0003', 'GPT5', 4501, 7000, 7);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('GPT5-TB-0004', 'GPT5', 7001, 9000, 9);
INSERT INTO TAX_BRACKET (TAXBRACKETID, COMPANYID, MININCOME, MAXINCOME, TAXRATE) VALUES ('GPT5-TB-0005', 'GPT5', 9001, 9999999999, 15);
