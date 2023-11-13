
with part as (
select 
md5(p_partkey) as h_part_haskey
, md5(p_name||p_mfgr||p_brand||p_type||p_size||p_container||p_retailprice||p_comment) as has_diff
,{{ dbt_date.now() }} as load_data
--,TIMEADD( day, 2 , load_record ) as last_modified
,'snowflake' as source
,p_partkey as partkey
,p_name as name
,p_mfgr as mfgr
,p_brand as brand
,p_type as type
,p_size as size
,p_container as container
,p_retailprice as retailprice
,p_comment as comment
from {{ source('tabla', 'part') }}
)select * from part