CREATE FUNCTION fcTbPrPivotByDate 
(	
	@dtFrom datetime,
	@dtTo	datetime
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		name, [A1], [A2]
	FROM 
		(
			SELECT
				o.ordfname as name,
				b.biltblnm as tb,
				sum(o.ordqty) as qty
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
		) d
	PIVOT
		(
			sum(qty)
			FOR tb IN ([A1],[A2])
		) as pvt
)
GO
