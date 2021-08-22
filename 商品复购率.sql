-- 需求列出的商品的7日,15日,30复购率，目的了解这几款商品的周期. 
-- 计算口径:当日购买部分商品的用户数/7日重复购买此商品的用户数。 
-- 每天查看每个城市每个商品当日购买用户数，7日15日30日复购率。
SELECT 
	t3.atdate AS cdate,
	t3.city_id,
	t3.goods_id, 
	COUNT(DISTINCT CASE WHEN days=0 THEN t3.cust_id END) AS cnt_buy_cust_d, 
	COUNT(DISTINCT CASE WHEN days>0 AND days<=7 THEN t3.cust_id END) AS cnt_buy_cust_7_d, 
	COUNT(DISTINCT CASE WHEN days>0 AND days<=15 THEN t3.cust_id END) AS cnt_buy_cust_15_d, 
	COUNT(DISTINCT CASE WHEN days>0 AND days<=30 THEN t3.cust_id END) AS cnt_buy_cust_30_d 
FROM 
( 
	SELECT 
		t1.atdate,
		t1.city_id,
		t1.cust_id,
		t1.goods_id, 
		DATEDIFF(t2.atdate, t1.atdate) days 
	FROM (
	--查出成功订单的。 
		SELECT 
			o.order_date AS atdate,
			o.city_id, 
			o.cust_id,
			og.goods_id 
		FROM 
			dw.dw_order o 
		INNER JOIN 
			dw.dw_order_goods og 
		ON 
			o.order_id=og.order_id AND 
			o.ORDER_STATUS = 5 AND 
			og.source_id=1 AND 
			o.dt = '20151010' 
	) t1 
	INNER JOIN (
	--查看n天后成功订单的 
		SELECT 
			o.order_date AS atdate,
			o.city_id, 
			o.cust_id,
			og.goods_id, 
			og.goods_name 
		FROM 
			dw.dw_order o 
		INNER JOIN 
			dw.dw_order_goods og 
		ON 
			o.order_id=og.order_id AND 
			o.ORDER_STATUS = 5 AND 
			og.source_id=1 
	) t2 
	ON 
t1.cust_id=t2.cust_id AND 
t1.goods_id=t2.goods_id 
) t3 
GROUP BY 
	t3.atdate,
	t3.city_id,
	t3.goods_id;