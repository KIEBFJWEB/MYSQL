select * from products;
select * from addresses;
select * from orders;
select * from clients;
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
 
 -- 2 Lucky Shrub need information on all their clients and the orders that they placed in the years 2022 and 2021. 
 
 SELECT C.ClientID, O.OrderID, O.ProductID,P.ProductName,C.ContactNumber, A.Street, A.County,  O.Cost, O.Date  
 FROM products P 
 INNER JOIN orders O ON P.ProductID = O.ProductID 
 INNER JOIN clients C ON O.ClientID = C.ClientID
 INNER JOIN addresses A ON C.Addressid = A.AddressID
 WHERE YEAR (O.DATE) = 2021 or YEAR(O.DATE) = 2022 order by O.Date;
 
 -- 3 Lucky Shrub needs to analyze the sales performance of their Patio slates product in the year 2021. This product has a Product ID of P3.
 -- SOLUTION -1 
SELECT SUM(QUANTITY) FROM ORDERS 
WHERE productID = 'P3'
AND year(DATE) = '2021';

-- SOLUTION -2 
-- USING FINDSOLDQUANITY 
CREATE FUNCTION FindSoldQuantity (product_id VARCHAR(10), YearInput INT) returns INT DETERMINISTIC RETURN 
(SELECT SUM(Quantity) FROM Orders WHERE ProductID = product_id AND YEAR (Date) = YearInput);

SELECT FindSoldQuantity ("P3", 2021) AS PRODUCT_SOLD_IN_2021;
