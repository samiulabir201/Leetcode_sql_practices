-- -- Create Users table
-- CREATE TABLE my_new_database.Users (
--     user_id INT PRIMARY KEY,
--     join_date DATE,
--     favorite_brand VARCHAR(50)
-- );

-- -- Insert values into Users table
-- INSERT INTO my_new_database.Users (user_id, join_date, favorite_brand)
-- VALUES
--     (1, '2018-01-01', 'Lenovo'),
--     (2, '2018-02-09', 'Samsung'),
--     (3, '2018-01-19', 'LG'),
--     (4, '2018-05-21', 'HP');

-- -- Create Items table
-- CREATE TABLE my_new_database.Items (
--     item_id INT PRIMARY KEY,
--     item_brand VARCHAR(50)
-- );

-- -- Insert values into Items table
-- INSERT INTO my_new_database.Items (item_id, item_brand)
-- VALUES
--     (1, 'Samsung'),
--     (2, 'Lenovo'),
--     (3, 'LG'),
--     (4, 'HP');

-- -- Create Orders table
-- CREATE TABLE my_new_database.Orders (
--     order_id INT PRIMARY KEY,
--     order_date DATE,
--     item_id INT,
--     buyer_id INT,
--     seller_id INT,
--     FOREIGN KEY (item_id) REFERENCES Items(item_id),
--     FOREIGN KEY (buyer_id) REFERENCES Users(user_id),
--     FOREIGN KEY (seller_id) REFERENCES Users(user_id)
-- );

-- -- Insert values into Orders table
-- INSERT INTO my_new_database.Orders (order_id, order_date, item_id, buyer_id, seller_id)
-- VALUES
--     (1, '2019-08-01', 4, 1, 2),
--     (2, '2018-08-02', 2, 1, 3),
--     (3, '2019-08-03', 3, 2, 3),
--     (4, '2018-08-04', 1, 4, 2),
--     (5, '2018-08-04', 1, 3, 4),
--     (6, '2019-08-05', 2, 2, 4);


-- Overview

-- The problem revolves around an online shopping platform where users can both buy and sell items.

-- Users Table: Contains information about individual users, such as when they joined.
-- Orders Table: Captures transactions, detailing who bought what, and when.
-- Items Table: Lists available items and their associated brands.
-- The main objective is to determine for each user:

-- When they joined.
-- How many items they purchased in the year 2019.
-- This analysis helps in understanding user engagement on the platform for that specific year.

-- Pandas
-- Approach 1: Right Join and GroupBy
-- Flowchart

-- Intuition
-- Let's break down the intuition behind the approach:

-- Purpose:
-- The function market_analysis aims to analyze the number of items each user purchased in the year 2019. It takes three dataframes (users, orders, and items) as input and returns a dataframe summarizing the number of orders each user made in 2019, along with their joining date.

-- Step-by-step Intuition:

-- Filtering 2019 Orders:

-- orders.query("order_date.dt.year==2019")
-- Here, the algorithm starts by filtering the orders dataframe to only include rows where the order_date is from the year 2019.

-- Merging Data:

-- merge(users, left_on="buyer_id", right_on="user_id", how="right")
-- The filtered orders from 2019 are then merged (joined) with the users dataframe. This joining happens based on the buyer_id from the orders dataframe and user_id from the users dataframe.

-- The key point here is the use of how="right", which is a right join. This ensures that all users are included in the resulting dataframe, even if they didn't make any purchases in 2019. For users without any purchases in 2019, order-related columns will have null values.

-- Grouping & Counting:

-- df.groupby(["user_id", "join_date"]).item_id.count()
-- The merged dataframe is grouped by user_id and join_date. For each group (essentially each user), the algorithm counts the number of item_ids, which represents the number of orders the user made in 2019.

-- Formatting the Output:

-- .reset_index().rename(columns={"user_id": "buyer_id", "item_id": "orders_in_2019"})
-- The output from the grouping operation is formatted to present the data in a clearer manner. The index is reset to make user_id and join_date regular columns. Then, column names are renamed for clarity:

-- user_id is renamed to buyer_id.
-- The count of item_id (representing order count) is renamed to orders_in_2019.
-- The algorithm efficiently combines and transforms data from the orders and users dataframes to produce a user-centric summary of purchase activity in 2019. Users with zero purchases are not excluded, ensuring a comprehensive overview of all users.

-- Implementation

-- Database
-- Approach 1: Left Join and Aggregation
-- Intuition
-- The query aims to capture the purchasing behavior of each user in 2019 by leveraging a left join. By joining the users to their respective orders, it ensures all users are represented, tallying up each user's purchases in that year, while also including those who made no purchases.

-- Step-by-step Intuition:

-- Base Table (FROM Clause):
-- The query starts with the Users table, aliased as u. This table will serve as the foundation of our result, ensuring that all users will be represented in the output, regardless of whether they made any purchases in 2019 or not.

-- Joining with Orders (LEFT JOIN):

-- LEFT JOIN Orders o ON u.user_id = o.buyer_id AND YEAR(order_date) = '2019'
-- The query then performs a LEFT JOIN with the Orders table (aliased as o). This kind of join ensures that even users without matching orders (i.e., users who made no purchases) will still be included in the result.

-- Two conditions are applied for the join:

-- Matching users in the Users table with buyers in the Orders table based on their IDs.
-- Filtering the orders to only include those from the year 2019.
-- Aggregation (GROUP BY):

-- GROUP BY u.user_id
-- The query groups the combined data by user_id. This is done to consolidate all the orders of each user into a single row.

-- Selecting Relevant Columns:
-- The following columns are selected for the final output:

-- u.user_id (aliased as buyer_id): The ID of the user.
-- join_date: The date the user joined.
-- COUNT(o.order_id) AS orders_in_2019: This counts the number of orders (from 2019) for each user. If a user didn't make any orders in 2019, this value will be 0, thanks to the nature of the LEFT JOIN.
-- Ordering the Output:

-- ORDER BY u.user_id
-- The result is then sorted by user_id in ascending order to present the data in a structured manner.

-- The SQL code is designed to provide insights into the purchasing behavior of users for the year 2019. It's efficient in ensuring that even users with zero purchases are included in the output, giving a comprehensive overview of all users on the platform for that year.

-- Implementation
SELECT 
  u.user_id AS buyer_id, 
  join_date, 
  COUNT(o.order_id) AS orders_in_2019 
FROM 
  my_new_database.Users u 
  LEFT JOIN my_new_database.Orders o ON u.user_id = o.buyer_id 
  AND YEAR(order_date)= '2019' 
GROUP BY 
  u.user_id 
ORDER BY 
  u.user_id