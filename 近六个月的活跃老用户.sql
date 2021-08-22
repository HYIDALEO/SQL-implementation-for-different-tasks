--（近六个月，可以直接根据现在时间，把时间写死）
-- 月份可以用substr函数取，时间数据类型的前六位，即年和月

with target_user as
(
	select t1.six_month as six_month
          ,t1.qimei as qimei
          ,guid
	from 
	(
		select substr(statis_day,0,6) as six_month
	                 ,qimei
	                 ,guid
	    from u_wsd::t_c1
	    where statis_day>=20200701
    ) t1
    join
	(
		select substr(statis_day,0,6) as six_month
			   ,qimei
	    from t_ed_wide_c1
		where is_new = 0 and is_active > 0 and statis_day>=20200701
	) t2
	on t1.six_month = t2.six_month and t1.qimei = t2.qimei
	group by t1.six_month, t1.qimei, guid
)