
-- CREATE TABLE my_new_database.Views(
--     article_id int,
--     author_id int,
--     viewer_id int,
--     view_date date
-- );

-- INSERT INTO my_new_database.Views(article_id,author_id,viewer_id,view_date)
-- VALUES
--     (1, 3, 5, '2019-08-01'),
--     (1, 3, 6, '2019-08-02'),
--     (2, 7, 7, '2019-08-01'),
--     (2, 7, 6, '2019-08-02'),
--     (4, 7, 1, '2019-07-22'),
--     (3, 4, 4, '2019-07-21'),
--     (3, 4, 4, '2019-07-21');

-- Write a solution to find all the authors that viewed at least one of their own articles.

-- Return the result table sorted by id in ascending order.

-- pandas
-- Approach: Selecting rows based on conditions
-- Algorithm
-- We have the original DataFrame views shown below:

-- article_id	author_id	viewer_id	view_date
-- 1	3	5	2019-08-01
-- 1	3	6	2019-08-02
-- 2	7	7	2019-08-01
-- 2	7	6	2019-08-02
-- 4	7	1	2019-07-22
-- 3	4	4	2019-07-21
-- 3	4	4	2019-07-21
-- First, let's find the condition to determine whether an author reviews their own article, which is when author_id is equal to viewer_id. Therefore, the first step is to filter all rows of views based on this condition and identify the rows that satisfy it.

-- views['author_id'] = views['viewer_id']

-- In Pandas, boolean indexing allows us to filter the DataFrame by using boolean arrays or conditions. It means that we can use a Series of boolean values or create conditions that evaluate to True or False for each row in the DataFrame. By applying these boolean values or conditions as an index to the DataFrame, we can selectively extract the rows that satisfy the conditions.

-- In this scenario, we should select only the rows where the value of the author_id column is equal to the value of the viewer_id column, which can be represented as:

-- # Only the rows where views['author_id'] == views['viewer_id'] 
-- # result in True will be selected.
-- df = views[views['author_id'] == views['viewer_id']]
-- This filtering creates a new DataFrame df containing the rows that meet this criteria. We can see that the author_id of each row is equal to the viewer, and those rows that don't meet this criterion are filtered out.

-- article_id	author_id	viewer_id	view_date
-- 2	7	7	2019-08-01
-- 5	3	4	2019-07-21
-- 6	3	4	2019-07-21

-- After applying the custom condition to filter valid rows, it is possible to encounter duplicate authors in the author_id column (for example, the author with author_id = 4 has viewed his own articles multiple times) in the column author_id. To address this, we need to select the distinct author_ids by removing any duplicates, which can be achieved by applying the method drop_duplicates() to df. In this case, the parameters of the drop_duplicates() method are set as follows:

-- df.drop_duplicates(subset=['author_id'], inplace=False)
-- subset: it specifies the column(s) based on which the duplicates should be considered. If not specified, all columns in the DataFrame will be used to identify duplicates. In our case, we set it to ['author_id'] so only the duplicates in the column author_id are considered to be removed.
-- inplace: it is a boolean parameter that determines whether the method should modify the original DataFrame in place or return a new DataFrame with the duplicates dropped, we set it to True indicating an in-place modification.
-- Hence, this function modifies df by keeping only the unique rows based on the column author_id. Now that we have selected all the unique author_ids, the next step is to retrieve the answer that conforms to the specified format. We need to rename the column author_id to id and sort it in ascending order.

-- # Only preserve rows that contain unique 'author_id'.
-- df.drop_duplicates(subset=['author_id'], inplace=True)

-- # Sort the DataFrame in ascending order of 'author_id'.
-- df.sort_values(by=['author_id'], inplace=True)

-- # Rename the column 'author_id' to 'id'.
-- df.rename(columns={'author_id':'id'}, inplace=True)
-- The resulting DataFrame looks like this:

-- article_id	id	viewer_id	view_date
-- 3	4	4	2019-07-21
-- 2	7	7	2019-08-01

-- Lastly, we return the DataFrame by selecting only the desired column id. The complete code is shown below:

-- python:
-- import pandas as pd

-- def article_views(views: pd.DataFrame) -> pd.DataFrame:
--     df = views[views['author_id'] == views['viewer_id']]

--     df.drop_duplicates(subset=['author_id'], inplace=True)
--     df.sort_values(by=['author_id'], inplace=True)
--     df.rename(columns={'author_id':'id'}, inplace=True)

--     df = df[['id']]

--     return df

-- database
-- Approach: Selecting rows based on conditions
-- In SQL, we can use the keyword DISTINCT in the SELECT statement to retrieve unique elements from the table Views. We also apply a condition using the WHERE clause. This condition filters out only those rows where the author_id is equal to the viewer_id.

-- SELECT 
--     DISTINCT author_id 
-- FROM 
--     Views 
-- WHERE 
--     author_id = viewer_id 
-- We will rename the column author_id by giving it an alias of id.

-- SELECT 
--     DISTINCT author_id AS id 
-- FROM 
--     Views 
-- WHERE 
--     author_id = viewer_id  
-- Note that we should also sort the resulting table in ascending order based on the id column, which can be implemented using the keyword ORDER BY. The complete code is as follows:

-- Implementation
SELECT 
    DISTINCT author_id AS id 
FROM 
    my_new_database.views 
WHERE 
    author_id = viewer_id 
ORDER BY 
    id 