USE [Crimson_Vaccination]
GO

/****** Object:  StoredProcedure [dbo].[Create_BingCovid_DimDate]    Script Date: 5/14/2022 9:49:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_BingCovid_DimDate]
	AS
	BEGIN
DROP TABLE IF EXISTS DimDate
CREATE -- Dates Dimension  
 TABLE DimDate
( CalendarDateKey int Not Null CONSTRAINT [pkDimDates] PRIMARY KEY
, CalendarDateName nvarchar(50) Not Null 
, CalendarYearMonthID int Not Null 
, CalendarYearMonthName nvarchar(50) Not Null 
, CalendarYearQuarterID int Not Null 
, CalendarYearQuarterName nvarchar(50) Not Null 
, CalendarYearID int Not Null 
, CalendarYearName nvarchar(50) Not Null
, CalendarDate Date Not Null  
, FiscalDate Date Not Null 
);


-- Fill DimDates Lookup Table
-- Step a: Declare variables use in processing
SET NOCOUNT ON;
Declare @StartDate date; 
Declare @EndDate date;

-- Step b:  Fill the variable with values for the range of years needed
--@StartDate = '01-01-2020';
--@EndDate = '12-31-2022';

Select @StartDate = '01/01/' + Cast(Year(Min(convert(date, CAST([Updated] as date), 102))) as nvarchar(50))
	From [dbo].[Bing-COVID19-Data];
Select @EndDate = '12/31/' +  Cast(Year(Max(convert(date, CAST([Updated] as date), 102))) as nvarchar(50))
	From [dbo].[Bing-COVID19-Data];

-- Step c:  Use a while loop to add dates to the table
Declare @DateInProcess datetime = @StartDate;

While @DateInProcess <= @EndDate
	Begin
	--Add a row into the date dimension table for this date
		Insert Into  [Crimson_Vaccination].[dbo].[DimDate] 
		( [CalendarDateKey]
		, [CalendarDateName]
		, [CalendarYearMonthID]
		, [CalendarYearMonthName]
		, [CalendarYearQuarterID]
		, [CalendarYearQuarterName]
		, [CalendarYearID]
		, [CalendarYearName]
		, [CalendarDate]
		, [FiscalDate]
		)
		Values ( 
		  Convert(nvarchar(50), @DateInProcess, 112) -- [CalendarDateKey]
		, DateName( weekday, @DateInProcess ) + ', ' + Convert(nvarchar(50), @DateInProcess, 110) --  [CalendarDateName]
		, Left(Convert(nvarchar(50), @DateInProcess, 112), 6) -- [CalendarYearMonthKey]
		, DateName( month, @DateInProcess ) -- [CalendarYearMonthName]
		, Cast( Year(@DateInProcess) as nVarchar(50)) + '0' + DateName( quarter, @DateInProcess)   --[CalendarYearQuarterKey]
		, 'Q' + DateName( quarter, @DateInProcess ) + '-' + Cast( Year(@DateInProcess) as nVarchar(50)) --[CalendarYearQuarterName]
		, Year( @DateInProcess ) -- [CalendarYearKey] 
		, Cast( Year( @DateInProcess) as nVarchar(50) ) -- [CalendarYearName]
		,convert([Date], @DateInProcess,101) 	-- [FiscalDateKey] 			   
		,Convert([Date], DateAdd(mm,-6,@DateInProcess),101) 	-- [FiscalDateKey] 
		);  
		-- Add a day and loop again
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End
SET NOCOUNT ON;

SELECT * FROM DimDate

END
GO

