select 
    CustomerID,
    FirstName,
    LastName,
    Email,
    Phone,
    Address,
    City,
    State,
    ZipCode,
    Updated_at,
    CONCAT(FirstName,' ',LastName) as CustomerName
From
    L1_LANDING.CUSTOMERS
    -- {{ source('landing', 'cust') }}