with order as (
    select 
    orderkey
    ,orderstatus
    ,totalprice
    ,orderdate
    ,orderpriority
    ,clerk
    ,shippriority
    ,comment
    from {{ref('stg_orders')}}
)select * from order