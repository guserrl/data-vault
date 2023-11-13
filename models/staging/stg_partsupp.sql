
with partsupp as (
    select 
    md5(ps_partkey||ps_suppkey) as l_part_supp_haskey
    ,md5(ps_partkey) as h_part_haskey
    ,md5(ps_suppkey) as h_supplier_haskey
    ,ps_partkey as partkey
    ,ps_suppkey as suppkey
    ,md5(ps_availqty||ps_comment||ps_supplycost) as has_diff
    ,{{ dbt_date.now() }} as load_data
    ,'snowflake' as source
    ,ps_availqty as availqty
    ,ps_comment as comment
    ,ps_supplycost as supplycost
    from {{ source('tabla', 'partsupp') }}
)select * from partsupp
