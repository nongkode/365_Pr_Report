CREATE FUNCTION fcTbPrQtyByDate 
(	
	@dtFrom datetime,
	@dtTo	datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		b.billid,
		b.bilcdate, 
		b.biltblnm,
		o.ordfname,
		sum(o.ordqty) as Qty
	FROM
		billctrl b 
		inner join ordtrans o 
			on o.ordbill = b.billid
	WHERE
		b.bilcdate BETWEEN @dtFrom AND @dtTo
		AND o.ordfname like N'PR %'
	GROUP BY
		b.billid,
		b.bilcdate, 
		b.biltblnm,
		o.ordfname
)
GO
