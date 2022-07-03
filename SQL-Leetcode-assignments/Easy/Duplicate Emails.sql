-- Question 11
-- Write a SQL query to find all duplicate emails in a table named Person.
-- +----+---------+
-- | Id | Email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- For example, your query should return the following for the above table:
-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |
-- +---------+
-- Solution
select distinct Email 
from Person o
where exists (select 1 from Person i where i.id != o.id and o.Email = i.Email