
-- depends_on: {{ ref('stg_part') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_part','h_part_haskey',['partkey'],['source','name','mfgr','brand','type','size','container','retailprice','comment'])}}
 
{% else %}

{{s_incremental('stg_part',this,'h_part_haskey',['partkey'],['source','name','mfgr','brand','type','size','container','retailprice','comment']) }}

{% endif %}