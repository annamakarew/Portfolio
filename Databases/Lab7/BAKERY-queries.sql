-- Lab 7 - BAKERY
-- amakarew
-- Jun 11, 2023

USE `BAKERY`;
-- Query 1
-- Find the customer(s) who spent the most at the bakery in October of 2007.
Report first and last name.

SELECT c.FirstName, c.LastName
FROM customers c JOIN receipts r on r.Customer = c.CId JOIN items i ON
    i.Receipt = r.RNumber JOIN goods g ON g.GId = i.item
WHERE r.SaleDate LIKE '2007-10-%'
GROUP BY c.CId
ORDER BY SUM(g.Price) DESC
LIMIT 1;


USE `BAKERY`;
-- Query 2
-- Find the customers who never purchased an eclair ('Eclair')
(in October of 2007). Report their first and last names in alphabetical order by last name.

SELECT FirstName, LastName 
FROM customers c
WHERE c.CId NOT IN (
    SELECT c.CId FROM customers c JOIN receipts r ON r.Customer = c.CId JOIN
        items i ON i.Receipt = r.RNumber JOIN goods g ON g.GId = i.item
    WHERE r.SaleDate LIKE '2007-10-%' AND g.Food = 'Eclair'
    GROUP BY c.CId)
ORDER BY LastName;


USE `BAKERY`;
-- Query 3
-- Find all people who bought more cakes than cookies in October of 2007. 
Report their names in alphabetical order by last name.

SELECT FirstName, LastName
FROM customers, (
        SELECT c.CId, COUNT(i.item) AS cakes
        FROM customers c JOIN receipts r ON r.Customer = c.CId JOIN
            items i ON i.Receipt = r.RNumber JOIN goods g1 ON g1.GId = i.item
        WHERE g1.Food = 'Cake' AND r.SaleDate LIKE '2007-10-%'
        GROUP BY c.CId) q1,
        (SELECT c2.CId, COUNT(i2.item) AS cookies
        FROM customers c2 JOIN receipts r2 ON r2.Customer = c2.CId JOIN
            items i2 ON i2.Receipt = r2.RNumber JOIN goods g2 ON g2.GId = i2.item
        WHERE g2.Food = 'Cookie' AND r2.SaleDate LIKE '2007-10-%'
        GROUP BY c2.CId) q2
WHERE q1.CId = customers.CId AND q2.CId = customers.CId AND cakes > cookies
ORDER BY LastName;


USE `BAKERY`;
-- Query 4
-- Find the most popular (by number of pastries sold) item (or items). Report the item (food, flavor) and its total number of sales.

SELECT g.Flavor, g.Food, COUNT(GId)
FROM items i JOIN goods g ON g.GId = i.Item
GROUP BY g.GId
ORDER BY COUNT(GId) DESC
LIMIT 1;


USE `BAKERY`;
-- Query 5
-- Find the day of the highest revenue in the month of October, 2007.


SELECT r.SaleDate
FROM customers c JOIN receipts r ON r.Customer = c.CId JOIN items i ON
    i.Receipt = r.RNumber JOIN goods g ON g.GId = i.Item
WHERE r.SaleDate LIKE '2007-10-%'
GROUP BY r.SaleDate
ORDER BY SUM(g.Price) DESC
LIMIT 1;


USE `BAKERY`;
-- Query 6
--  Find the best-selling item (by number of purchases)  on the day of the highest revenue in October of 2007.

SELECT g.Food, g.Flavor, COUNT(GId)
FROM items i JOIN goods g ON g.GId = i.Item JOIN receipts r 
    ON i.Receipt = r.RNumber, (
        SELECT r.SaleDate
        FROM customers c JOIN receipts r ON r.Customer = c.CId JOIN items i ON
          i.Receipt = r.RNumber JOIN goods g ON g.GId = i.Item
        WHERE r.SaleDate LIKE '2007-10-%'
        GROUP BY r.SaleDate
        ORDER BY SUM(g.Price) DESC
        LIMIT 1
        ) q1
WHERE r.SaleDate = q1.SaleDate
GROUP BY g.GId
ORDER BY COUNT(GId) DESC
LIMIT 1;


