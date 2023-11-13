
with 
customer as(
    select 
    *
    from {{ ref('stg_customer') }}
)select * from customer