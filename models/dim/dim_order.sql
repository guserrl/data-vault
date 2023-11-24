with ord as (
    select 
    orderkey
    ,orderstatus
    ,totalprice
    ,orderdate
    ,orderpriority
    ,clerk
    ,shippriority
    ,comment
    ,load_record
    ,last_modified
    from {{ref('s_orders')}}
    --where is_active=1 --activar si quieres que tier la snapshot
)select * from ord
-- ,sct3 as (
--     select 
--     orderkey
--     ,orderstatus
--     ,totalprice
--     ,orderdate
--     ,orderpriority
--     ,clerk
--     ,shippriority
--     ,comment
--     ,load_record
--     ,case 
--         when max(last_modified) over (partition by orderkey) = last_modified then null
--         else  FIRST_VALUE(has_diff) OVER (PARTITION BY orderkey ORDER BY last_modified desc)
--     end as cambio
--     from ord
-- )select * from sct3 --stg where custkey=2222222222 order by last_modified asc /*load_data asc;*/;
