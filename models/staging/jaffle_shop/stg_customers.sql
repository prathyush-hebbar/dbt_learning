with customers as(
        select id as customer_id,
        first_name,
        last_name
    from
        {{ source('jaffle_shopy','customers')}}
)
select * from customers