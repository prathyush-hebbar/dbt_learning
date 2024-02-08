with payment as (
    select 
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount/100 as amount, -- amount is given in cents so convert it in dollars by divided 100. 
        created as created_id 
    from 
        {{ source('stripe','payment') }}
)
select * from payment