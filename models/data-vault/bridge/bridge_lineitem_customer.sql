with l_li as (
    select 
    l_line_item_haskey
    ,h_order_haskey
    ,h_part_haskey
    ,h_supplier_haskey
    ,orderkey
    ,partkey
    ,suppkey
    from {{ ref('l_line_item') }}
)
, l_c_o as (
    select 
    l_customer_order_haskey
    ,h_customer_haskey
    ,h_order_haskey
    ,custkey
    ,orderkey
    from {{ ref('l_customer_order') }}
)
,bridge as (
    select
    md5(lco.l_customer_order_haskey||lli.l_line_item_haskey) as b_customer_nation_region_haskey
    ,lco.h_customer_haskey as h_customer_haskey
    ,lli.h_order_haskey as h_order_haskey
    ,lli.h_part_haskey as h_part_haskey
    ,lli.h_supplier_haskey as h_supplier_haskey
    ,lco.l_customer_order_haskey as l_customer_order_haskey
    ,lli.l_line_item_haskey as l_line_item_haskey
    ,lco.custkey as custkey
    ,lli.orderkey as orderkey
    ,lli.partkey as partkey
    ,lli.suppkey as suppkey
    ,{{ dbt_date.now() }} as load_record
    ,'snowflake' as source
    from l_c_o lco join l_li lli on lco.h_order_haskey=lli.h_order_haskey
)select * from bridge