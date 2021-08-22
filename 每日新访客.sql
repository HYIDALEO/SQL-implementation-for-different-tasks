insert into table etl_user_new_day partition(day="20170101")
select 
   a.uid,a.commit_time,a.city,a.release_channel,a.app_ver_name
from etl_user_active_day a
left join
etl_history_user b
on a.uid=b.uid
where a.day="20170101" and b.uid is null;
