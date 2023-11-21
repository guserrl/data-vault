with part as (
    select 
    partkey
    ,name as part_name
    ,mfgr
    ,brand
    ,type
    ,size
    ,container
    ,retailprice
    ,comment as spart_comment
    from {{ref('stg_part')}}
)
, supp as (
    select 
    suppkey
    ,name as supp_name
    ,address
    ,phone
    ,acctbal
    ,comment as supp_comment
    from {{ref('stg_supplier')}}
)
, partsupp as (
    select 
    partkey
    ,suppkey
    ,supplycost
    from {{ref('stg_partsupp')}}
)
,final as (
    select
    p.partkey||'-'||s.suppkey as part_supp_key 
    ,p.partkey
    ,p.part_name
    ,p.mfgr
    ,p.brand
    ,p.type
    ,p.size
    ,p.container
    ,p.retailprice
    ,s.suppkey
    ,s.supp_name
    ,s.address
    ,s.phone
    ,s.acctbal
    ,s.supp_comment
    --,ps.supplycost
    from (part p join partsupp ps on p.partkey=ps.partkey) join supp s on s.suppkey=ps.suppkey
)select * from final