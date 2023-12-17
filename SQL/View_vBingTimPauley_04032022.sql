

/*****************************
*Developer: Tim Pauley
*Date: 04/29/2021
*Name: View for Bing Table ALL
*Updates:
*	04/29 - Updated columns to INT
	04/29 - Updated columns to BigINT got an error when trying to SUM
Answer:
The goal is to convert nvarchar(100) by casting it as a int. I used BigINT
sine INT was giving me an issue.
*****************************/

CREATE VIEW [dbo].[vBingCovidTimPauley]
--DROP VIEW vBingCovidTimPauley
AS
SELECT
	CAST([id] as INT) 'Id'
	, [updated]
	, CAST([confirmed] as bigint) 'Confirmed'
	--, CAST([confirmed_change] as bigint) 'Confirmed_Change'
	, CAST([deaths] as bigint) 'Deaths'
	--, CAST([deaths_change] as bigint) 'Deaths_change'
	, CAST([recovered] as bigint) 'Recovered'
	--, CAST([recovered_change] as bigint) 'Recovered_change'
	, [latitude]
	, [longitude]
	, [iso2]
	, [iso3]
	, [country_region]
	, [adminregion1]
	, [adminregion2]
FROM [dbo].[Bing-COVID19-Data]
GO


