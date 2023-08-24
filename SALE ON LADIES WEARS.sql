SELECT *
FROM WOMENSALES.dbo.STOCK_SALES;

--Total Revenue and Quantity Sold Analysis:
--Calculate the total revenue generated from women's clothing sales over a specific time period.
--Determine the total quantity of items sold for each color and size combination.
--Identify the most popular color and size choices among customers.


SELECT  SUM(REVENUE) AS TOTAL_REVENUE
FROM dbo.STOCK_SALES;


SELECT ORDER_ID,ORDER_DATE,COLOR,SIZE,UNIT_PRICE,QUANTITY,REVENUE,
SUM(REVENUE) OVER (PARTITION BY ORDER_ID  ORDER BY ORDER_DATE, UNIT_PRICE) AS ADDING_REVENUE
FROM dbo.STOCK_SALES
WHERE SIZE  IS NOT NULL
ORDER BY 2,3;

---STANDARDIZE ORDER_DATE

SELECT ORDER_DATE, CONVERT(DATE,ORDER_DATE)
FROM WOMENSALES.dbo.STOCK_SALES

UPDATE STOCK_SALES
SET ORDER_DATE = CONVERT(DATE,ORDER_DATE)

ALTER TABLE STOCK_SALES
ADD ORDER_DATE_COVERTED DATE;

UPDATE STOCK_SALES
SET  ORDER_DATE_COVERTED = CONVERT(DATE,ORDER_DATE);

----CREATING A TEPM TABLE
--DROP TABLE IF EXISTS #FEMALE_CLOTHING
--CREATE TABLE #FEMALE_CLOTHING
--(ORDER_ID INT,
--ORDER_DATE DATETIME,
--SKU INT,
--COLOR VARCHAR,
--SIZE VARCHAR,
--UNIT_PRICE INT,
--QUANTITY INT ,
--REVENUE INT,
--ORDER_DATE_CONVERTED DATETIME)

--INSERT INTO  #FEMALE_CLOTHING
--SELECT *
--FROM WOMENSALES.dbo.STOCK_SALES

--ALTER TABLE  #FEMALE_CLOTHING
--ALTER COLUMN  ORDER_DATE_CONVERTED DATETIME; -- Change the length as needed

--Identifying the total quantity of items sold for each color and size combination.

SELECT COLOR,SIZE,
    SUM(QUANTITY) AS TotalQuantity
FROM WOMENSALES.dbo.STOCK_SALES
WHERE SIZE IS NOT NULL
    GROUP BY
    COLOR, SIZE;


--To identify the most popular color and size choices among customers

SELECT COLOR,SIZE,
    SUM(QUANTITY) AS HIGH_ORDER
FROM WOMENSALES.dbo.STOCK_SALES
where size is not null
GROUP BY
    COLOR, SIZE
ORDER BY
    HIGH_ORDER DESC;


	--Calculate the average unit price of women's clothing sold
SELECT 
	AVG (UNIT_PRICE) AS AVG_UNIT_PRICE
FROM WOMENSALES.dbo.STOCK_SALES 

--To analyze the relationship between quantity ordered and revenue

SELECT QUANTITY,
    SUM(REVENUE) AS TotalRevenue
FROM WOMENSALES.dbo.STOCK_SALES
GROUP BY
    QUANTITY
ORDER BY
    QUANTITY;

--To analyze the relationship between COLOR ordered and revenue

SELECT COLOR,
    SUM(REVENUE) AS TotalRevenue
FROM WOMENSALES.dbo.STOCK_SALES
GROUP BY
    color
ORDER BY
    color;

	--To analyze the relationship between SIZE ordered and revenue
SELECT SIZE,
    SUM(REVENUE) AS TotalRevenue
FROM WOMENSALES.dbo.STOCK_SALES
GROUP BY
    SIZE
ORDER BY
    SIZE







