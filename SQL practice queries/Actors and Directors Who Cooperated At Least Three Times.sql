-- CREATE TABLE my_new_database.actordirector(
--     actor_id INT,
--     director_id INT,
--     timestamp INT PRIMARY key
-- );

-- INSERT INTO my_new_database.actordirector(actor_id, director_id, timestamp)
-- VALUES
--     (1,1,0),
--     (1,1,1),
--     (1,1,2),
--     (1,2,3),
--     (1,2,4),
--     (2,1,5),
--     (2,1,6);

-- Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.

-- pandas
-- Approach: Group By and Count
-- Intuition
-- In pandas, we can use the .groupby function on the 'actor_id' and 'director_id' columns and then count the number of instances per group using the .size() function. We then filter out the groups that have a count of at least 3.

-- Algorithm
-- To solidify the intuition behind the algorithm, let's first look at an example:

-- The original table actor_director:

-- actor_id	director_id	timestamp
-- 1	1	0
-- 1	1	1
-- 1	1	2
-- 1	2	3
-- 1	2	4
-- 2	1	5
-- 2	1	6

-- The following table is obtained by grouping actor_id and director_id, and then filtered to include only those groups with a count of at least 3.

-- actor_id	director_id
-- 1	1

-- Note that the returned DataFrame contains only the actor_id and director_id columns.

-- Implementation

-- import pandas as pd

-- def actors_and_directors(actor_director: pd.DataFrame) -> pd.DataFrame:
--     cnts = actor_director.groupby(['actor_id', 'director_id']).size().reset_index(name='counts')
--     return cnts[cnts['counts'] >= 3][['actor_id', 'director_id']]

-- database
-- Approach: Group By and Count
-- Intuition
-- In SQL, the query to find the actor-director pairs that have cooperated at least three times involves grouping by the actor_id and director_id and then filtering out the pairs that have a count of at least 3.

-- Algorithm
-- To solidify the intuition behind the algorithm, let's first look at an example:

-- The original table ActorDirector:

-- actor_id	director_id	timestamp
-- 1	1	0
-- 1	1	1
-- 1	1	2
-- 1	2	3
-- 1	2	4
-- 2	1	5
-- 2	1	6

-- The following table is obtained by grouping actor_id and director_id, and then filtered to include only those groups with a count of at least 3.

-- actor_id	director_id
-- 1	1

-- Note that we only select the actor_id and director_id columns.

-- Implementation
SELECT actor_id, director_id
FROM my_new_database.ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3;