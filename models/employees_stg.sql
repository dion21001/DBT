SELECT
EmployeeID,
FirstName,
LastName,
Email,
JobTitle,
HireDate,
ManagerID,
Address,
City,
State,
ZipCode,
CONCAT(FirstName, ' ', LastName) AS EmployeeName,
Updated_at
FROM
    L1_LANDING.EMPLOYEES
-- {{ source('landing', 'emp') }}