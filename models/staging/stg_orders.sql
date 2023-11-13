
with orders as (
select 
md5(o_orderkey) as h_order_haskey
,md5(o_orderstatus||o_totalprice||o_orderdate||o_orderpriority||o_clerk||o_shippriority||o_comment) as has_diff
,{{ dbt_date.now() }} as load_data
,'snowflake' as source
,o_orderkey as orderkey
,o_orderstatus as orderstatus
,o_totalprice as totalprice
,o_orderdate as orderdate
,o_orderpriority as orderpriority
,o_clerk as clerk
,o_shippriority as shippriority
,o_comment as comment
,o_custkey as custkey
from {{ source('tabla', 'orders') }} 
)select * from orders