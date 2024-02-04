-- USE my_new_database;

-- Create the Users table
-- CREATE TABLE IF NOT EXISTS TravelUsers (
--     id INT PRIMARY KEY,
--     name VARCHAR(50)
-- );

-- Insert values into the Users table
-- INSERT INTO TravelUsers (id, name) VALUES
-- (1, 'Alice'),
-- (2, 'Bob'),
-- (3, 'Alex'),
-- (4, 'Donald'),
-- (7, 'Lee'),
-- (13, 'Jonathan'),
-- (19, 'Elvis');

-- Create the Rides table
-- CREATE TABLE IF NOT EXISTS Rides (
--     id INT PRIMARY KEY,
--     user_id INT,
--     distance INT
-- );

-- Insert values into the Rides table
-- INSERT INTO Rides (id, user_id, distance) VALUES
-- (1, 1, 120),
-- (2, 2, 317),
-- (3, 3, 222),
-- (4, 7, 100),
-- (5, 13, 312),
-- (6, 19, 50),
-- (7, 7, 120),
-- (8, 19, 400),
-- (9, 7, 230);

-- Overview
-- This is the type of question that you might want to slow down and pay attention to the details before writing:

-- Since the question is asking for the distance travelled by each user and there may be users who have not travelled any distance, LEFT JOIN is needed so each user from the Users table will be included.

-- For those users who have not travelled, functions such as IFNULL() or COALESCE() are needed to return 0 instead of null for their total distance. The two functions are a little bit different, but for this question, they can be used interchangeably.

-- IFNULL(): takes two arguments and returns the first one if it's not NULL or the second if the first one is NULL.

-- COALESCE(): takes two or more parameters and returns the first non-NULL parameter, or NULL if all parameters are NULL.

-- Since users might have the same name and id is the primary key for this table (which means the values in this column will be unique). We need to use id for GROUP BY to get the aggregated distance for each user.

-- Don't forget to check the order required for the final output! This question requires two different types of order.

-- Approach: LEFT JOIN
-- Algorithm
-- Select the columns needed for the final output: name of the user, and the total distance; for users who do not have any rides, use IFNULL() or COALESCE() to return 0 for their distance
-- JOIN the two tables by user id
-- GROUP the result by id so each user has only one aggregated total distance. It's important to use id instead of name so the users with the same names will not be merged
-- ORDER the result by the 2nd column in descending order and the 1st column in ascending order per requested
-- Implementation
-- MySQL
SELECT 
    u.name, 
    IFNULL(SUM(distance),0) AS travelled_distance
FROM 
    my_new_database.TravelUsers u
LEFT JOIN 
    my_new_database.Rides r
ON 
    u.id = r.user_id
GROUP BY 
    u.id
ORDER BY 2 DESC, 1 ASC