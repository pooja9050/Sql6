#512. Game Play Analysis II
SELECT a1.player_id, a1.device_id
FROM Activity a1 
WHERE (a1.player_id, a1.event_date) IN (
    SELECT a2.player_id, MIN(a2.event_date) 
    FROM Activity a2 
    GROUP BY a2.player_id);

#Using CTE
WITH CTE AS(
    SELECT a2.player, MIN(a2.event_date) AS 'event_date'
    FROM Activity a2 GROUP BY a2.player_id
)
SELECT a1.player_id, a1.device_id FROM Activity a1
INNER JOIN CTE c ON a1.player_id = c.player_id AND
a1.event_date = c.event_date;

#534. Game Play Analysis III
# Write your MySQL query statement below
SELECT player_id, event_date, SUM(games_played) OVER (PARTITION BY player_id order by event_date) AS 'games_played_so_far'
FROM Activity;

#Alternative
#Time exceeded
SELECT a1.player_id, a1.event_date,(
    SELECT SUM(a2.games_played) FROM Activity a2 WHERE a1.player_id = a2.player_id AND a2.event_date <= a1.event_date
) AS 'games_played_so_far' from Activity a1;


#175. Combine Two Tables
# Write your MySQL query statement below
SELECT p.firstName, p.lastName, a.city, a.state 
FROM Person p LEFT JOIN Address a ON p.personId = a.personId;

#Alternative RIGHT JOIN
SELECT p.firstName, p.lastName, a.city, a.state 
FROM Address a RIGHT JOIN Person p ON p.personId = a.personId;

#612. Shortest Distance in a Plane
# Write your MySQL query statement below
SELECT p1.x, p2x, p1.y,p2.y, SQRT(POW(p2.x - p1.x,2) + POW())
SELECT ROUND(MIN(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM Point2D p1
JOIN Point2D p2 ON p1.x != p2.x OR p1.y != p2.y;

#2474. Customers With Strictly Increasing Purchases
# Write your MySQL query statement below
WITH CTE AS(
    SELECT customer_id, YEAR(order_date) AS 'year', SUM(price) as 'price'
    FROM Orders
    GROUP BY year, customer_id
    ORDER BY Customer_id, year
)

SELECT c1.customer_id
FROM CTE c1 LEFT JOIN CTE c2
ON c1.customer_id = c2.customer_id AND c1.year+1 = c2.year AND c1.price < c2.price
GROUP BY 1
Having
COUNT(*) - COUNT(c2.customer_id) = 1;




