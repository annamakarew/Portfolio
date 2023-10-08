-- Lab 5 - BAKERY
-- amakarew
-- May 23, 2023

USE `BAKERY`;
-- Query 1
--  Find all customers who purchased, during the same trip to the bakery,
two different (i.e., different flavor)  Cookies, one of which is Tuile. Report the date of the purchase, and the first and last names of the customers in chronological order.

SELECT SaleDate, FirstName, LastName
FROM customers, items AS i1, items AS i2, receipts, goods AS g1, goods AS g2
WHERE i1.Receipt = i2.Receipt AND i1.ordinal != i2.ordinal AND g1.Food='Cookie'
    AND g2.Food='Cookie' AND g1.Flavor = 'Tuile' AND g2.Flavor!='Tuile' AND 
    g1.GId = i1.Item AND g2.GId = i2.Item AND i1.Receipt = receipts.RNumber
    AND receipts.Customer = customers.CId
ORDER BY SaleDate;


USE `BAKERY`;
-- Query 2
--  Find all days on which either ASHARRON TOUSSAND made
a purchase that contained five items, or someone purchased a Gongolais Cookie. Sort dates in chronological order. Each date shall appear exactly once.

SELECT DISTINCT SaleDate
FROM receipts, customers, items, goods
WHERE (FirstName='ASHARRON' AND LastName = 'TOUSSAND' AND CId = Customer AND
    RNumber = Receipt and Ordinal = 5) OR Food = 'Cookie' 
    AND Flavor = 'Gongolais' AND GId=Item AND Receipt=RNumber
ORDER BY SaleDate;


USE `BAKERY`;
-- Query 3
--  Report the total amount of money  JULIET LOGAN  spent at the bakery
during the first ten days of the month of October, 2007.

SELECT SUM(PRICE)
FROM customers, receipts, items, goods
WHERE FirstName = 'JULIET' AND LastName = 'LOGAN' AND CId=Customer
    AND SaleDate >= '2007-10-01' AND SaleDate<= '2007-10-10' 
    AND RNumber = Receipt AND Item=GId;


USE `BAKERY`;
-- Query 4
--  Report the total number of purchases (i.e., unique receipts)  that included a cake.

SELECT COUNT(DISTINCT RNumber)
FROM goods, items, receipts
WHERE Food = 'Cake' AND GId = Item AND Receipt = RNumber;


USE `BAKERY`;
-- Query 5
-- Report the total number of  cakes  bought in the bakery during the month of October of 2007.
SELECT COUNT(*)
FROM receipts, items, goods
WHERE SaleDate >= '2007-10-01' AND SaleDate <= '2007-10-31' 
    AND RNumber = Receipt AND Item = GId AND Food = 'Cake';


