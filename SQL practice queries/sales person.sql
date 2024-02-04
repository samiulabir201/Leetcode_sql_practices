-- -- Create SalesPerson table
-- CREATE TABLE my_new_database.SalesPerson (
--     sales_id INT PRIMARY KEY,
--     name VARCHAR(255),
--     salary INT,
--     commission_rate INT,
--     hire_date DATE
-- );

-- -- Insert values into SalesPerson table
-- INSERT INTO my_new_database.SalesPerson (sales_id, name, salary, commission_rate, hire_date)
-- VALUES
--     (1, 'John', 100000, 6, '2006-04-01'),
--     (2, 'Amy', 12000, 5, '2010-05-01'),
--     (3, 'Mark', 65000, 12, '2008-12-25'),
--     (4, 'Pam', 25000, 25, '2005-01-01'),
--     (5, 'Alex', 5000, 10, '2007-02-03');

-- -- Create Company table
-- CREATE TABLE my_new_database.Company (
--     com_id INT PRIMARY KEY,
--     name VARCHAR(255),
--     city VARCHAR(255)
-- );

-- -- Insert values into Company table
-- INSERT INTO my_new_database.Company (com_id, name, city)
-- VALUES
--     (1, 'RED', 'Boston'),
--     (2, 'ORANGE', 'New York'),
--     (3, 'YELLOW', 'Boston'),
--     (4, 'GREEN', 'Austin');

-- Create Orders table
-- CREATE TABLE my_new_database.newOrders (
--     order_id INT PRIMARY KEY,
--     order_date DATE,
--     com_id INT,
--     sales_id INT,
--     amount INT,
--     FOREIGN KEY (com_id) REFERENCES my_new_database.Company(com_id),
--     FOREIGN KEY (sales_id) REFERENCES my_new_database.SalesPerson(sales_id)
-- );

-- -- Insert values into Orders table
-- INSERT INTO my_new_database.newOrders (order_id, order_date, com_id, sales_id, amount)
-- VALUES
--     (1, '2014-01-01', 3, 4, 10000),
--     (2, '2014-02-01', 4, 5, 5000),
--     (3, '2014-03-01', 1, 1, 50000),
--     (4, '2014-04-01', 1, 4, 25000);

-- pandas
-- Approach: Joining Tables and Using Exclusion with "NOT IN"
-- Algorithm
-- If we know all the salespersons who have sales in this company 'RED', it will be fairly easy to know who does not have.

-- We consider salespersons related to orders related to the company "RED" by joining the DataFrame orders with company, and selecting the orders having name as 'RED'. This helps retain only those orders that are associated with the company "RED".

-- df = pd.merge(orders, company, on='com_id')

-- red_orders = df[df['name'] == 'RED']
-- We will have the following DataFrame red_orders:

-- | order_id | date     | com_id | sales_id | amount | com_id | name | city   |
-- |----------|----------|--------|----------|--------|--------|------|--------|
-- | 3        | 3/1/2014 | 1      | 1        | 50000  | 1      | RED  | Boston |
-- | 4        | 4/1/2014 | 1      | 4        | 25000  | 1      | RED  | Boston |

-- Next, we use red_orders.sales_id.unique() to obtain all the unique sales IDs in the red_orders. These are the identifiers for individual salespersons and will help us filter "valid" salespersons. We store these unique sales IDs in a variable called invalid_ids. We'll use invalid_ids in the next step to filter out "invalid" salespersons who have at least one of these IDs and focus on "valid" salespersons that are not related to these sales IDs.

-- invalid_ids = red_orders.sales_id.unique()
-- We can obtain the invalid_ids:

-- [1 4]

-- Next, we will check for each salesperson's sales ID if it appears in invalid_ids, the collection of unique invalid sales IDs. This step is about selecting those "valid" salespersons whose sales IDs are not found in the invalid_ids. Note that the symbol ~ negates the condition, meaning it keeps the salespersons whose sales IDs are NOT in invalid_ids. In other words, we retrieve the salespersons that are unrelated to the "invalid" sales IDs.

-- valid_sales_person = sales_person[~sales_person['sales_id'].isin(invalid_ids)]
-- We will obtain the following DataFrame valid_sales_person:

-- sales_id	name	salary	commission_rate	hire_date
-- 2	Amy	12000	5	2010-05-01
-- 3	Mark	65000	12	2008-12-25
-- 5	Alex	5000	10	2007-02-03

-- Note that we need to follow the question's requirement and return only the column name. Hence the complete code is as follows:

-- Implementation

-- name
-- Amy
-- Mark
-- Alex

-- database
-- Approach: Joining Tables and Using Exclusion with "NOT IN"
-- Algorithm
-- To start, we can query the information of sales in company 'RED' as a temporary table. And then try to build a connection between this table and the salesperson table since it has the name information.

-- SELECT
--     *
-- FROM
--     orders o
--         LEFT JOIN
--     company c ON o.com_id = c.com_id
-- WHERE
--     c.name = 'RED'
-- ;
-- Note: "LEFT OUTER JOIN" could be written as "LEFT JOIN".

-- | order_id | date     | com_id | sales_id | amount | com_id | name | city   |
-- |----------|----------|--------|----------|--------|--------|------|--------|
-- | 3        | 3/1/2014 | 1      | 1        | 50000  | 1      | RED  | Boston |
-- | 4        | 4/1/2014 | 1      | 4        | 25000  | 1      | RED  | Boston |
-- Obviously, the column sales_id exists in table salesperson so we may use it as a subquery, and then utilize the NOT IN to get the target data.

-- Implementation
SELECT
    s.name
FROM
    my_new_database.salesperson s
WHERE
    s.sales_id NOT IN (SELECT
            o.sales_id
        FROM
            my_new_database.neworders o
                LEFT JOIN
            my_new_database.company c ON o.com_id = c.com_id
        WHERE
            c.name = 'RED')
;
