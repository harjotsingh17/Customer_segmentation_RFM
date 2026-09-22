CREATE DATABASE RetailDB;
USE RetailDB;

CREATE TABLE retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INTEGER,
    InvoiceDate ,
    UnitPrice NUMERIC(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

SHOW datestyle;


SET datestyle = 'DMY';

COPY retail(
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
)
FROM 'D:/CODESSSSSS/RFM/Online Retail.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"',
    ENCODING 'WIN1252'
);

select * from retail;

--Data Cleaning with queries
--removing null customers
DELETE FROM retail WHERE customerid IS NULL;

--removing cancelled invoiceno( starting with 'c')
DELETE FROM retail where invoiceno LIKE 'C%';

--removing -ve and zero quantities
DELETE FROM retail WHERE quantity<=0;


--Adding totalamount column
ALTER TABLE retail ADD totalamount FLOAT;

--updating totalamount
UPDATE retail SET totalamount=quantity*unitprice

--
--Basic EDA 
--
-- 1. Monthly Sales trend
SELECT 
	EXTRACT(YEAR FROM invoicedate) AS year,
	EXTRACT(MONTH FROM invoicedate) AS month,
	SUM(totalamount) AS totalsales
FROM retail
GROUP BY 1,2
ORDER BY 1,2;

--2. top 10 customer by sales
SELECT
	customerid,
	SUM(totalamount) AS totalsales
FROM retail
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


--3 top 10 customer by quanttity
SELECT
	customerid,
	description,
	SUM(quantity) as totalquantity
FROM retail
GROUP BY customerid, description
ORDER BY totalquantity DESC
LIMIT 10;

--4. Sales by country
SELECT
	country,
	SUM(totalamount) as totalsales
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- 🔹 5. Average Order Value (AOV) per Month
SELECT 
    EXTRACT(YEAR FROM invoicedate) AS year,
	EXTRACT(MONTH FROM invoicedate) AS month,
    SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo) AS AvgOrderValue
FROM retail
GROUP BY 1,2
ORDER BY Year, Month;

-- 🔹 6. Countries with Highest Average Order Size
SELECT
    Country,
    SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo) AS AvgOrderSize
FROM retail
GROUP BY Country
ORDER BY AvgOrderSize DESC
LIMIT 10;

-- 🔹 7. DDay wise sales pattern
SELECT 
    TO_CHAR(InvoiceDate, 'Day') AS DayOfWeek,
    SUM(TotalAmount) AS TotalSales
FROM retail
GROUP BY 
    EXTRACT(ISODOW FROM InvoiceDate),
    TO_CHAR(InvoiceDate, 'Day')
ORDER BY EXTRACT(ISODOW FROM InvoiceDate);


-- 🔹 8. Seasonal Sales Trends (e.g., Christmas spike)
SELECT 
    EXTRACT(MONTH from InvoiceDate) AS Month,
    SUM(TotalAmount) AS TotalSales
FROM retail
GROUP BY 1
ORDER BY 1;

-- 🔹 9. Churned Customers (inactive > 6 months)
WITH max_date AS (
    SELECT MAX(InvoiceDate) AS MaxDate
    FROM retail
)
SELECT 
    CustomerID,
    MAX(InvoiceDate) AS LastPurchaseDate,
    MAX_DATE.MaxDate::DATE - MAX(InvoiceDate)::DATE AS DaysSinceLastPurchase
FROM retail
CROSS JOIN max_date
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID, MAX_DATE.MaxDate
HAVING MAX_DATE.MaxDate::DATE - MAX(InvoiceDate)::DATE > 180
ORDER BY DaysSinceLastPurchase DESC;


------------------------------------------------------------
--10. RFM (Recency, Frequency, Monetary) Dataset Preparation
------------------------------------------------------------

WITH max_date AS (
    SELECT MAX(InvoiceDate)::DATE AS LastDate
    FROM retail
)

SELECT 
    CustomerID,

    -- Recency: Days since last purchase
    MAX_DATE.LastDate - MAX(InvoiceDate)::DATE AS Recency,

    -- Frequency: Number of unique orders
    COUNT(DISTINCT InvoiceNo) AS Frequency,

    -- Monetary: Total amount spent
    SUM(TotalAmount) AS Monetary

FROM retail
CROSS JOIN max_date

WHERE CustomerID IS NOT NULL

GROUP BY CustomerID, MAX_DATE.LastDate

ORDER BY Monetary DESC;