/****** Object:  View [dbo].[vStates]    Script Date: 4/3/2022 3:17:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vStates]
--DROP VIEW vStates
AS

SELECT *, 'United States' 'Country' FROM [BingCovid19_String].[dbo].[States]
GO


