/********
*Developer: Krishna Kancharla
*Date: 05/23/2022
*Description: Store Procedure Bing Covid & Vaccinations Fact Table 
*********/

USE [Crimson_Vaccination];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_FactVaccination]
	AS
	BEGIN
	DROP TABLE IF EXISTS [dbo].[FactTable_US_Vaccination]
	CREATE TABLE [dbo].[FactTable_US_Vaccination]

	(Vaccination_Date  date,
	StateID  nvarchar(50),
	Distributed_Doses   bigint,
	Distributed_Janssen_Doses  bigint,
	Distributed_Moderna_Doses  bigint,
	Distributed_Pfizer_Doses  bigint,
	Distributed_Unk_Manuf_Doses  bigint,
	Admistered_Doses  bigint,
	Administered_Janssen_Doses  bigint,
	Administered_Moderna_Doses  bigint,
	Administered_Pfizer_Doses  bigint,
	Administered_Unk_Manuf_Doses  bigint,
	Number_of_Fully_Vaccinated  bigint,
	Number_of_Fully_Vaccinated_Janssen  bigint,
	Number_of_Fully_Vaccinated_Moderna  bigint,
	Number_of_Fully_Vaccinated_Pfizer  bigint,
	Number_of_Fully_VaccinatedUnk_Manuf  bigint,
	Percent_Population_Vaccinated  float
	)

INSERT INTO [dbo].[FactTable_US_Vaccination]
SELECT 
convert(date, CAST([Date] as date), 102) as Vaccination_Date
		,CAST([Location] as nvarchar(50)) as StateID
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
	FROM [Crimson_Vaccination].[dbo].[COVID-19_US_Vaccinations]
WHERE [Location] not in ('AS','BP2','DC','DD2','FM','GU','IH2','MH','MP','PR','RP','US','VA2','VI')

END

--SELECT * FROM [Crimson_Vaccination].[dbo].[COVID-19_US_Vaccinations]