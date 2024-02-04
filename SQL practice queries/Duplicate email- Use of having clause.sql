-- CREATE TABLE my_new_database.person(
--     id int PRIMARY KEY,
--     email VARCHAR(100)
-- );

-- INSERT INTO my_new_database.person(id, email)
-- VALUES
--     (1,'a@b.com'),
--     (2,'c@d.com'),
--     (3,'a@b.com');

-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

-- Pandas
-- Approach 1: Frequency-based Filtering for Duplicates

-- Intuition
-- Step 1 - Group and Count:

-- email_counts = person.groupby('email').size().reset_index(name='num')

-- Using the groupby function of pandas, we cluster the rows of the DataFrame based on the values in the 'Email' column. This ensures that rows with identical email addresses are categorized into the same group. Subsequently, for each of these email groups, we count how many times that particular email appears. This process gives us a clear picture of the frequency of each unique email in our DataFrame.
-- Step 2 - Filter duplicates:

-- duplicated_emails_df = email_counts[email_counts['num'] > 1][['email']]

-- With the frequencies of each email address in hand, our objective becomes simple: identify those emails that appear more than once. Hence, we filter our counted DataFrame to retain only those rows where the email count (which we named 'num') exceeds 1. This effectively gives us a list of duplicated emails.

-- Python
-- import pandas as pd

-- def duplicate_emails(person: pd.DataFrame) -> pd.DataFrame:   
--   # Group by 'Email' and count occurrences
--   email_counts = person.groupby('email').size().reset_index(name='num')
  
--   # Filter for emails that occur more than once
--   duplicated_emails_df = email_counts[email_counts['num'] > 1][['email']]
  
--   return duplicated_emails_df

-- Approach 2: Group-Filter-Deduplicate
-- Intuition
-- Input DataFrame:

-- id	email
-- 1	a@b.com
-- 2	c@d.com
-- 3	a@b.com

-- Step 1 - Grouping by Email Addresses:

-- grouped_emails = person.groupby('email')
-- In many datasets, data can have repetitions. The first intuitive step to identifying which elements are repeated is to group or cluster them. In the context of our problem, emails are the elements in question. We use the groupby method on the 'email' column. This method aggregates data by unique email addresses. Think of it as putting the same emails into individual buckets.
-- id	email
-- 1	a@b.com
-- 3	a@b.com
-- 2	c@d.com

-- (For illustrative purposes, the groups are separated with an empty row in the table)

-- Step 2 - Identifying the Repeated Emails:

-- filtered_emails = grouped_emails.filter(lambda x: len(x) > 1)
-- Once the emails are grouped, the next step is to figure out which groups (or buckets) have more than one email, i.e. duplicates. The filter function in combination with the lambda function lambda x: len(x) > 1 helps in achieving this. The filter function will iterate over each group, and our lambda function will check the length (or count) of emails in each group. If the count is greater than one, the group satisfies our condition.
-- id	email
-- 1	a@b.com
-- 3	a@b.com

-- Step 3 - Extracting Unique Repeated Emails:

-- duplicated_emails_df = filtered_emails[['email']].drop_duplicates()
-- Given that our filtered emails might still contain repetitions, we need to further refine our dataset. The drop_duplicates() method combined with indexing by the 'email' column ensures that each repeated email appears only once in the resulting DataFrame.
-- id	email
-- 1	a@b.com

-- Step 4 - Return DataFrame:

-- return duplicated_emails_df
-- The final step is to return the DataFrame that contains the duplicated emails.
-- id	email
-- 1	a@b.com

-- These steps together encapsulate the process of identifying and extracting duplicated emails from the DataFrame.

-- Implementation
-- import pandas as pd

-- def duplicate_emails(person: pd.DataFrame) -> pd.DataFrame:
--   duplicated_emails_df = person.groupby('email').filter(lambda x: len(x) > 1)[['email']].drop_duplicates()
  
--   return duplicated_emails_df

-- Database
-- Approach 1: Using GROUP BY and Subquery
-- Intuition
-- Duplicated emails existed more than one time. To count the times each email exists, we can use the following code.

-- select Email, count(Email) as num
-- from Person
-- group by Email;
-- | Email   | num |
-- |---------|-----|
-- | a@b.com | 2   |
-- | c@d.com | 1   |
-- Taking this as a temporary table, we can get a solution as below.

-- select Email from
-- (
--   select Email, count(Email) as num
--   from Person
--   group by Email
-- ) as statistic
-- where num > 1
-- ;
-- Implementation
-- select Email from
-- (
--   select Email, count(Email) as num
--   from Person
--   group by Email
-- ) as statistic
-- where num > 1
-- ;
-- Approach 2: Using GROUP BY and HAVING condition
-- Intuition
-- A more common used way to add a condition to a GROUP BY is to use the HAVING clause, which is much simpler and more efficient.

-- So we can rewrite the above solution to this one.

-- Implementation
select Email
from my_new_database.Person
group by Email
having count(Email) > 1;