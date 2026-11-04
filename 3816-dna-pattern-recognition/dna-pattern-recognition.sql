# Write your MySQL query statement below
select
    *,
    dna_sequence like 'ATG%' as has_start,
    dna_sequence regexp '.+(TAA|TAG|TGA)$' as has_stop,
    dna_sequence like '%ATAT%' as has_atat,
    dna_sequence like '%GGG%' as has_ggg
from samples
order by sample_id asc
;