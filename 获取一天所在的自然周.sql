--（但是这样比较费时间，如果有时间维表，直接用时间维表的话更方便，但是用时间维表的时候，
-- 要清楚每一个字段的含义和用法，这样在使用的时候，可以直接避免冗余的操作）

select 
	concat(
		date_add(
			statis_day,
			-pmod(
				datediff(    --ds 是星期几
					statis_day,
					'20100104'
				), 
				7
	    	)
		), 
	    '~'
		,date_add(
			statis_day,
            6-pmod(
			    datediff(    --de 是星期几
			        statis_day,
			        '20100104'
		        ), 
		        7
		    )
        )
	) as time_stage,
from 
	t_union_cnt t