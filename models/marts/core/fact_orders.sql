{{
    config(
        materialized = 'table',
        transient=false
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),
payments as(
    select * from {{ ref('stg_payments') }}
),
payment_orders as (
    select 
        order_id,
        sum(case when status='success' then amount end) as amount
    from
        payments
    group by 1
    order by 1
),
fact_orders as(
    select 
        o.order_id ,
        o.customer_id,
        o.order_date,
        po.amount
    from
        orders o
    left join
        payment_orders po
    on po.order_id = o.order_id  -- Similarly, you can use this syntax "using(order_id)" inplace of "po.order_id = o.order_id".
    order by 1
)
select * from fact_orders


