
SET ECHO ON;
--1. List the book title and retail price for all books with a
-- retail price lower than the average retail price of all books sold by Wolf Books.
SELECT title, retail
FROM books
WHERE retail < (SELECT AVG(retail) FROM Books);
--2. Determine which books cost less than the average cost of
--other books in the same category.

SELECT b.Title, b.Cost, b.Category
FROM Books b
WHERE b.Cost < (SELECT AVG(b2.Cost)
                FROM Books b2
                WHERE b2.Category = b.Category
                  AND b2.ISBN <> b.ISBN);
                  
--3. Determine which orders were shipped to the same state as order 1014.

SELECT Order#, ShipState
FROM Orders
WHERE ShipState = (
  SELECT ShipState
  FROM Orders
  WHERE Order# = 1014
);

--4. Determine which orders had a higher total amount paid than order 1008.
    
SELECT o.Order#, SUM(oi.Quantity * oi.PaidEach) AS "Total Paid"
FROM Orders o
JOIN OrderItems oi ON o.Order# = oi.Order#
GROUP BY o.Order#
HAVING SUM(oi.Quantity * oi.PaidEach) > (
  SELECT SUM(oi.Quantity * oi.PaidEach)
  FROM OrderItems oi
  WHERE oi.Order# = 1008
);
--5. Determine which author or authors wrote the books most
--frequently purchased by customers of Wolf Books.
SELECT a.Fname, a.Lname
FROM Author a
INNER JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
INNER JOIN (
  SELECT ISBN, SUM(Quantity) AS TotalQuantity
  FROM OrderItems
  GROUP BY ISBN
  ORDER BY TotalQuantity DESC
) oi ON ba.ISBN = oi.ISBN
GROUP BY a.Fname, a.Lname
ORDER BY SUM(oi.TotalQuantity) DESC
FETCH FIRST 1 ROW ONLY;

--6. List the title of all books in the same category as books
--previously purchased by customer 1007. Don't include books this customer has already purchased.
SELECT DISTINCT b.Title
FROM Books b
WHERE b.Category IN (
  SELECT b2.Category
  FROM Books b2
  INNER JOIN OrderItems oi ON b2.ISBN = oi.ISBN
  INNER JOIN Orders o ON oi.Order# = o.Order#
  WHERE o.Customer# = 1007
)
AND b.ISBN NOT IN (
  SELECT oi.ISBN
  FROM OrderItems oi
  INNER JOIN Orders o ON oi.Order# = o.Order#
  WHERE o.Customer# = 1007
);

--7. List the shipping city and state for the order that had
--the longest shipping delay.
SELECT ShipCity, ShipState
FROM Orders
WHERE (OrderDate - ShipDate) = (
    SELECT MAX(OrderDate - ShipDate)
    FROM Orders
    WHERE ShipDate IS NOT NULL
);

--8. Determine which customers placed orders for the least
--expensive book (in terms of regular retail price) carried by Wolf Books.
SELECT c.FirstName, c.LastName
FROM Customers c
INNER JOIN Orders o ON c.Customer# = o.Customer#
INNER JOIN OrderItems oi ON o.Order# = oi.Order#
INNER JOIN Books b ON oi.ISBN = b.ISBN
WHERE b.Retail = (
    SELECT MIN(Retail)
    FROM Books
)
GROUP BY c.FirstName, c.LastName;

--9. Determine the number of different customers who have
--placed an order for books written or cowritten by James Austin.
SELECT COUNT(DISTINCT o.Customer#)
FROM Orders o
INNER JOIN OrderItems oi ON o.Order# = oi.Order#
INNER JOIN BookAuthor ba ON oi.ISBN = ba.ISBN
WHERE ba.AuthorID = (
    SELECT AuthorID
    FROM Author
    WHERE Fname = 'JAMES' AND Lname = 'AUSTIN'
);

--10. Determine which books were published by the publisher of The Wok Way to Cook.
SELECT b.Title
FROM Books b
WHERE b.PubID = (
    SELECT PubID
    FROM Books
    WHERE Title = 'THE WOK WAY TO COOK'
);