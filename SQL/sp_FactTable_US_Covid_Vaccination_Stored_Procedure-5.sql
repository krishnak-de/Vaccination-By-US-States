/********
*Developer: Krishna Kancharla
*Date: 05/16/2022
*Description: Store Procedure Bing Covid & Vaccinations Fact Table 
*********/

USE [Crimson_Vaccination];
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_FactTable_US_Coivd_Vaccination]
	AS
	BEGIN
	DROP TABLE IF EXISTS [dbo].[FactTable_US_Covid_Vaccination]
	CREATE TABLE [dbo].[FactTable_US_Covid_Vaccination]
	(    Calendar_key varchar(50)
		,Updated_month_year  varchar(50)
		,State_Key  varchar(50)
		,StateName  varchar(50)
		,latitude  varchar(50)
		,longitude  varchar(50)
		,Confirmed  bigint
		,deaths  bigint
		,recovered  bigint
		,Distributed_Doses bigint
		,Distributed_Janssen_Doses bigint
		,Distributed_Moderna_Doses bigint
		,Distributed_Pfizer_Doses bigint
		,Distributed_Unk_Manuf_Doses bigint
		,Admistered_Doses bigint
		,Administered_Janssen_Doses bigint
		,Administered_Moderna_Doses bigint
		,Administered_Pfizer_Doses bigint
		,Administered_Unk_Manuf_Doses bigint
		,Number_of_Fully_Vaccinated bigint
		,Number_of_Fully_Vaccinated_Janssen bigint
		,Number_of_Fully_Vaccinated_Moderna bigint
		,Number_of_Fully_Vaccinated_Pfizer bigint
		,Number_of_Fully_VaccinatedUnk_Manuf bigint
		,Percent_Population_Vaccinated bigint
	)

INSERT INTO [dbo].[FactTable_US_Covid_Vaccination]

--Aggreate the data into a view 
--and then insert the view into the created table/stored procedure
SELECT  --,D.CalendarDate
		D.CalendarYearMonthID as Calendar_key
		,Concat(month(C.updated),year(updated)) as Updated_month_year 
		,S.[State] as State_Key
		,C.adminregion1 as StateName
		,C.latitude
		,C.longitude
		,MAX(C.Confirmed) as Confirmed
		,MAX(C.deaths) as deaths
		,MAX(C.[Recovered]) as recovered
		,MAX(Distributed_Doses) As Distributed_Doses
		,MAX(Distributed_Janssen_Doses) As Distributed_Janssen_Doses
		,MAX(Distributed_Moderna_Doses) as Distributed_Moderna_Doses
		,MAX(Distributed_Pfizer_Doses) as Distributed_Pfizer_Doses
		,MAX(Distributed_Unk_Manuf_Doses) as Distributed_Unk_Manuf_Doses
		,MAX(Admistered_Doses) as Admistered_Doses
		,MAX(Administered_Janssen_Doses) as Administered_Janssen_Doses
		,MAX(Administered_Moderna_Doses) as Administered_Moderna_Doses
		,MAX(Administered_Pfizer_Doses) as Administered_Pfizer_Doses
		,MAX(Administered_Unk_Manuf_Doses) as Administered_Unk_Manuf_Doses
		,MAX(Number_of_Fully_Vaccinated) as Number_of_Fully_Vaccinated
		,MAX(Number_of_Fully_Vaccinated_Janssen) as Number_of_Fully_Vaccinated_Janssen
		,MAX(Number_of_Fully_Vaccinated_Moderna) as Number_of_Fully_Vaccinated_Moderna
		,MAX(Number_of_Fully_Vaccinated_Pfizer) as Number_of_Fully_Vaccinated_Pfizer
		,MAX(Number_of_Fully_VaccinatedUnk_Manuf) as Number_of_Fully_VaccinatedUnk_Manuf
		,MAX(Percent_Population_Vaccinated) as Percent_Population_Vaccinated
FROM (SELECT updated
		,adminregion1
		,adminregion2
		,latitude
		,longitude
		,Confirmed
		,deaths
		,Recovered
		FROM [Crimson_Vaccination].[dbo].[Bing-COVID19-Data]
		WHERE iso2 = 'US' --Select only the records in the US on the state level
		AND adminregion2 = '') AS C

INNER JOIN (Select * from [Crimson_Vaccination].[dbo].[DimState]) as S
		ON C.[adminregion1] = S.statename

INNER JOIN (SELECT [CalendarYearMonthID], Convert(date,[CalendarDate], 102) as CalendarDate FROM [Crimson_Vaccination].[dbo].[DimDate]) as D
		ON D.CalendarDate = C.Updated

INNER JOIN (SELECT 
convert(date, CAST([Date] as date), 102) as Vaccination_Date
			,[Location]
			,CAST(CAST([Distributed] as decimal) as bigint) as Distributed_Doses
			,CAST(CAST([Distributed_Janssen] as decimal) as bigint) as Distributed_Janssen_Doses
			,CAST(CAST([Distributed_Moderna] as decimal) as bigint) as Distributed_Moderna_Doses
			,CAST(CAST([Distributed_Pfizer] as decimal) as bigint) as Distributed_Pfizer_Doses
			,CAST(CAST([Distributed_Unk_Manuf] as decimal) as bigint) as Distributed_Unk_Manuf_Doses
			,CAST(CAST([Administered] as decimal) as bigint) as Admistered_Doses
			,CAST(CAST([Administered_Janssen] as decimal) as bigint) as Administered_Janssen_Doses
			,CAST(CAST([Administered_Moderna] as decimal) as bigint) as Administered_Moderna_Doses
			,CAST(CAST([Administered_Pfizer] as decimal) as bigint) as Administered_Pfizer_Doses
			,CAST(CAST([Administered_Unk_Manuf] as decimal) as bigint) as Administered_Unk_Manuf_Doses
			,CAST(CAST([Series_Complete_Yes] as decimal) as bigint) as Number_of_Fully_Vaccinated
			,CAST(CAST([Series_Complete_Janssen] as decimal) as bigint) as Number_of_Fully_Vaccinated_Janssen
			,CAST(CAST([Series_Complete_Moderna] as decimal) as bigint) as Number_of_Fully_Vaccinated_Moderna
			,CAST(CAST([Series_Complete_Pfizer] as decimal) as bigint) as Number_of_Fully_Vaccinated_Pfizer
			,CAST(CAST([Series_Complete_Unk_Manuf] as decimal) as bigint) as Number_of_Fully_VaccinatedUnk_Manuf
			,CAST([Series_Complete_Pop_Pct] as float) as Percent_Population_Vaccinated
			FROM [dbo].[COVID-19_US_Vaccinations]
			WHERE [Location] not in ('AS','BP2','DC','DD2','FM','GU','IH2','MH','MP','PR','RP','US','VA2','VI')
		) As V
		ON 
		C.[updated] = V.Vaccination_Date and V.[Location] = S.[State]
		GROUP BY D.[CalendarYearMonthID] 
		,concat(month([updated]),year([updated]))
		,S.[State]
		,[latitude] 
		,[longitude] 
		,[adminregion1]

		END
--SELECT * FROM [dbo].[FactTable_US_Covid_Vaccination]