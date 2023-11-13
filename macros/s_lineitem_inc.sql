{% macro s_incrementalv3(src_stg,src_sat,h_key,key,values,diff)%}
with stg as (
    select 
    {{h_key}}
    {% for k in key %}
    ,{{k}}
    {%endfor%}
    ,{{diff}} as has_diff
    ,load_data as load_record
    ,null as last_modified
    {% for v in values %}
    ,{{v}}
    {%endfor%}
    from {{ ref(src_stg) }}
    where load_record>=DATE_TRUNC('day', current_timestamp())
)
,satelite as (
    select 
    {{h_key}}
    {% for k in key %}
    ,{{k}}
    {%endfor%}
    ,has_diff
    ,load_record
    ,last_modified
    {% for v in values %}
    ,{{v}}
    {%endfor%}
    from {{src_sat}} where is_active=1
)
,cruze as(
    select 
    stg.{{h_key}}
    {% for k in key %}
    ,stg.{{k}}
    {%endfor%}
    ,stg.has_diff
    ,stg.load_record
    ,stg.last_modified
    {% for v in values %}
    ,stg.{{v}}
    {%endfor%}
    ,sat.{{h_key}} as {{h_key}}2
    {% for k in key %}
    ,sat.{{k}} as {{k}}2
    {%endfor%}
    ,sat.has_diff as has_diff2
    ,sat.load_record as load_record2
    ,sat.last_modified as last_modified2
    {% for v in values %}
    ,sat.{{v}} as {{v}}2
    {%endfor%}
    from stg stg left join satelite sat on stg.{{h_key}}=sat.{{h_key}}
    qualify row_number() over (partition by stg.{{h_key}} order by stg.load_record desc)=1
 )
 ,consolidado_bajas as (
    select
    {{h_key}}
    {% for k in key %}
    ,{{k}}
    {%endfor%}
    ,has_diff
    ,load_record
    ,last_modified
    ,1 as is_active
    {% for v in values %}
    ,{{v}}
    {%endfor%}
    from cruze
    where {{h_key}}2 is not null and has_diff<>has_diff2
    union all
    select 
    {{h_key}}2
    {% for k in key %}
    ,{{k}}2
    {%endfor%}
    ,has_diff2
    ,load_record2
    ,load_record as last_modified
    ,0 as is_active
    {% for v in values %}
    ,{{v}}2
    {%endfor%}
    from cruze
    where {{h_key}}2 is not null and has_diff<>has_diff2
 )
 ,mismo_registro as ( --No cambia un registro ya existente
    select 
    {{h_key}}2
    {% for k in key %}
    ,{{k}}2
    {%endfor%}
    ,has_diff2
    ,load_record2
    ,last_modified2
    ,1 as is_active
    {% for v in values %}
    ,{{v}}2
    {%endfor%}
    from cruze
    where {{h_key}}2 is not null and has_diff=has_diff2
 )
 ,no_existia as ( --Nuevo registro
    select 
    {{h_key}}
    {% for k in key %}
    ,{{k}}
    {%endfor%}
    ,has_diff
    ,load_record
    ,last_modified
    ,1 as is_active
    {% for v in values %}
    ,{{v}}
    {%endfor%}
    from cruze
    where {{h_key}}2 is null
 )
,unio as(
    select *
    from consolidado_bajas
    union all
    select *
    from mismo_registro
    union all
    select *
    from no_existia
)select * from unio
{% endmacro %}