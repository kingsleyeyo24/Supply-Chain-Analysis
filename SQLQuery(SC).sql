SELECT *
FROM [dbo].[DataCoSupplyChainDataset$]

-----------------------------------------------------------------------------------------------------

SELECT COUNT(*) AS TotalRows
FROM [dbo].[DataCoSupplyChainDataset$];

-----------------------------------------------------------------------------------------------------

SELECT COUNT(*) AS NullCount
FROM [dbo].[DataCoSupplyChainDataset$]
WHERE [Order Zipcode] IS NULL;

-----------------------------------------------------------------------------------------------------

DECLARE @sql NVARCHAR(MAX) = '';
DECLARE @table_name NVARCHAR(128) = 'DataCoSupplyChainDataset$';

-- Generate dynamic SQL to calculate NULL percentage for each column
SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, 
     COUNT(*) AS TotalRows, 
     SUM(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 ELSE 0 END) AS NullCount, 
     (SUM(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS NullPercentage 
     FROM [PortfolioProject].[dbo].[' + @table_name + '] 
     UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @table_name;

-- Remove last UNION ALL
SET @sql = LEFT(@sql, LEN(@sql) - 10);

-- Execute the dynamic SQL
EXEC sp_executesql @sql;

-----------------------------------------------------------------------------------------------------

ALTER TABLE [PortfolioProject].[dbo].[DataCoSupplyChainDataset$] 
DROP COLUMN [Product Description], 
            [F54], 
            [336267];

-----------------------------------------------------------------------------------------------------

ALTER TABLE [dbo].[DataCoSupplyChainDataset$]
DROP COLUMN [Order Zipcode];

-----------------------------------------------------------------------------------------------------

SELECT [Customer Zipcode]
FROM [dbo].[DataCoSupplyChainDataset$];

SELECT *
FROM [dbo].[DataCoSupplyChainDataset$]

-----------------------------------------------------------------------------------------------------

DELETE FROM [dbo].[DataCoSupplyChainDataset$]
WHERE [Customer Zipcode] IS NULL;

-----------------------------------------------------------------------------------------------------

DELETE FROM [dbo].[DataCoSupplyChainDataset$]
WHERE 
    [Product Card Id] IS NULL OR
    [Product Category Id] IS NULL OR
    [Product Image] IS NULL OR
    [Product Name] IS NULL OR
    [Product Price] IS NULL OR
    [Product Status] IS NULL OR
    [shipping date (DateOrders)] IS NULL OR
    [Shipping Mode] IS NULL;
	
-----------------------------------------------------------------------------------------------------

ALTER TABLE [DataCoSupplyChainDataset$]
ADD [Customer Name] NVARCHAR(255);

UPDATE [DataCoSupplyChainDataset$]
SET [Customer Name] = [Customer Fname] + ' ' + [Customer Lname];

-----------------------------------------------------------------------------------------------------

SELECT DISTINCT [Type]
FROM [DataCoSupplyChainDataset$];

-----------------------------------------------------------------------------------------------------

ALTER TABLE [dbo].[DataCoSupplyChainDataset$]
DROP COLUMN [Customer Password],
			[Customer Email],
			[Customer Fname],
			[Customer Lname];

ALTER TABLE [dbo].[DataCoSupplyChainDataset$]
DROP COLUMN [Product Status];

SELECT *
FROM [DataCoSupplyChainDataset$]