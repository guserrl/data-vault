{% snapshot customer_snapshot %}  
{{
  config(      
    target_schema='snapshots',      
    strategy='timestamp',      
    unique_key='custkey',      
    updated_at='load_record'    
  )  
}} 

select *
from {{ref('dim_customer')}}

{% endsnapshot %}