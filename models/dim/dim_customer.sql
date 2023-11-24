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
    ,load_record
    --,has_diff
    from {{ref('s_customer')}}
    where is_active = 1 --activar para las snapshots
)
,nation as (
    select 
    nationkey
    ,name as nat_name
    ,comment as nat_comment
    ,regionkey
    from {{ref('s_nation')}}
    --where is_active = 1 --activar para las snapshot
)
,region as (
    select
    regionkey 
    ,name as reg_name
    ,comment as reg_comment
    from {{ref('s_region')}}
    --where is_active = 1 --activar para las snapshot
)
,bridge as (
    select
    custkey
    ,nationkey
    ,regionkey
    from {{ref('bridge_customer_nation_region')}}
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
    ,c.load_record
    --,c.has_diff
    from bridge b join customer c on b.custkey=c.custkey
    join nation n on b.nationkey=n.nationkey
    join region r on b.regionkey=r.regionkey
)select * from final
-- , dct3 as (
--     select * 
--     ,case 
--         when max(load_record) over (partition by custkey) = load_record then null
--         else  FIRST_VALUE(has_diff) OVER (PARTITION BY custkey ORDER BY load_record desc)
--     end as cambio
--     from final
-- )select * from dct3