-- Lab 4 - BAKERY
-- amakarew
-- May 17, 2023

USE `BAKERY`;
-- Query 1
-- Find all cookies that cost between $1 and $2 (inclusive). Report the name of the cookie  (flavor, food) and the price, sort output in alphabetical order by the cookie flavor.

SELECT Flavor, Food, Price
FROM goods
WHERE Food='cookie' AND Price>=1 AND Price<=2
ORDER BY Flavor;


USE `BAKERY`;
-- Query 2
-- Report the prices of the following items:

(a)  any Pie

(b)  any item priced between $3.40 and $3.65 (inclusive)

(c) Any Croissant except the Apple one.

Output the flavor, the name (food type) and the price of each pastry. Output results in ascending order by price.

SELECT Flavor, Food, Price
FROM goods
WHERE Food='pie' OR (Price>=3.4 AND Price<=3.65) OR 
    (Food='croissant' AND Flavor!='Apple')
ORDER BY Price;


USE `BAKERY`;
-- Query 3
-- Find all customers who made a purchase on October 17, 2007. Report
the name of the customer (first, last). Sort the output in alphabetical
order by the customer's last name. The output shall contain NO duplicate
names.
SELECT DISTINCT customers.LastName, customers.FirstName
FROM receipts, customers
WHERE receipts.SaleDate='2007-10-17' AND customers.CId=receipts.Customer
ORDER BY LastName;


USE `BAKERY`;
-- Query 4
-- Find all different  Croissants items purchased on October 9, 2007.
Each tart (flavor, food) is to be listed once.
 Sort output in alphabetical order by the Croissant flavor.
SELECT DISTINCT goods.Flavor, goods.Food
FROM goods, receipts, items
WHERE receipts.SaleDate='2007-10-09' AND receipts.RNumber = items.Receipt
    AND goods.GId = items.Item AND goods.Food='croissant'
ORDER BY goods.Flavor;


USE `BAKERY`;
-- Query 5
-- Find all purchases which involved two (or more) of the same Apricot-flavored item. Report the receipt number, the name of the item purchases, and the date of the purchase. Sort in chronological order.
SELECT DISTINCT receipts.RNumber, goods.Flavor, goods.Food, receipts.SaleDate
FROM receipts, goods, items AS i1, items AS i2
WHERE receipts.RNumber=i1.Receipt AND i1.Receipt=i2.Receipt 
    AND i1.Item=i2.Item AND i1.Ordinal!=i2.Ordinal
    AND i1.Item=goods.GId AND goods.Flavor='Apricot'
ORDER BY receipts.SaleDate;


USE `BAKERY`;
-- Query 6
-- Find the day on which MIGDALIA  STADICK made multiple purchases (i.e., had at least two different receipts from the bakery). Report just the date (if multiple dates match the query, report them in chronological order).

SELECT DISTINCT r1.SaleDate
FROM customers, receipts as r1, receipts as r2
WHERE customers.FirstName='MIGDALIA' AND customers.LastName='STADICK'
    AND customers.CId=r1.Customer AND r1.SaleDate=r2.SaleDate
    AND r1.RNumber!=r2.RNumber AND r1.Customer=r2.Customer
ORDER BY r1.SaleDate;


