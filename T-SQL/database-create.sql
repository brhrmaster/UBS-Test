CREATE DATABASE UBS_AG
GO

USE UBS_AG
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

CREATE TABLE dbo.tbl_risk_rules(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	title VARCHAR(20) NOT NULL,
	min_range INT NULL DEFAULT NULL,
	max_range INT NULL DEFAULT NULL,
	client_sector VARCHAR(20) NOT NULL
)
GO

INSERT INTO dbo.tbl_risk_rules(title, min_range, max_range, client_sector)
VALUES 
    ('LOWRISK', NULL, 1000000, 'Public'),
    ('MEDIUMRISK', 1000000, NULL, 'Public'),
    ('HIGHRISK', 1000000, NULL, 'Private')

GO

CREATE PROCEDURE dbo.insert_trade(@value INT, @client_sector VARCHAR(20)) AS
BEGIN
    IF NOT EXISTS (SELECT id
                    FROM dbo.tbl_trades
                    WHERE value = @value AND client_sector = @client_sector)
    BEGIN
        INSERT INTO dbo.tbl_trades(value, client_sector)
        VALUES(@value, @client_sector);
    END
END
GO

CREATE FUNCTION dbo.get_trade_category(@value INT, @client_sector VARCHAR(20))
RETURNS varchar(10)
BEGIN
    RETURN (
        SELECT
            temp_risk.title AS trade_category
        FROM (
            SELECT
                rr.title,
                (
                    CASE WHEN
                        rr.min_range IS NOT NULL 
                        AND @value > rr.min_range
                    THEN 1
                    ELSE 0
                    END
                ) AS MIN_RULE,
                (
                    CASE WHEN
                        rr.max_range IS NOT NULL 
                        AND @value < rr.max_range
                    THEN 1
                    ELSE 0
                    END
                ) AS MAX_RULE
            FROM
                dbo.tbl_risk_rules AS rr
            WHERE
                rr.client_sector = @client_sector
        ) AS temp_risk
        WHERE
            (temp_risk.MIN_RULE = 1 and temp_risk.MAX_RULE = 0) 
            OR (temp_risk.MIN_RULE = 0 and temp_risk.MAX_RULE = 1)
    )
END
GO


CREATE PROCEDURE dbo.show_all_trades AS
BEGIN 
    SELECT trades.value AS Value, trades.client_sector AS ClientSector FROM dbo.tbl_trades AS trades
END
GO

CREATE PROCEDURE dbo.process_trade_categories
AS
BEGIN
    DECLARE @trade_id INT
    DECLARE @trade_category VARCHAR(20)
    
    DECLARE trade_cursor CURSOR FOR
    SELECT
        trade.id AS trade_id,
        ISNULL(dbo.get_trade_category(trade.value, trade.client_sector), 'UNKNOWN') AS trade_category
    FROM 
        dbo.tbl_trades AS trade;

    DELETE FROM dbo.tbl_trade_categories;

    OPEN trade_cursor
    FETCH NEXT FROM trade_cursor INTO @trade_id, @trade_category

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO dbo.tbl_trade_categories(trade_id, trade_category)
        VALUES(@trade_id, @trade_category);

        FETCH NEXT FROM trade_cursor INTO @trade_id, @trade_category
    END

    CLOSE trade_cursor
    DEALLOCATE trade_cursor
END
GO

CREATE PROCEDURE dbo.show_output(@complete BIT = 0) AS
BEGIN
    IF @complete = 0
        BEGIN
            SELECT tc.trade_category AS TradeCategory
            FROM dbo.tbl_trade_categories AS tc;
        END
    ELSE
        BEGIN
            SELECT
                trade.value AS Value,
                trade.client_sector AS ClientSector,
                tc.trade_category AS TradeCategory
            FROM dbo.tbl_trade_categories AS tc
            INNER JOIN dbo.tbl_trades AS trade
            ON tc.trade_id = trade.id;
        END
END
GO


CREATE PROCEDURE dbo.insert_all_trades AS
BEGIN
    EXEC dbo.insert_trade @value = 2000000, @client_sector = "Private"
    EXEC dbo.insert_trade @value = 400000, @client_sector = "Public"
    EXEC dbo.insert_trade @value = 500000, @client_sector = "Public"
    EXEC dbo.insert_trade @value = 3000000, @client_sector = "Public"
END
GO

EXEC dbo.insert_all_trades
EXEC dbo.show_all_trades
EXEC dbo.process_trade_categories
EXEC dbo.show_output
EXEC dbo.show_output 1