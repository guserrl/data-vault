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
    ,h_nation_haskey
    ,nationkey
    ,h_region_haskey
    ,regionkey
    from {{ ref('l_nation_region') }}
)
,bridge as (
    select
    md5(lcn.l_customer_nation_haskey||lnr.l_nation_region_haskey) as b_customer_nation_region_haskey
    ,lcn.h_customer_haskey as h_customer_haskey
    ,lcn.h_nation_haskey as h_nation_haskey
    ,lnr.h_region_haskey as h_region_haskey
    ,lcn.l_customer_nation_haskey as l_customer_nation_haskey
    ,lnr.l_nation_region_haskey as l_nation_region_haskey
    ,lcn.custkey as custkey
    ,lcn.nationkey as nationkey
    ,lnr.regionkey as regionkey
    ,{{ dbt_date.now() }} as load_record
    ,'snowflake' as source
from l_c_n lcn join l_n_r lnr on lcn.h_nation_haskey=lnr.h_nation_haskey 
)select * from bridge