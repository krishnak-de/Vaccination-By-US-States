/********
*Developer: Tim Pauley
*Date: 04/06/2022
*Description: Store Procedure Bing Covid Fact Table 2022
*	4/6 : cut dataset years
*********/

ALTER PROCEDURE sp_BingCovid_FactTable2022_tjpauley
	AS
	BEGIN
	DROP TABLE IF EXISTS [dbo].FactTable_Bing_2022
	CREATE TABLE [dbo].FactTable_Bing_2022
	(
		ID INT
		,Updated date
		,Confirmed bigint
		,Deaths bigint
		,[Recovered] bigint
		,[latitude] nvarchar(50)
		,[longitude] nvarchar(50)
		,[iso2] nvarchar(50)
		,[iso3] nvarchar(50)
		,[country_region] nvarchar(50)
		,[adminregion1] nvarchar(50)
		,[adminregion2] nvarchar(50)
	)

INSERT INTO  [dbo].FactTable_Bing_2022
SELECT
	*
FROM [dbo].[vBingCovidTimPauley]
WHERE Updated >= '2022-01-01'
	END