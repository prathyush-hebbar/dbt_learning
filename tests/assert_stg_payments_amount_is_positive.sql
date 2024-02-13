with payments as (
    select * from {{ ref("stg_payments") }}
)

select 
    order_id,
    sum(amount) as total
from 
    payments 
group by 1
having total < 0

-- Remember, always do reverse/negative testing which means that if you want to test a model then no results must be returned.
-- Just fix the thumb rule that "results must empty".