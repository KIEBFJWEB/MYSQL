-- 1 Create a query that returns the total quantity of all products with the ID of P4 sold in the years 2020, 2021 and 2022. 

select concat(sum(Quantity)," ", '(2020)') as 'P4 product : Quantity'  
from orders 
 where year(date) = '2020' and ProductID = 'P4'
 UNION SELECT 
 CONCAT(SUM(Quantity)," ", '(2021)')
 FROM ORDERS 
 WHERE YEAR(DATE) = '2021' AND ProductID ='P4' 
 UNION SELECT 
 concat( SUM(Quantity)," ", '(2022)')
 from orders
 WHERE YEAR(DATE) = '2022' AND ProductID ='P4';
 
 -- 2 Find all  clients and the orders that they placed in the years 2022 and 2021.   
 
 SELECT C.ClientID, O.OrderID, O.ProductID,P.ProductName,C.ContactNumber, A.Street, A.County,  O.Cost, O.Date  
 FROM products P 
 INNER JOIN orders O ON P.ProductID = O.ProductID 
 INNER JOIN clients C ON O.ClientID = C.ClientID
 INNER JOIN addresses A ON C.Addressid = A.AddressID
 WHERE YEAR (O.DATE) = 2021 or YEAR(O.DATE) = 2022 order by O.Date;
 
 -- 3 Find the sales performance of their product in the year 2021.  
-- Analyze the performance of this product by developing a function called FindSoldQuantity:

 -- SOLUTION -1 .
SELECT SUM(QUANTITY) FROM ORDERS 
WHERE productID = 'P3'
AND year(DATE) = '2021';

-- SOLUTION -2 
-- USING FINDSOLDQUANITY 
CREATE FUNCTION FindSoldQuantity (product_id VARCHAR(10), YearInput INT) returns INT DETERMINISTIC RETURN 
(SELECT SUM(Quantity) FROM Orders WHERE ProductID = product_id AND YEAR (Date) = YearInput);

SELECT FindSoldQuantity ("P3", 2021) AS PRODUCT_SOLD_IN_2021;

-- 4 Find the total number of orders placed by each client.
SELECT Clientid, count(orderid) FROM ORDERS 
GROUP BY 1; 

-- 5 Calculate the total revenue generated from each product.
SELECT ProductName , sum(o.quantity *O.Cost) AS TOTAL_REVENUE 
from Products P 
Join orders o on p.ProductID = o.ProductID
group by 1;

-- 6 Identify the top 1 client based on the number of orders they placed.
SELECT C.FULL_NAME,count(O.OrderID) AS TOTAL_ORDER FROM clients C
JOIN orders O ON C.ClientID = O.ClientID
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 1;

-- 7 Retrieve the top 3 counties with the highest sales revenue.

SELECT A.County, SUM(O.Cost * O.Quantity) AS TOTAL_SALES FROM addresses A
JOIN clients C ON A.AddressID = C.Addressid
JOIN orders O ON C.ClientID = O.ClientID
JOIN products P ON O.ProductID = P.ProductID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- 8 List the clients who have placed orders worth more than 75000 in total.

SELECT C.Full_name, SUM(O.Quantity * O.Cost) AS TOTALSPENT FROM clients C
JOIN orders O ON C.ClientID = O.ClientID
GROUP BY 1
HAVING TOTALSPENT>75000;

-- 9 Calculate the profit margin for each product and display the products with a margin above 20%.
SELECT ProductName, ROUND((SellPrice-BuyPrice)/BuyPrice * 100,0)
AS PROFIT_MARGIN FROM products 
WHERE (SellPrice-BuyPrice)/BuyPrice * 100 >20;

-- 10 Show the addresses of all clients.

SELECT C.Full_name,A.Street FROM clients C
JOIN addresses A ON C.Addressid = A.AddressID

