SELECT
	b.billid,
	b.bilcdate, 
	b.biltblnm,
	o.ordfood,
	o.ordfname,
	sum(o.ordqty) as Qty
FROM
	billctrl b 
	inner join ordtrans o 
		on o.ordbill = b.billid
WHERE
	b.bilcdate BETWEEN '2025-11-26 20:00:00' AND '2025-11-28 19:59:00'
	AND o.ordfname like N'PR %'
GROUP BY
	b.billid,
	b.bilcdate, 
	b.biltblnm,
	o.ordfood,
	o.ordfname
ORDER BY
	b.billid,
	o.ordfname