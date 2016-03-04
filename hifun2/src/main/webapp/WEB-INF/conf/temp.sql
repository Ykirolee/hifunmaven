-- 2016年03月01日22:08:19
create table hiPlayground(
	id int primary key auto_increment,
	username varchar(20) comment '用户名',
	content text comment '内容',
	status int default 0 comment '状态',
	remark varchar(50) comment '备注',
	createTime datetime comment '创建时间',
	createBy varchar(20) comment '创建人',
	updateTime datetime comment '修改时间',
	updateBy varchar(20) comment '修改人',
	effectiveFrom datetime comment '生效时间起',
	effectiveTo datetime comment '生效时间止'
);


-- 功能：查询连续签到天数SQL
-- 时间：2016年3月4日14:39:55
-- 描述：
-- 	1 判断昨天或今天是否有签到，没签到则连续签到为0
-- 	2 昨天或今天有签到
--	   2.1 签到表自身关联，查找前一天是否有签到
--	   2.2 查找前一天未签到的最后一条数据
--	   2.3 上一步查找的时间与最大签到时间之差为连续签到时间
SELECT t.username, CASE WHEN t.flag = 2 THEN 0 
-- when t.flag = 1 then 
-- DATEDIFF(DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(MAX(t.signTime1), '%Y-%m-%d'))
ELSE 
DATEDIFF(DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(MAX(t.signTime1), '%Y-%m-%d')) + 1 - t.flag END AS daynum FROM
(
	SELECT s1.`id`, s1.`username`, 
		DATE_FORMAT(s1.`signTime`, '%Y-%m-%d') signTime1, 
		DATE_FORMAT(s2.`signTime`, '%Y-%m-%d') signTime2,
		DATEDIFF(DATE_FORMAT(s1.`signTime`, '%Y-%m-%d'), DATE_FORMAT(s2.`signTime`, '%Y-%m-%d')) sign_datediff,
		CASE WHEN ins3.flag <= 1 THEN flag ELSE 2 END AS flag
	FROM signWeb s1
	LEFT JOIN signWeb s2 ON s1.`username` = s2.`username` 
		AND DATEDIFF(DATE_FORMAT(s1.`signTime`, '%Y-%m-%d'), DATE_FORMAT(s2.`signTime`, '%Y-%m-%d')) = 1
	LEFT JOIN (
		SELECT DATEDIFF(DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(MAX(s3.signTime), '%Y-%m-%d')) flag, s3.username 
			FROM signWeb s3
			WHERE 1 = 1
--			and s4.username = 'powlin'
			GROUP BY s3.username
	) ins3 ON ins3.username = s1.username
	WHERE 1 = 1 
--	and s1.`username` = 'powlin' 
	GROUP BY s1.`username`, s1.`id`
) t 
WHERE t.signTime2 IS NULL GROUP BY t.username;




