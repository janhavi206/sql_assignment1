create database Assignment1;
use Assignment1;


-- Create two tables: EmployeeDetails and EmployeeSalary.

-- Columns for EmployeeDetails: EmpId FullName ManagerId DateOfJoining City && Columns for EmployeeSalary: : EmpId Project Salary Variable.

CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(50)
);

CREATE TABLE EmployeeSalary (
    EmpId INT PRIMARY KEY,
    Project VARCHAR(100),
    Salary DECIMAL(10, 2),
    Variable DECIMAL(10, 2),
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

-- Inserting values into the EmployeeDetails table

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
    (1, 'Jim Halpert', Null, '2022-04-20', 'New York'),
    (2, 'Andy Bernard', 1002, '2022-03-10', 'Los Angeles'),
    (3, 'Pam Beesly', Null, '2022-01-01', 'Scranton'),
    (4, 'Dwight Schrute', Null, '2022-01-15', 'Albuquerque'),
    (5, 'Michael Scott', 1001, '2022-01-01', 'Scranton');

-- Inserting values into the EmployeeSalary table

INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
    (1, 'Project 1', 10000.00, 1000.00),
    (2, 'Project 2', 8000.00, 600.00),
    (3, 'Project 3', 6500.00, 800.00),
    (4, 'Project 4', 9500.00, 1200.00),
    (5, 'Project 5', 15000.00, 2900.00);


-- SQL Query to fetch records that are present in one table but not in another table.

SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- SQL query to fetch all the employees who are not working on any project.

SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary);

-- SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-- Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary);

-- Write an SQL query to fetch a project-wise count of employees.

SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

-- Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT ed.FullName, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es ON ed.EmpId = es.EmpId;

-- Write an SQL query to fetch all the Employees who are also managers.

SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT ManagerId FROM EmployeeDetails);

-- Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId, FullName, ManagerId, DateOfJoining, City, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

-- Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM YourTable
) AS T
WHERE T.RowNum % 2 <> 0;

-- Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT DISTINCT Salary
FROM EmployeeSalary
ORDER BY Salary DESC
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;
