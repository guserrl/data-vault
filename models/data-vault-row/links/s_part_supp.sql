
 -- depends_on: {{ ref('stg_partsupp') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_partsupp','l_part_supp_haskey',['partkey','suppkey'],['source','availqty','supplycost','comment'])}}

-------------- 
{% else %}

{{s_incrementalv2('stg_hist_partsupp',this,'l_part_supp_haskey',['partkey','suppkey'],['source','availqty','supplycost','comment']) }}

{% endif %}
