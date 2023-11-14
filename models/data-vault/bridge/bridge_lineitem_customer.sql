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
    ,custkey
    from {{ ref('l_customer_order') }}
)
,bridge as (
    select
    md5(l_c_o.l_customer_order_haskey||l_li.l_line_item_haskey) as b_customer_nation_region_haskey
    ,l_c_o.h_customer_haskey as h_customer_haskey
    ,l_li.h_order_haskey as h_order_haskey
    ,l_li.h_part_haskey as h_part_haskey
    ,l_li.h_supplier_haskey as h_supplier_haskey
    ,l_c_o.l_customer_order_haskey as l_customer_order_haskey
    ,l_li.l_line_item_haskey as l_line_item_haskey
    ,l_c_o.custkey as custkey
    ,l_li.orderkey as orderkey
    ,l_li.partkey as partkey
    ,l_li.suppkey as suppkey
    ,{{ dbt_date.now() }} as load_record
    ,'snowflake' as source
    from l_c_o,l_li
)select * from bridge