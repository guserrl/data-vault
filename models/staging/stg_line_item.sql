
with lineitem as (
    select 
    md5(l_orderkey||l_partkey||l_suppkey) as l_line_item_haskey
    ,md5(l_tax||l_discount||l_extendedprice||l_quantity||l_receiptdate) as has_diff_receipt
    ,md5(l_shipdate||l_shipinstruct||l_shipmode||l_returnflag) as has_diff_ship
    ,md5(l_linenumber||l_commitdate||l_linestatus||l_comment) as has_diff_status
    ,md5(l_orderkey) as h_order_haskey
    ,md5(l_partkey) as h_part_haskey
    ,md5(l_suppkey) as h_supplier_haskey
    ,l_orderkey as orderkey
    ,l_partkey as partkey
    ,l_suppkey as suppkey
    ,{{ dbt_date.now() }} as load_data
    ,'snowflake' as source
    ,l_tax as tax
    ,l_discount as discount
    ,l_extendedprice as extendedprice
    ,l_quantity as quantity
    ,l_receiptdate as receiptdate
    ,l_shipdate as shipdate
    ,l_shipinstruct as shipinstruct
    ,l_shipmode as shipmode
    ,l_returnflag as returnflag
    ,l_linenumber as linenumber
    ,l_commitdate as commitdate
    ,l_linestatus as linestatus
    ,l_comment as comment
    from {{ source('tabla', 'lineitem') }}
)
select *
from lineitem 