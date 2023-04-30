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
