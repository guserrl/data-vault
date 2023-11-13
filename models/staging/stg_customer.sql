
with 
customer as(
    select 
    md5(c_custkey) as h_customer_haskey
    , md5(c_name||c_address||c_phone||c_acctbal||c_mktsegment||c_comment) as has_diff
    ,{{ dbt_date.now() }} as load_data
    ,'snowflake' as source
    ,c_custkey as custkey
    ,c_name as name
    ,c_address as address
    ,c_phone as phone
    ,c_acctbal as acctbal
    ,c_mktsegment as mktsegment
    ,c_comment as comment
    ,c_nationkey as nationkey
    from {{ source('tabla', 'customer') }}
)select * from customer