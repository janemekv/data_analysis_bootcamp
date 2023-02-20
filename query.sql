.mode column
.header on

SELECT * FROM fact_orders;
SELECT * FROM dim_date;
SELECT * FROM dim_customer;
SELECT * FROM dim_menu;
SELECT * FROM dim_branch;

-- -- เขียน SELECT WITH หรือใช้ subqueries
-- Who is the top spender?
SELECT ford.customerId, 
  dcust.customerName, 
  SUM(ford.totalPrice) as totalSpend
FROM fact_orders ford 
LEFT JOIN dim_customers dcust
ON ford.customerId = dcust.customerId
GROUP BY ford.customerId
ORDER BY totalSpend DESC;


