# Write your MySQL query statement below
with recursive split as 
(
    -- Anchor member: Get the word before the first space and the remaining text that comes after
    select 
        content_id,
        content_text,
        1 as idx,
        if(
            -- If current word has a dash
            regexp_substr(content_text, '^[A-Z|a-z]+-[A-Z|a-z]*') != '',
                1,
            -- Else
                0
        ) as has_dash_after,
        if(
            -- If current word has a dash
            regexp_substr(content_text, '^[A-Z|a-z]+-[A-Z|a-z]*') != '',
                concat(
                    upper(left(content_text, 1)), -- First letter
                    lower(substr(substring_index(content_text, '-', 1), 2)) -- Rest of word
                ),
            -- Else
                concat(
                    upper(left(content_text, 1)), -- First letter
                    lower(substr(substring_index(content_text, ' ', 1), 2)) -- Rest of word
                ) 
        ) as curr_word,
        -- Get the rest of content_text after the space to pass it to the recursive member
        if(
            -- If current word has a dash
            regexp_substr(content_text, '^[A-Z|a-z]+-[A-Z|a-z]*') != '',
                substr(content_text, position('-' in content_text) + 1),
            -- Else
                substr(content_text, position(' ' in content_text) + 1)
        ) as remaining_text
    from user_content

    union all
  
    -- Recursive member: Break apart the remaining text
    select 
        content_id,
        content_text,
        idx + 1 as idx,
        if(
            -- If current word has a dash
            regexp_substr(remaining_text, '^[A-Z|a-z]+-[A-Z|a-z]*') != '',
                1,
            -- Else
                0
        ) as has_dash_after,
        case
            when regexp_substr(remaining_text, '^[A-Z|a-z]+-.*') != ''
                then 
                    if(
                        -- If there's a special character, extract until space or end of string
                        regexp_substr(remaining_text, '.*[\\|@|/|^|,]+.*') != '',
                            concat(
                                upper(left(remaining_text, 1)), -- First letter
                                lower(substr(remaining_text, 2)) -- Rest of word
                            ),
                        -- Else extract until dash
                            concat(
                                upper(left(remaining_text, 1)), -- First letter
                                lower(substr(substring_index(remaining_text, '-', 1), 2)) -- Rest of word
                            )
                    )
            -- If current word has a space
            when instr(substr(remaining_text, 1, position(' ' in remaining_text)), ' ') > 0
                then concat(
                    upper(left(remaining_text, 1)), -- First letter
                    lower(substr(substring_index(remaining_text, ' ', 1), 2)) -- Rest of word
                )
            -- If word doesn't have any more dashes/spaces
            when instr(remaining_text, '-') = 0 and instr(remaining_text, ' ') = 0
                then concat(
                    upper(left(remaining_text, 1)), -- First letter
                    lower(substr(remaining_text, 2)) -- Rest of word
                )
            -- If word doesn't start with letter, keep as is
            when regexp_substr(remaining_text, '^[A-Z|a-z]+.*') is null
                then remaining_text
        end as curr_word,
        -- Get the rest of the text for the next iteration
        case
            -- If current word has a dash (potentially at end of string)
            when regexp_substr(remaining_text, '^[A-Z|a-z]+-[A-Z|a-z]*') != '' --  * at end
                then 
                    if(
                        -- If there's a special character, extract until space or end
                        regexp_substr(remaining_text, '.*[\\|@|/|^|,]+.*') != '',
                            substr(regexp_substr(remaining_text, '-.* |$'), 2),
                        -- Else proceed as usual
                            substr(remaining_text, position('-' in remaining_text) + 1)
                    )
            -- If current word has a space
            when instr(substr(remaining_text, 1, position(' ' in remaining_text)), ' ') > 0
                then substr(remaining_text, position(' ' in remaining_text) + 1)
        end as remaining_text
    from split
    where remaining_text != ''
)
select
    content_id, 
    content_text as original_text,
    group_concat(
        concat(
            curr_word, 
            case
                when remaining_text = '' or remaining_text is null then ''
                when has_dash_after then '-'
                else ' '
            end
        )
        order by content_id asc, idx asc
        separator ''
    ) as converted_text
from split
group by content_id
;