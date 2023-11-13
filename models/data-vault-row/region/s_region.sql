
-- depends_on: {{ ref('stg_region') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_region','h_region_haskey',['regionkey'],['source','name','comment'])}}

{% else %}

{{s_incremental('stg_region',this,'h_region_haskey',['regionkey'],['source','name','comment']) }}

{% endif %}