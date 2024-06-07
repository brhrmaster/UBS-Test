USE UBS_AG_v2
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
    DECLARE @trade_category VARCHAR(20)
    DECLARE @pivot_value INT = 1000000

    SET @trade_category = (
        SELECT CASE
            WHEN @value < @pivot_value AND @client_sector = 'Public' THEN 'LOWRISK'
            WHEN @value > @pivot_value AND @client_sector = 'Public' THEN 'MEDIUMRISK'
            WHEN @value > @pivot_value AND @client_sector = 'Private' THEN 'HIGHRISK'
            ELSE 'UNKNOWN'
        END
    )

    RETURN @trade_category
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
        dbo.get_trade_category(trade.value, trade.client_sector) AS trade_category
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

-- EXEC dbo.insert_all_trades
-- EXEC dbo.show_all_trades
-- EXEC dbo.process_trade_categories
-- EXEC dbo.show_output
-- EXEC dbo.show_output 1