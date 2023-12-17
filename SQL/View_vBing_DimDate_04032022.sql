/********
*Developer: Tim Pauley
*Date: 04/06/2022
*Description: Store Procedure Dim Date
*	4/6 : Did a distinct on counry region
*********/

ALTER PROCEDURE sp_BingCovid_DimCountry_tjpauley
	AS
	BEGIN

DROP TABLE IF EXISTS #DimDate

DECLARE @StartDate  date = '20220101'; --this is the start dat

DECLARE @CutoffDate date = GetDate() --this is the end date

;WITH seq(n) AS --then we use fancy boiler plate logic
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
)


SELECT *
INTO #DimDate
FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0)

SELECT * FROM #DimDate

END
