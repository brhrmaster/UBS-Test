CREATE DATABASE UBS_AG_v2
GO

USE UBS_AG_v2
GO


CREATE TABLE dbo.tbl_trades(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	value NUMERIC NOT NULL,
	client_sector varchar(20) NOT NULL
)
GO

CREATE TABLE dbo.tbl_trade_categories(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	trade_id INT NOT NULL,
	trade_category varchar(20) NOT NULL,
    CONSTRAINT FK_tbl_trade_categories_tbl_trades FOREIGN KEY (trade_id) REFERENCES dbo.tbl_trades(id)
)
GO
