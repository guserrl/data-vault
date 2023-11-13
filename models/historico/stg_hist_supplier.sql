
with supplier as (
select *
from {{ ref('stg_supplier') }}  
)select * from supplier