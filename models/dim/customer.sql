with customer as (
    select 
    custkey
    ,name as cust_name
    ,address
    ,phone
    ,acctbal
    ,mktsegment
    ,comment as cust_comment
    ,nationkey
    from {{ref('stg_customer')}}
)
,nation as (
    select 
    nationkey
    ,name as nat_name
    ,comment as nat_comment
    ,regionkey
    from {{ref('stg_nation')}}
)
,region as (
    select
    regionkey 
    ,name as reg_name
    ,comment as reg_comment
    from {{ref('stg_region')}}
)
,final as (
    select
    c.custkey
    ,c.cust_name
    ,c.address
    ,c.phone
    ,c.acctbal
    ,c.mktsegment
    ,c.cust_comment
    ,n.nationkey
    ,n.nat_name
    ,n.nat_comment
    ,r.regionkey 
    ,r.reg_name
    ,r.reg_comment
    from (customer c join nation n on c.nationkey=n.nationkey) join region r on n.regionkey=r.regionkey
)select * from final