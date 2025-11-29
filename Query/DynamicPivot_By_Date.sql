-- Create All Table Name as List
DECLARE @colTable VARCHAR(MAX)

SELECT
	@colTable = COALESCE(@colTable + ', ', '') + QUOTENAME(tblname)
FROM tblmast

-- Create Pivot Query
DECLARE @queryPivot VARCHAR(MAX)

SET @queryPivot = 
'
	SELECT 
		name, ' + @colTable + '
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
				b.bilcdate BETWEEN ''2025-11-27 20:00:00'' AND ''2025-11-28 19:59:00''
				AND o.ordfname like N''PR %''
			GROUP BY
				b.billid,
				b.bilcdate, 
				b.biltblnm,
				o.ordfname
		) d
	PIVOT
		(
			sum(qty)
			FOR tb IN (' + @colTable + ')
		) as pvt
	ORDER BY
		name
'

--PRINT @queryPivot
EXECUTE (@queryPivot)
