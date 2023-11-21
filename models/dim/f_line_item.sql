with cust_ord as (
    select 
    o.custkey
    ,o.orderkey
    from  {{ref('stg_orders')}} o join {{ref('stg_customer')}} c on c.custkey=o.custkey
)
,part_supp as (
    select
    partkey||'-'||suppkey as part_supp_key 
    ,partkey
    ,suppkey
    ,supplycost
    from {{ref('stg_partsupp')}}
)
,line_item as (
    select
    co.custkey
    ,co.orderkey
    ,ps.part_supp_key
    ,ps.supplycost
    ,li.tax
    ,li.discount
    ,li.extendedprice
    ,li.quantity
    ,li.receiptdate
    ,li.shipdate
    ,li.shipinstruct
    ,li.shipmode
    ,li.returnflag
    ,li.linenumber
    ,li.commitdate
    ,li.linestatus
    ,li.comment
    from cust_ord co join {{ref('stg_line_item')}} li on co.orderkey=li.orderkey 
    join part_supp ps on li.partkey=ps.partkey and li.suppkey=ps.suppkey
)select * from line_item