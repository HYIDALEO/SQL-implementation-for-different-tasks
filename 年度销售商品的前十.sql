-- 在select查找的数据中，使用row_number函数，并且使用partition对时间分区，
-- 和使用order by对于商品进行排序，使得row_number的值就成为了这个时间区的商品销售名次


select
 
       ref_host,
 
       ref_host_cnts,
 
       concat(month,hour,day),
 
       row_number() over (partition by concat(month,hour,day) order by ref_host_cnts desc) as od
 
from
 
       dw_ref_host_visit_cnts_h