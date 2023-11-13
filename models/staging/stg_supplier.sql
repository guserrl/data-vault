
with supplier as (
select 
md5(s_suppkey) as h_supplier_haskey
,md5(s_name||s_address||s_phone||s_acctbal||s_comment) as has_diff
,{{ dbt_date.now() }} as load_data
,'snowflake' as source
,s_suppkey as suppkey
,s_name as name
,s_address as address
,s_phone as phone
,s_acctbal as acctbal
,s_comment as comment
,s_nationkey as nationkey
from {{ source('tabla', 'supplier') }}   
)select * from supplier