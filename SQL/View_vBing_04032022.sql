/****** Object:  View [dbo].[vBing_COVID_EOmonth]    Script Date: 4/3/2022 3:14:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[vBing_COVID_EOmonth] AS
SELECT
	 [Updated] = CAST([updated] AS date)
	, [Latitude] = CAST([latitude] AS float)
	, [Longitude] = CAST([longitude] AS float)
	, [iso_subdivision] = RIGHT([iso_subdivision], 2)
	, [admin_region_1] as state
	, [admin_region_2] as county
	, [Confirmed] = CAST([confirmed] AS bigint)
	, [Deaths] = CAST([deaths] AS bigint)
	, [Recovered] = CAST([recovered] AS bigint)

FROM [BingCovid19_String].[dbo].[BingCovid19]
where 
	country_region = 'United States'
	and updated IN (SELECT DISTINCT EOMONTH(CAST([updated] AS date)) from  [BingCovid19_String].[dbo].[BingCovid19])
GO


