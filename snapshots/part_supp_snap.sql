{% snapshot partsupp_snapshot %} -- otra forma de hacer snapshots

{{    
  config(      
    target_schema='snapshots',      
    strategy='check',      
    unique_key='part_supp_key ',      
    check_cols=['has_diff']    
  )  
}} 

select *
from {{ref('dim_part_supp')}}


{% endsnapshot %}