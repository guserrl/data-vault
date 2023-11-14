with l_c_n as (
    select 
    l_customer_nation_haskey
    ,h_customer_haskey
    ,h_nation_haskey
    ,custkey
    ,nationkey
    from {{ ref('l_customer_nation') }}
)
, l_n_r as (
    select 
    l_nation_region_haskey
    ,h_region_haskey
    ,regionkey
    from {{ ref('l_nation_region') }}
)
,bridge as (
    select
    md5(l_c_n.l_customer_nation_haskey||l_n_r.l_nation_region_haskey) as b_customer_nation_region_haskey
    ,l_c_n.h_customer_haskey as h_customer_haskey
    ,l_c_n.h_nation_haskey as h_nation_haskey
    ,l_n_r.h_region_haskey as h_region_haskey
    ,l_c_n.l_customer_nation_haskey as l_customer_nation_haskey
    ,l_n_r.l_nation_region_haskey as l_nation_region_haskey
    ,l_c_n.custkey as custkey
    ,l_c_n.nationkey as nationkey
    ,l_n_r.regionkey as regionkey
    ,{{ dbt_date.now() }} as load_record
    ,'snowflake' as source
from l_c_n,l_n_r
)select * from bridge