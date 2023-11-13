
with nation as (
select 
md5(n_nationkey) as h_nation_haskey
, md5(n_name||n_comment) as has_diff
,{{ dbt_date.now() }} as load_data
,'snowflake' as source
,n_nationkey as nationkey
,n_name as name
,n_comment as comment
,n_regionkey as regionkey
from {{ source('tabla', 'nation') }}
)select * from nation