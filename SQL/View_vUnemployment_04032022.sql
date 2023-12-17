/****** Object:  View [dbo].[vUnemployment]    Script Date: 4/3/2022 3:19:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************
*Developer: Tim Pauley
*Date: 04/29/2021
*Name: View for States
*Updates:
*	04/14 - Using a SELECT * FROM [dbo].[Unemployment]
*****************************/

CREATE VIEW [dbo].[vUnemployment]
--DROP VIEW vUnemployment
AS

SELECT * FROM [BingCovid19_String].[dbo].[Unemployment]
GO


