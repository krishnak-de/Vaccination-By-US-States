## **Vaccination-Status-By-US-State**
1. The public data used in this project is about Covid 19 US Vaccination and Unemployment status for each state.
1. There is a ETL process applied where data is first extracted from US government publicly available dataset. 
1. Then transformations are applied using SQL with stored procedures to clean and format the data, especially for US States abbervations using SQL CASE statement for each state.
1. Next Kimball dimensional data modeling framework is used to create Dimensions and Fact tables as part of Star Schema to store the data at the right granularity for analytical pursposes.
1. Views are created from the base tables to limit the access and for data privacy purposes.
1. All the SQL code is uploaded from MS SQL Server to Azure database.
1. Tableau is used to create intreactive reports by creating data model in the tableau using Views stored in Azure database.
1. There are three separate csv files used as part of this process: 
    1) USVaccination.csv
    2) CovidFiles.csv
    3) USA States




![Data Architect Diagram](https://github.com/krishnak-de/Vaccination-By-US-States/assets/130612282/7b4c1fb7-1551-4b70-8854-c71362634f53)





