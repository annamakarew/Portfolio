-- Lab 6 - BAKERY
-- amakarew
-- Jun 1, 2023

USE `BAKERY`;
-- Query 1
--  Report all customers who made more than 10 different purchases (unique receipts)  from the bakery. Report first and last name of the customer, sort output in alphabetical order
by last name.


SELECT FirstName, LastName, COUNT(*)
FROM customers JOIN receipts on CId = Customer
GROUP BY FirstName, LastName
HAVING COUNT(*) > 10
ORDER BY LastName;


USE `BAKERY`;
-- Query 2
-- For each flavor of cookie report total number of times it was purchased (count the actual cookies, not receipts), number of unique customers who purchased the cookie, and the total sales amount. Sort output in alphabetical order by cookie flavor.

SELECT Flavor, COUNT(Item), COUNT(DISTINCT Customer), SUM(PRICE)
FROM items JOIN goods ON GId = Item JOIN receipts ON Receipt = RNumber
WHERE Food = 'Cookie'
GROUP BY Flavor;


USE `BAKERY`;
-- Query 3
--  For each day of the week of October 15 (Monday to Sunday) report the total
number of purchases (receipts), the total number of pastries purchased and the overall daily revenue.  Report results in chronological order and include both the day of the week  and the date.   (Note: the total amounts paid may look
strange, if you are using floating points for prices.)


SELECT DISTINCT DAYNAME(SaleDate), SaleDate, COUNT(DISTINCT Receipt), COUNT(Item),
    SUM(PRICE)
FROM items JOIN receipts ON Receipt = RNumber JOIN goods ON GId = Item
WHERE SaleDate >= '2007-10-15' AND SaleDate < '2007-10-22'
GROUP BY SaleDate
ORDER BY SaleDate;


USE `BAKERY`;
-- Query 4
-- Find all purchases that totaled $25 or more. Report the customer who made the purchase, the receipt number, and the total amount of the purchase. Sort output in descending order by the total amount.
SELECT FirstName, LastName, Receipt, SUM(PRICE)
FROM receipts JOIN items ON RNumber = Receipt JOIN goods ON Item = GId
    JOIN customers ON CId = Customer
GROUP BY Receipt
HAVING SUM(PRICE) > 25
ORDER BY SUM(PRICE) DESC;


USE `BAKERY`;
-- Query 5
-- For each customer, count the number of times they purchased exactly five items from the bakery on a single receipt. Report last name, first name, and the number of five-item purchases sorted in chronological order by the last purchase made, breaking the ties in alphabetical order of the last name. (note: if you study the database carefully, you will discover that
the maximum number of items purchased on the same receipt in is five).
SELECT FirstName, LastName, COUNT(DISTINCT Receipt)
FROM customers JOIN receipts ON CId = Customer JOIN items ON RNumber = Receipt
WHERE Ordinal = 5
GROUP BY FirstName, LastName
ORDER BY MAX(SaleDate), LastName;


