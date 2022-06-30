-- Question 24
-- Table my_numbers contains many numbers in column num including duplicated ones.
-- Can you write a SQL query to find the biggest number, which only appears once.
-- +---+
-- |num|
-- +---+
-- | 8 |
-- | 8 |
-- | 3 |
-- | 3 |
-- | 1 |
-- | 4 |
-- | 5 |
-- | 6 | 
-- For the sample data above, your query should return the following result:
-- +---+
-- |num|
-- +---+
-- | 6 |
-- Note:
-- If there is no such number, just output null.
-- Solution
with counted as
(
	select
		num,
		count(1) over(partition by num) as cnt
	from
		my_numbers
)
select 
	num
from
	counted
where 
	cnt = 1
order by 
	num desc
limit 1;