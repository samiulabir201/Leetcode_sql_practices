-- -- Create Person table
-- CREATE TABLE my_new_database.newPerson (
--     personId INT PRIMARY KEY,
--     lastName VARCHAR(255),
--     firstName VARCHAR(255)
-- );

-- -- Insert values into Person table
-- INSERT INTO my_new_database.newPerson (personId, lastName, firstName) VALUES
-- (1, 'Wang', 'Allen'),
-- (2, 'Alice', 'Bob');

-- -- Create Address table
-- CREATE TABLE my_new_database.Address (
--     addressId INT PRIMARY KEY,
--     personId INT,
--     city VARCHAR(255),
--     state VARCHAR(255)
-- );

-- -- Insert values into Address table
-- INSERT INTO my_new_database.Address (addressId, personId, city, state) VALUES
-- (1, 2, 'New York City', 'New York'),
-- (2, 3, 'Leetcode', 'California');

-- Pandas
-- Approach 1: Using merge
-- Visualization of approach 1


-- Intuition
-- Let's breakdown the steps given the following input DataFrames:

-- person:

-- personId	lastName	firstName
-- 1	Wang	Allen
-- 2	Alice	Bob

-- address:

-- addressId	personId	city	state
-- 1	2	New York City	New York
-- 2	3	Leetcode	California

-- Merging the DataFrames

-- result = pd.merge(person, address, on='personId', how='left')
-- In this step, we are merging the person and address dataframes using a left join operation with the pd.merge() function. Here:

-- on='personId' specifies that we are using the 'personId' column as the key for merging the data. This column is present in both dataframes, and it holds unique identifiers for the individuals.
-- how='left' specifies that we are performing a left join, meaning all the records from the person dataframe (the left dataframe) will be retained, and the matching records from the address dataframe (the right dataframe) will be merged where the 'personId' values match. If a 'personId' from the person dataframe does not have a matching 'personId' in the address dataframe, the 'city' and 'state' columns for that record will contain NaN values (representing missing data).
-- personId	lastName	firstName	addressId	city	state
-- 1	Wang	Allen	NaN	NaN	NaN
-- 2	Alice	Bob	1.0	New York City	New York

-- Selecting Relevant Columns

-- result = result[['firstName', 'lastName', 'city', 'state']]
-- In this step, we select only the columns that we are interested in for the final output. Since the merging operation can potentially bring in other columns from the address dataframe, we are explicitly selecting only the 'firstName', 'lastName', 'city', and 'state' columns to be in our final result. This helps in maintaining a clean and focused dataset which contains only the information we are interested in.

-- firstName	lastName	city	state
-- Allen	Wang	NaN	NaN
-- Bob	Alice	New York City	New York

-- In summary, this script is taking two separate dataframes and merging them into a single dataframe where each row represents a person and contains their first name, last name, city, and state. This is done using the person's unique identifier to correctly match each person with their address. It's a common operation when you want to bring together information from different sources into a unified view.

-- Implementation

-- Database
-- Approach 1: Using outer join
-- Intuition
-- Since the PersonId in table Address is the foreign key of table Person, we can join these two tables to get the address information of a person.

-- Considering there might be no address information for every person, we should use outer join instead of the default inner join.

-- Implementation
-- Note: For MySQL, an outer join is performed either using left join or right join.

select FirstName, LastName, City, State
from my_new_database.newperson left join my_new_database.Address
on newPerson.PersonId = Address.PersonId;

-- Note: Using the where clause to filter the records will fail if there is no address information for a person because it will not display the name information.