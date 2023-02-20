.mode column
.header on

CREATE TABLE dim_date (
    dateId INT UNIQUE NOT NULL PRIMARY KEY,
    dayOfMonth SMALLINT NOT NULL,
    month SMALLINT NOT NULL,
    year INT NOT NULL
  );

CREATE TABLE dim_customer (
    customerId INT UNIQUE NOT NULL PRIMARY KEY,
    customerName TEXT
  );

CREATE TABLE dim_menu (
    menuId INT UNIQUE NOT NULL PRIMARY KEY,
    menuName TEXT,
    price REAL
);

CREATE TABLE dim_branch (
    branchId INT UNIQUE NOT NULL PRIMARY KEY,
    branchName TEXT
);

CREATE TABLE fact_orders (
		orderId INT UNIQUE NOT NULL,
    dateId INT,
    customerId INT,
    menuId INT,
    branchId INT,
    quantitySold INT,
    totalPrice REAL,
    PRIMARY KEY (orderId),
    FOREIGN KEY (dateId) REFERENCES dim_date(dateId),
    FOREIGN KEY (customerId) REFERENCES dim_customer(customerId),
    FOREIGN KEY (menuId) REFERENCES dim_menu(menuId),
    FOREIGN KEY (branchId) REFERENCES dim_branch(branchId)
  );

-- CREATE TABLE dim_date (
--     dateId INT UNIQUE NOT NULL PRIMARY KEY,
--     dayOfMonth SMALLINT NOT NULL,
--     month SMALLINT NOT NULL,
--     year INT NOT NULL,
--   );

INSERT INTO dim_date VALUES
  (20221201, 1, 12, 2022),
  (20221202, 2, 12, 2022),
  (20221203, 3, 12, 2022),
  (20221204, 4, 12, 2022),
  (20221205, 5, 12, 2022),
  (20221206, 6, 12, 2022),
  (20221207, 7, 12, 2022),
  (20221208, 8, 12, 2022),
  (20221209, 9, 12, 2022),
  (20221210, 10, 12, 2022),
  (20221211, 11, 12, 2022),
  (20221212, 12, 12, 2022);

-- CREATE TABLE dim_customer (
--     customerId INT UNIQUE NOT NULL PRIMARY KEY,
--     customerName TEXT,
--   );

INSERT INTO dim_customer VALUES
  (1, 'Jane'),
  (2, 'Apeach'),
  (3, 'Stella Lou'),
  (4, 'Unicorn');

-- CREATE TABLE dim_menu (
--     menuId INT UNIQUE NOT NULL PRIMARY KEY,
--     menuName TEXT,
--     price REAL,
-- );

INSERT INTO dim_menu VALUES
  (1, 'TomYumKoong', 250.0),
  (2, 'YumWonsen', 180.0),
  (3, 'Cola', 20.0),
  (4, 'KraPawMhoo', 150.0);

-- CREATE TABLE dim_branch (
--     branchId INT UNIQUE NOT NULL PRIMARY KEY,
--     branchName TEXT,
-- );

INSERT INTO dim_branch VALUES
  (1, 'The Mall Thapra'),
  (2, 'Icon Siam'),
  (3, 'Siam Paragon'),
  (4, 'Seacon Bangkae');  

-- CREATE TABLE fact_orders (
-- 		orderId INT UNIQUE NOT NULL,
--     dateId INT,
--     customerId INT,
--     menuId INT,
--     branchId INT,
--     quantitySold INT,
--     totalPrice REAL,
--     PRIMARY KEY (orderId),
--     FOREIGN KEY (dateId) REFERENCES dim_date(dateId),
--     FOREIGN KEY (customerId) REFERENCES dim_customer(customerId),
--     FOREIGN KEY (menuId) REFERENCES dim_menu(menuId),
--     FOREIGN KEY (branchId) REFERENCES dim_branch(branchId)
--   );

INSERT INTO fact_orders VALUES
  (1, 20221201, 1, 1, 1, 2, 500.0),
  (2, 20221201, 2, 1, 1, 1, 250.0),
  (3, 20221202, 1, 2, 1, 1, 180.0),
  (4, 20221203, 1, 3, 1, 1, 20.0),
  (5, 20221203, 4, 1, 2, 2, 500.0),
  (6, 20221203, 2, 1, 1, 1, 250.0),
  (7, 20221204, 3, 1, 4, 2, 500.0),
  (8, 20221204, 1, 1, 1, 1, 250.0),
  (9, 20221205, 1, 2, 3, 1, 180.0),
  (10, 20221205, 1, 3, 1, 1, 20.0),
  (11, 20221205, 4, 1, 2, 2, 500.0),
  (12, 20221205, 3, 1, 1, 1, 250.0);

SELECT * FROM fact_orders;
SELECT * FROM dim_date;
SELECT * FROM dim_customer;
SELECT * FROM dim_menu;
SELECT * FROM dim_branch;

-- -- เขียน SELECT WITH หรือใช้ subqueries
-- Who is the top spender?

WITH customer_totalspend AS (
  SELECT ford.customerId AS customerId, 
  dcust.customerName AS customerName, 
  SUM(ford.totalPrice) as totalSpend
  FROM fact_orders ford 
  LEFT JOIN dim_customer dcust
  ON ford.customerId = dcust.customerId
  GROUP BY ford.customerId
)

SELECT customerId, customerName, MAX(totalSpend)
FROM customer_totalspend;
