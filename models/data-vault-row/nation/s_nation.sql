-- depends_on: {{ ref('stg_nation') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_nation','h_nation_haskey',['nationkey'],['source','name','comment','regionkey'])}}

{% else %}

{{s_incremental('stg_nation',this,'h_nation_haskey',['nationkey'],['source','name','comment','regionkey']) }}

{% endif %}