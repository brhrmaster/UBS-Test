CREATE DATABASE UBS_AG
GO

USE UBS_AG
GO

CREATE TABLE dbo.tbl_sectors(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(20) NOT NULL
)
GO

CREATE TABLE dbo.tbl_trades(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	value NUMERIC NOT NULL,
	sector_id int NOT NULL,
    CONSTRAINT FK_tbl_trades_tbl_sectors FOREIGN KEY (sector_id) REFERENCES tbl_sectors(id)
)
GO

CREATE TABLE dbo.tbl_trades_risks(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	value NUMERIC NOT NULL,
	sector varchar(20) NOT NULL,
	trade_category varchar(20) NOT NULL,
)
GO

CREATE TABLE dbo.tbl_risk_rules(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	title VARCHAR(20) NOT NULL,
	min_range NUMERIC NULL DEFAULT NULL,
	max_range NUMERIC NULL DEFAULT NULL,
	sector_id INT NOT NULL,
    CONSTRAINT FK_tbl_risk_rules_tbl_sectors FOREIGN KEY (sector_id) REFERENCES tbl_sectors(id)
)
GO