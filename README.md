## **Vaccination-Status-By-US-State**
The public data used in this project is about US Vaccination status for each state.
There is a ETL process applied where data is first extracted from US government publicly available dataset. 
There are three separate csv files used as part of this process: 
  1) USVaccination.csv
  2) CovidFiles.csv
  3) USA States

Then transformations are applied using SQL with stored procedures to clean and format the data, especially for US States abbervations using SQL CASE statement for each state.
Next Kimball dimensional data modeling framework is used to create Dimensions and Fact tables as part of Star Schema to store the data at the right granularity for analytical pursposes.
Views are created from the base tables to limit the access and for data privacy purposes.
All the SQL code is uploaded from MS SQL Server to Azure database.
Tableau is used to create intreactive reports by creating data model in the tableau using Views stored in Azure database.




![Data Architect Diagram](https://github.com/krishnak-de/Vaccination-By-US-States/assets/130612282/7b4c1fb7-1551-4b70-8854-c71362634f53)





