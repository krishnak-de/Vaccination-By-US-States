/****** Object:  View [dbo].[vBingCovidALL]    Script Date: 4/3/2022 3:16:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************
*Developer: Tim Pauley
*Date: 04/14/2021
*Name: View for Bing Table ALL
*Updates:
*	04/14 - Updated columns to INT
	04/15 - Updated columns to BigINT got an error when trying to SUM
*****************************/

CREATE VIEW [dbo].[vBingCovidALL]
--DROP VIEW vBingCovidALL
AS
SELECT
	CAST([id] as INT) 'Id'
	, [updated]
	, CAST([confirmed] as bigint) 'Confirmed'
	, CAST([confirmed_change] as bigint) 'Confirmed_Change'
	, CAST([deaths] as bigint) 'Deaths'
	, CAST([deaths_change] as bigint) 'Deaths_change'
	, CAST([recovered] as bigint) 'Recovered'
	, CAST([recovered_change] as bigint) 'Recovered_change'
	, [latitude]
	, [longitude]
	, [iso2]
	, [iso3]
	, [country_region]
	, [admin_region_1]
	, [iso_subdivision]
	, [admin_region_2]
	, [load_time]
FROM [BingCovid19_String].[dbo].[BingCovid19]
GO


