USE [Crimson_Vaccination]
GO

/****** Object:  StoredProcedure [dbo].[Create_BingCovid_DimState]    Script Date: 5/22/2022 9:04:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********
*Developer: Krishna Kancharla
*Date: 05/23/2022
*********/

CREATE PROCEDURE [dbo].[sp_BingCovid_DimState]
	AS
	BEGIN
	DROP TABLE IF EXISTS [dbo].[DimState]
	CREATE TABLE [dbo].DimState
	(
	[State] nvarchar(10)
	,[StateName] nvarchar(50)
	)

INSERT INTO  [dbo].[DimState]

SELECT DISTINCT
--substring([AdminRegion1],4,len([AdminRegion1])) As [State],
CASE WHEN [adminregion1] = 'Alaska' THEN 'AK'
WHEN [adminregion1] = 'Alabama' THEN 'AL'
WHEN [adminregion1] = 'Arkansas' THEN 'AR'
WHEN [adminregion1] =  'Arizona' THEN 'AZ'
WHEN [adminregion1] = 'California' THEN 'CA'
WHEN [adminregion1] = 'Colorado' THEN 'CO'
WHEN [adminregion1] = 'Connecticut' THEN 'CT'
WHEN [adminregion1] = 'District of Columbia' THEN 	'DC'
WHEN [adminregion1] = 'Delaware' THEN 'DE'
WHEN [adminregion1] = 'Florida' THEN 'FL'
WHEN [adminregion1] = 'Georgia'	THEN 'GA'
WHEN [adminregion1] = 'Hawaii'	THEN 'HI'
WHEN [adminregion1] = 'Iowa' THEN 'IA'
WHEN [adminregion1] = 'Idaho' THEN 	'ID'
WHEN [adminregion1] = 'Illinois' THEN 	'IL'
WHEN [adminregion1] = 'Indiana' THEN 'IN'
WHEN [adminregion1] = 'Kansas' THEN 'KS'
WHEN [adminregion1] = 'Kentucky' THEN 'KY'
WHEN [adminregion1] = 'Louisiana' THEN	'LA'
WHEN [adminregion1] = 'Massachusetts' THEN 'MA'
WHEN [adminregion1] = 'Maryland' THEN 'MD'
WHEN [adminregion1] = 'Maine' THEN 	'ME'
WHEN [adminregion1] = 'Michigan' THEN 'MI'
WHEN [adminregion1] = 'Minnesota' THEN	'MN'
WHEN [adminregion1] = 'Missouri' THEN	'MO'
WHEN [adminregion1] = 'Mississippi' THEN	'MS'
WHEN [adminregion1] = 'Montana' THEN	'MT'
WHEN [adminregion1] = 'North Carolina' THEN	'NC'
WHEN [adminregion1] = 'North Dakota' THEN	'ND'
WHEN [adminregion1] = 'Nebraska' THEN	'NE'
WHEN [adminregion1] = 'New Hampshire' THEN	'NH'
WHEN [adminregion1] = 'New Jersey' THEN	'NJ'
WHEN [adminregion1] = 'New Mexico'THEN	'NM'
WHEN [adminregion1] = 'Nevada' THEN	'NV'
WHEN [adminregion1] = 'New York' THEN 'NY'
WHEN [adminregion1] = 'Ohio' THEN	'OH'
WHEN [adminregion1] = 'Oklahoma' THEN 	'OK'
WHEN [adminregion1] = 'Oregon' THEN 	'OR'
WHEN [adminregion1] = 'Pennsylvania' THEN 	'PA'
WHEN [adminregion1] = 'Rhode Island' THEN 	'RI'
WHEN [adminregion1] = 'South Carolina' THEN 'SC'
WHEN [adminregion1] = 'South Dakota' THEN 	'SD'
WHEN [adminregion1] = 'Tennessee' THEN 	'TN'
WHEN [adminregion1] = 'Texas' THEN 'TX'
WHEN [adminregion1] = 'Utah' THEN 'UT'
WHEN [adminregion1] = 'Virginia' THEN 	'VA'
WHEN [adminregion1] = 'Virgin Islands' THEN	'VI'
WHEN [adminregion1] = 'Vermont' THEN 'VT'
WHEN [adminregion1] = 'Washington' THEN 	'WA'
WHEN [adminregion1] = 'Wisconsin'	THEN 'WI'
WHEN [adminregion1] = 'West Virginia' THEN	'WV'
WHEN [adminregion1] = 'Wyoming'	THEN 'WY'
ELSE '' END AS [State]
,[adminregion1] as [StateName]
 FROM [Crimson_Vaccination].[dbo].[Bing-COVID19-Data]
WHERE [iso2] = 'US'
AND [adminregion1] <> ''

--This is what I did to find the 51 states
--SELECT TOP 10000 * FROM [dbo].[FactTable_Bing_2022]
--WHERE ISO2 = 'US'
END
SELECT * 
FROM [dbo].[DimState]


