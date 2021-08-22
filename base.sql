-- 查看每个城市每天完成订单数，取消订单数，下单订单数，下单用户数
select 
	city_id,
	sum(case when order_status=5 then 1 else 0 end) as cnt_ord_succ_d, 
	sum(case when order_status=3 then 1 else 0 end) as cnt_ord_cacel_d, 
	sum(1) as cnt_ord_d, 
	count(distinct CUST_ID) as cnt_ord_user --用户ID去重 
FROM 
	dw.dw_order 
WHERE 
	dt='${day_01}' 
group by 
	city_id;