USE `BAKERY`;
-- Query 7
-- For every type of Cake report the customer(s) who purchased it
the largest number of times during the month of October 2007. Report the name of the pastry (flavor, food type), the name of the customer (first, last), and the number of purchases made. Sort output in descending order on the number of purchases, then in alphabetical order by cake flavor, then in alphabetical order by last name of the customer.

SELECT MaxPurTable.Flavor, MaxPurTable.Food, c.FirstName, c.LastName, MaxPur
FROM customers c, (
    SELECT CustPurTable.Food, CustPurTable.Flavor, 
        MAX(CustPurTable.CustPur) AS MaxPur
    FROM (
        SELECT g.Food, g.Flavor, r.Customer, COUNT(i.Receipt) AS CustPur
        FROM goods g, items i, receipts r
        WHERE g.Food = 'Cake' AND r.SaleDate >= '2007-10-01' AND 
            r.SaleDate <= '2007-10-31' AND g.GId = i.Item AND 
            i.Receipt = r.RNumber
        GROUP BY g.Food, g.Flavor, r.Customer 
        ) CustPurTable
    WHERE CustPurTable.Flavor IN (SELECT Flavor FROM goods WHERE Food = 'Cake')
    GROUP BY CustPurTable.Flavor
    ) MaxPurTable, (
        SELECT g.Flavor, r.Customer AS 'CustId', COUNT(i.Receipt) AS CustPur
        FROM goods g, items i, receipts r
        WHERE g.Food = 'Cake' AND r.SaleDate >= '2007-10-01' AND 
            r.SaleDate <= '2007-10-31' AND g.GId = i.Item 
            AND i.Receipt = r.RNumber
        GROUP BY g.Flavor, r.Customer
    ) CustPurTable
WHERE CustPurTable.Flavor = MaxPurTable.Flavor AND CustPur = MaxPur
    AND c.CId = CustPurTable.CustId
ORDER BY MaxPur DESC, MaxPurTable.Flavor, c.LastName;


USE `BAKERY`;
-- Query 8
--  Output the names of all customers who did not make a purchase between
October 19 and October 23 (inclusive) of 2007. Output first and last names
in alphabetical order by last name.


SELECT customers.FirstName, customers.LastName
FROM customers
WHERE (customers.FirstName, customers.LastName) NOT IN (
    SELECT DISTINCT c.FirstName, c.LastName
    FROM customers c JOIN receipts r ON r.Customer = c.CId
    WHERE r.SaleDate <= '2007-10-23' AND r.SaleDate >= '2007-10-19'
    );


USE `BAKERY`;
-- Query 9
-- For each customer report (in a single row per customer) the number of purchases of Eclairs, Danishes, and Pies.  If the customer did not purchase one or more of these items, you are allowed to report NULL for that purchase. Sort output in alphabetical order by customer last name.
SELECT c.FirstName, c.LastName, SUM(IF(g.Food = 'eclair', 1, NULL)) as Eclairs,
    SUM(IF(g.Food = 'Danish', 1, NULL)) as Danishes,
    SUM(IF(g.Food = 'Pie', 1, NULL)) as Pies
FROM customers c JOIN receipts r ON c.CId = r.Customer JOIN items i ON
    r.RNumber = i.Receipt JOIN goods g ON i.Item = g.GId
GROUP BY c.CId
ORDER BY c.LastName ASC;


USE `BAKERY`;
-- Query 10
-- Find out if the sales of Chocolate-flavored items (in terms of revenue)
or the sales of Croissants (of all flavors) were higher in October of 2007.
Output the word Chocolate, if the sales of Chocolate-flavored items
had higher revenue,  or the word Croissant if the sales of Croissants had higher revenue.


Note: This can be done in a number of ways. One way involved the CASE ... WHEN clause inside the SELECT clause, but there are ways of building the output without the use of any "exotic" features.


SELECT
    CASE
        WHEN (SELECT SUM(goods.PRICE)
            FROM items JOIN goods on items.Item = goods.GId
            WHERE goods.Flavor = 'Chocolate') >
            (SELECT SUM(goods.PRICE)
            FROM items JOIN goods ON items.Item = goods.GId
            WHERE goods.Food = 'Croissant') THEN 'Chocolate'
        ELSE 'Croissant'
    END AS Result;


