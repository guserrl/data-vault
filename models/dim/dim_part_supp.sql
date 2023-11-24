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
    from {{ref('s_part')}}
)
, supp as (
    select 
    suppkey
    ,name as supp_name
    ,address
    ,phone
    ,acctbal
    ,comment as supp_comment
    from {{ref('s_supplier')}}
)
, partsupp as (
    select 
    l.partkey
    ,l.suppkey
    ,s.supplycost
    ,s.has_diff
    from {{ref('l_part_supp')}} l join {{ref('s_part_supp')}} s on l.partkey=s.partkey and l.suppkey=s.suppkey
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
    ,ps.supplycost
    ,ps.has_diff
    from (part p join partsupp ps on p.partkey=ps.partkey) join supp s on s.suppkey=ps.suppkey
)select * from final

