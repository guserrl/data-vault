with bridge as(
    select
    l_line_item_haskey
    ,custkey
    ,orderkey
    ,partkey
    ,suppkey
    from {{ref('bridge_lineitem_customer')}}
)
,lineitem as (
    select
    b.orderkey
    ,b.partkey||'-'||b.suppkey as part_supp_key
    ,b.custkey
    ,lir.tax
    ,lir.discount
    ,lir.extendedprice
    ,lir.quantity
    ,lir.receiptdate
    ,lis.shipdate
    ,lis.shipinstruct
    ,lis.shipmode
    ,lis.returnflag
    ,list.linenumber
    ,list.commitdate
    ,list.linestatus
    from bridge b 
    join {{ref('s_lineitem_receipt')}} lir on b.l_line_item_haskey=lir.l_line_item_haskey 
    join {{ref('s_lineitem_ship')}} lis on b.l_line_item_haskey=lis.l_line_item_haskey 
    join {{ref('s_lineitem_status')}} list on b.l_line_item_haskey=list.l_line_item_haskey
    --where lir.is_active=1 and lis.is_active=1 and list.is_active=1
)
,final as (
    select
    custkey
    ,orderkey
    ,part_supp_key
    ,tax
    ,discount
    ,extendedprice
    ,quantity
    ,receiptdate
    ,shipdate
    ,shipinstruct
    ,shipmode
    ,returnflag
    ,linenumber
    ,commitdate
    ,linestatus 
    from lineitem
)select * from final