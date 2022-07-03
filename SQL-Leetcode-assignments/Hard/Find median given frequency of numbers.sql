-- Question 107
-- The Numbers table keeps the value of number and its frequency.
-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.
-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.
-- Solution
with cnt as 
(
select 
	Number,
	Frequency,
	sum(Frequency) over(order by Number) as cum_sum,
	(sum(frequency) over()) / 2 as total_half_sum,
	(sum(frequency) over()) % 2.0 as remains
from Employee
),
prep as (
	select 
		number,
		coalesce(lag(cum_sum) over(order by number), 0) + 1  as bin_start,
		cum_sum as bin_end,
		case 
			when remains = 1 then total_half_sum + 1
			else total_half_sum 
		end lower_bound,
		total_half_sum + 1 as upper_bound
	from cnt
)
select 
	round(avg(number), 5) as median
from prep o
where exists (
		select 1 
		from prep i 
		where 
			o.number = i.number and
			(
				o.lower_bound between i.bin_start and i.bin_end
				or 
				o.upper_bound between i.bin_start and i.bin_end
			)
	)