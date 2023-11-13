{% macro full(src,h_key,key,values) %}
with stg as (
    select *
    ,lead(load_data) over (partition by {{h_key}} order by load_data) as last_mod
    from {{ ref(src) }}
)
,fechas as (
    select
    {{h_key}}
    ,has_diff
    ,min(load_data) as load_record
    ,max(last_mod) as last_modified
    from stg 
    group by {{h_key}},has_diff
)
,ultimo_registros as (
    select 
    {{h_key}}
    ,has_diff
    ,load_record
    ,null as last_modified
    from fechas
    qualify row_number() over (partition by {{h_key}} order by load_record desc)=1
)
,historico as (
   select 
    f.{{h_key}}
    ,f.has_diff
    ,f.load_record
    ,f.last_modified
   from fechas f left join ultimo_registros u on f.{{h_key}}=u.{{h_key}} and f.has_diff=u.has_diff
    where u.{{h_key}} is null and u.has_diff is null
)
,union_all_data as (
    select * 
    from ultimo_registros 
    union all 
    select * 
   from historico 
)
,final as (
    select 
    u.{{h_key}}
    {% for k in key%}
    ,s.{{k}}
    {%endfor%}
    ,u.has_diff
    ,u.load_record
    ,u.last_modified
    ,case when last_modified is null then 1 else 0 end as is_active
    {%for v in values %}
    ,s.{{v}}
    {%endfor%}
from union_all_data u join stg s on u.{{h_key}}=s.{{h_key}} and u.has_diff=s.has_diff and u.load_record=s.load_data
)select * from final
{%endmacro%}