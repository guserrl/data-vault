
with region as (
select *
from {{ ref('stg_region') }}
)select * from region