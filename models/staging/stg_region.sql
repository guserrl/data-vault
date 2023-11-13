
with region as (
select
md5(r_regionkey) as h_region_haskey 
, md5(r_name||r_comment) as has_diff
,{{ dbt_date.now() }} as load_data
--,TIMEADD( day, 2 , load_record ) as last_modified
,'snowflake' as source
,r_regionkey as regionkey 
,r_name as name
,r_comment as comment
from {{ source('tabla', 'region') }}
)select * from region