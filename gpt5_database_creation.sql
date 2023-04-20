CREATE TABLE user_account (
  UserID integer PRIMARY KEY,
  Username varchar(50) NOT NULL UNIQUE,
  UserPassword varchar(255) NOT NULL,
  Email varchar(350) NOT NULL UNIQUE,
  Phone varchar(30) UNIQUE,
  DateOfBirth date NOT NULL,
  FirstName varchar(30) NOT NULL,
  LastName varchar(30) NOT NULL,
  Gender varchar2(10) CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
  Role varchar2(20) CHECK (Role IN ('Admin', 'Manager', 'Employee')) NOT NULL
);
CREATE TABLE company (
  CompanyID integer PRIMARY KEY,
  CompanyName varchar(100) NOT NULL UNIQUE,
  CompanyAddress varchar(255) NOT NULL
);
CREATE TABLE department (
  DepartmentID integer PRIMARY KEY,
  CompanyID integer NOT NULL,
  Budget decimal(10, 2) NOT NULL,
  DepartmentName varchar(50) NOT NULL,
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID),
  UNIQUE (CompanyID, DepartmentName)
);
CREATE TABLE employee (
  EmployeeID integer PRIMARY KEY,
  UserID integer NOT NULL,
  DepartmentID integer NOT NULL,
  Designation varchar(50) NOT NULL,
  HireDate date NOT NULL,
  CompanyID integer NOT NULL,
  FOREIGN KEY (UserID) REFERENCES user_account (UserID),
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
);
CREATE TABLE designation_salary (
  DesignationSalaryID integer PRIMARY KEY,
  DepartmentID integer NOT NULL,
  Designation varchar(50) NOT NULL,
  BaseSalary decimal(10, 2) NOT NULL,
  FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  UNIQUE (DepartmentID, Designation)
);
CREATE TABLE salary_increment (
  IncrementID integer PRIMARY KEY,
  EmployeeID integer NOT NULL,
  IncrementDate date NOT NULL,
  IncrementAmount decimal(10, 2) NOT NULL,
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);
CREATE TABLE salary_deduction (
  DeductionID integer PRIMARY KEY,
  EmployeeID integer NOT NULL,
  DeductionDate date NOT NULL,
  DeductionAmount decimal(10, 2) NOT NULL,
  Reason varchar(255) NOT NULL,
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);
CREATE TABLE salary_summary (
  SalarySummaryID integer PRIMARY KEY,
  EmployeeID integer NOT NULL,
  PaymentDate date NOT NULL,
  BaseSalary decimal(10, 2) NOT NULL,
  NetSalary decimal(10, 2) NOT NULL,
  TotalSavings decimal(10, 2) NOT NULL,
  CTCSalary decimal(10, 2) NOT NULL,
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID)
);
CREATE TABLE tax_bracket (
  TaxBracketID integer PRIMARY KEY,
  MinIncome decimal(10, 2) NOT NULL,
  MaxIncome decimal(10, 2) NOT NULL,
  TaxRate decimal(5, 2) NOT NULL CHECK (
    TaxRate >= 0
    AND TaxRate <= 100
  )
);
CREATE TABLE tax_summary (
  TaxSummaryID integer PRIMARY KEY,
  SalarySummaryID integer NOT NULL,
  TaxBracketID integer NOT NULL,
  TaxDeduction decimal(10, 2) NOT NULL,
  FOREIGN KEY (SalarySummaryID) REFERENCES salary_summary (SalarySummaryID),
  FOREIGN KEY (TaxBracketID) REFERENCES tax_bracket (TaxBracketID)
);
CREATE TABLE employee_management (
  ManagerID integer NOT NULL,
  EmployeeID integer NOT NULL,
  PRIMARY KEY (ManagerID, EmployeeID),
  FOREIGN KEY (ManagerID) REFERENCES employee (EmployeeID),
  FOREIGN KEY (EmployeeID) REFERENCES employee (EmployeeID),
  CHECK (ManagerID <> EmployeeID)
);