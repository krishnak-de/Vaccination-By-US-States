USE [Crimson_Vaccination]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********
*Developer: Krishna Kancharla
*Date: 05/23/2022
*Description: Store Procedure Bing Covid & Vaccinations Fact Table 
*********/

CREATE PROCEDURE [dbo].[sp_Bing_Coivd_19_Data]
	AS
	BEGIN
	DROP TABLE IF EXISTS [Crimson_Vaccination].[dbo].[FactTable_Bing_Covid]
	CREATE TABLE [Crimson_Vaccination].[dbo].[FactTable_Bing_Covid]
				([ID] nvarchar(50), 
				[Updated] date, 
				[Confirmed] bigint, 
				[ConfirmedChange] bigint, 
				[Deaths] bigint, 
				[DeathsChange] bigint, 
				[Recovered] bigint, 
				[RecoveredChange] bigint, 
				[Latitude] nvarchar(50), 
				[Longitude] nvarchar(50), 
				[ISO2]  nvarchar(50), 
				[ISO3]  nvarchar(50), 
				[Country_Region] nvarchar(50), 
				[AdminRegion1] nvarchar(50), 
				[AdminRegion2] nvarchar(50)
				)

INSERT INTO [Crimson_Vaccination].[dbo].[FactTable_Bing_Covid]

Select [ID], 
[Updated], 
[Confirmed], 
[ConfirmedChange], 
[Deaths], 
[DeathsChange], 
[Recovered], 
[RecoveredChange], 
[Latitude], 
[Longitude], 
[ISO2], 
[ISO3], 
[Country_Region], 
[AdminRegion1], 
[AdminRegion2]
FROM [Crimson_Vaccination].[dbo].[Bing-COVID19-Data]
 WHERE [updated] is not null 
 AND [updated] <> ''

END

--SELECT * FROM [dbo].[FactTable_Bing_Covid]
