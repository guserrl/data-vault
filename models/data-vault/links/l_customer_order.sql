with stg as (
    select 
    distinct(h_order_haskey)
    ,custkey
    ,orderkey
    ,md5(custkey) as h_customer_haskey
    ,source
    ,current_timestamp as load_record
    from {{ ref('stg_orders') }} 
),final as (
    select 
    md5(custkey||orderkey) as l_customer_order_haskey
    ,h_order_haskey
    ,h_customer_haskey
    ,custkey
    ,orderkey
    ,source
    ,load_record
    from stg
)select * from final
